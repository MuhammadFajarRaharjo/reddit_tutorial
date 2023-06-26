import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_tutorial/features/auth/controller/auth_controller.dart';
import 'package:reddit_tutorial/models/user_model.dart';
import 'package:routemaster/routemaster.dart';

import '../../../core/constants/firebase_constatns.dart';
import '../../../core/enum.dart';
import '../../../core/providers/storage_repository_provider.dart';
import '../../../core/utils.dart';
import '../../../models/post_model.dart';
import '../reposiroty/user_profile_repository.dart';

final userProfileControllerProvider =
    StateNotifierProvider<UserProfileController, bool>((ref) {
  return UserProfileController(
    userProfileRepository: ref.watch(userProfileRepositoryProvider),
    ref: ref,
    storage: ref.watch(storageRepositoryProvider),
  );
});

final postsUserProvider = StreamProvider.family((ref, String uid) {
  return ref.read(userProfileControllerProvider.notifier).getUserPosts(uid);
});

class UserProfileController extends StateNotifier<bool> {
  final UserProfileRepository _userProfileRepository;
  final Ref _ref;
  final StorageRepository _storage;

  UserProfileController({
    required UserProfileRepository userProfileRepository,
    required Ref ref,
    required StorageRepository storage,
  })  : _userProfileRepository = userProfileRepository,
        _ref = ref,
        _storage = storage,
        super(false);

  void editUserProfile({
    required String name,
    required File? profileFile,
    required File? bannerFile,
    required BuildContext context,
  }) async {
    state = true;

    // get userModel form provider
    UserModel user = _ref.read(userProvider)!;

    // checking profile file
    if (profileFile != null) {
      // store to firebase storage
      final profilePath = await _storage.storeFile(
        path: FirebaseConstant.userStrgProfile,
        id: user.uid,
        file: profileFile,
      );

      // update user
      profilePath.fold(
        (l) => showSnackBar(context, l.message),
        (path) => user = user.copyWith(profileUrl: path),
      );
    }

    // checking banner file
    if (bannerFile != null) {
      // store to firebase storage
      final bannerPath = await _storage.storeFile(
        path: FirebaseConstant.userStrgBanner,
        id: user.uid,
        file: bannerFile,
      );

      // update user
      bannerPath.fold(
        (l) => showSnackBar(context, l.message),
        (path) => user = user.copyWith(banner: path),
      );
    }

    // set name to userModel
    user = user.copyWith(name: name);

    // update user in firestore
    final res = await _userProfileRepository.editProfile(user);

    res.fold(
      (l) {
        showSnackBar(context, l.message);
        state = false;
      },
      (_) {
        // update userModelProvider
        _ref.read(userProvider.notifier).update((_) => user);
        Routemaster.of(context).pop();
        state = false;
      },
    );
  }

  Stream<List<PostModel>> getUserPosts(String uid) =>
      _userProfileRepository.getUserPosts(uid);

  Future<void> updateUserKarma(UserKarma karma) async {
    UserModel user = _ref.read(userProvider)!;
    user = user.copyWith(karma: user.karma + karma.karma);

    final res = await _userProfileRepository.updateUserKarma(user);
    res.fold(
      (l) => null,
      (r) => _ref.read(userProvider.notifier).update((state) => user),
    );
  }
}
