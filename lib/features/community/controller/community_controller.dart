import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_tutorial/core/constants/firebase_constatns.dart';
import 'package:reddit_tutorial/core/providers/storage_repository_provider.dart';
import 'package:reddit_tutorial/features/auth/controller/auth_controller.dart';
import 'package:reddit_tutorial/features/community/repository/communitiy_repository.dart';
import 'package:reddit_tutorial/models/community_model.dart';
import 'package:routemaster/routemaster.dart';

import '../../../core/constants/constants.dart';
import '../../../core/utils.dart';
import '../../../models/post_model.dart';

final communityControllerProvider =
    StateNotifierProvider<CommunityController, bool>((ref) {
  return CommunityController(
    communityRepository: ref.watch(communityRepositoryProvider),
    ref: ref,
    storage: ref.watch(storageRepositoryProvider),
  );
});

final userCommunityProvider = StreamProvider<List<CommunityModel>>((ref) {
  final controller = ref.watch(communityControllerProvider.notifier);
  return controller.getUserCommunity();
});

final getCommunityProvider = StreamProvider.family((ref, String name) {
  return ref
      .watch(communityControllerProvider.notifier)
      .getCommunityByName(name);
});

final searchCommunityProvider = StreamProvider.family((ref, String query) {
  return ref.watch(communityControllerProvider.notifier).searchCommunity(query);
});

final communityPostsProvider = StreamProvider.family((ref, String name) {
  return ref.read(communityControllerProvider.notifier).getCommunityPosts(name);
});

class CommunityController extends StateNotifier<bool> {
  final CommunityRepository _communityRepository;
  final Ref _ref;
  final StorageRepository _storage;

  CommunityController({
    required CommunityRepository communityRepository,
    required Ref ref,
    required StorageRepository storage,
  })  : _communityRepository = communityRepository,
        _ref = ref,
        _storage = storage,
        super(false);

  Future<void> createCommunity(String name, BuildContext context) async {
    state = true;

    final uid = _ref.read(userProvider)?.uid ?? '';
    final community = CommunityModel(
      id: name,
      name: name,
      avatar: Constants.avatarDefault,
      banner: Constants.bannerDefault,
      members: [uid],
      mods: [uid],
    );

    final res = await _communityRepository.createCommunity(community);
    state = false;
    res.fold((l) => showSnackBar(context, l.message), (r) {
      showSnackBar(context, 'Community create succesfully!');
      Routemaster.of(context).pop();
    });
  }

  Future<void> updateMembersCommunity(
      CommunityModel community, BuildContext context) async {
    final uid = _ref.read(userProvider)?.uid;
    final bool join;
    if (community.members.contains(_ref.read(userProvider)?.uid)) {
      join = false;
    } else {
      join = true;
    }
    final res = await _communityRepository.updateMembersCommunity(
      communityName: community.name,
      uid: uid!,
      join: join,
    );

    res.fold((l) => showSnackBar(context, l.message), (r) {
      if (join) {
        showSnackBar(context, 'Join Community Successfully!');
      } else {
        showSnackBar(context, 'leave Community Successfully!');
      }
    });
  }

  Stream<List<CommunityModel>> getUserCommunity() {
    final uid = _ref.read(userProvider)!.uid;
    return _communityRepository.getUserCommunity(uid);
  }

  Stream<CommunityModel> getCommunityByName(String name) =>
      _communityRepository.getCommunityByName(name);

  void editCommunity({
    required CommunityModel community,
    required File? profileFile,
    required File? bannerFile,
    required BuildContext context,
  }) async {
    state = true;
    // checking profile file
    if (profileFile != null) {
      // store to firebase storage
      final profilePath = await _storage.storeFile(
        path: FirebaseConstant.comStrgProfile,
        id: community.name,
        file: profileFile,
      );

      // update community
      profilePath.fold(
        (l) => showSnackBar(context, l.message),
        (path) => community = community.copyWith(avatar: path),
      );
    }

    // checking banner file
    if (bannerFile != null) {
      // store to firebase storage
      final bannerPath = await _storage.storeFile(
        path: FirebaseConstant.comStrgBanner,
        id: community.name,
        file: bannerFile,
      );

      // update community
      bannerPath.fold(
        (l) => showSnackBar(context, l.message),
        (path) => community = community.copyWith(banner: path),
      );
    }

    // update community in firestore
    final res = await _communityRepository.editCommunity(community);

    res.fold(
      (l) {
        showSnackBar(context, l.message);
        state = false;
      },
      (_) {
        Routemaster.of(context).pop();
        showSnackBar(context, 'Community update successfully!');
        state = false;
      },
    );
  }

  Future<void> addMods(
      String communityName, List<String> uids, BuildContext context) async {
    final res = await _communityRepository.addMods(communityName, uids);
    res.fold(
      (l) => showSnackBar(context, l.message),
      (_) => Routemaster.of(context).pop(),
    );
  }

  Stream<List<CommunityModel>> searchCommunity(String query) {
    return _communityRepository.searchCommunity(query);
  }

  Stream<List<PostModel>> getCommunityPosts(String name) {
    return _communityRepository.getCommunityPosts(name);
  }
}
