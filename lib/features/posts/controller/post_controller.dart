import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:reddit_tutorial/features/auth/controller/auth_controller.dart';
import 'package:reddit_tutorial/features/user_profile/controller/user_profile_controller.dart';
import 'package:reddit_tutorial/models/comment_model.dart';
import 'package:reddit_tutorial/models/community_model.dart';
import 'package:reddit_tutorial/models/post_model.dart';
import 'package:routemaster/routemaster.dart';
import 'package:uuid/uuid.dart';

import '../../../core/enum.dart';
import '../../../core/failure.dart';
import '../../../core/providers/storage_repository_provider.dart';
import '../../../core/utils.dart';
import '../repository/post_repository.dart';

final postControllerProvider =
    StateNotifierProvider<PostController, bool>((ref) {
  return PostController(
    postRepository: ref.watch(postRepositoryProvider),
    ref: ref,
    storage: ref.watch(storageRepositoryProvider),
  );
});

final userPostProvider =
    StreamProvider.family((ref, List<CommunityModel> communities) {
  return ref.watch(postControllerProvider.notifier).fetchUserPosts(communities);
});

final getPostProvider = StreamProvider.family((ref, String postId) {
  return ref.read(postControllerProvider.notifier).getPost(postId);
});

final commentOfPostProvider = StreamProvider.family((ref, String postId) {
  return ref.watch(postControllerProvider.notifier).getCommentOfPost(postId);
});

class PostController extends StateNotifier<bool> {
  final PostRepository _postRepository;
  final Ref _ref;
  final StorageRepository _storage;

  PostController({
    required PostRepository postRepository,
    required Ref ref,
    required StorageRepository storage,
  })  : _postRepository = postRepository,
        _ref = ref,
        _storage = storage,
        super(false);

  Future<void> sharedPost({
    required BuildContext context,
    required String title,
    String? description,
    String? link,
    required CommunityModel selectedCommunity,
    File? file,
    required String type,
  }) async {
    state = true;
    String postId = const Uuid().v1();
    final user = _ref.read(userProvider)!;

    if (file != null) {
      final imageRes = await _storage.storeFile(
        path: "posts/${selectedCommunity.name}",
        id: postId,
        file: file,
      );

      // update karma if file post
      _ref
          .read(userProfileControllerProvider.notifier)
          .updateUserKarma(UserKarma.imagePost);

      imageRes.fold(
        (l) => showSnackBar(context, l.message),
        (path) => link = path,
      );
    }

    if (link != null) {
      // update karma if link post
      _ref
          .read(userProfileControllerProvider.notifier)
          .updateUserKarma(UserKarma.linkPost);
    }
    if (description != null) {
      // update karma if text post
      _ref
          .read(userProfileControllerProvider.notifier)
          .updateUserKarma(UserKarma.textPost);
    }

    final post = PostModel(
      id: postId,
      title: title,
      userName: user.name,
      uid: user.uid,
      communityName: selectedCommunity.name,
      communityProfilePic: selectedCommunity.avatar,
      upVotes: [],
      downVotes: [],
      commentCount: 0,
      type: type,
      description: description,
      link: link,
      createdAt: DateTime.now(),
      awards: [],
    );

    final res = await _postRepository.addPost(post);

    state = false;
    res.fold(
      (l) => showSnackBar(context, l.message),
      (_) {
        showSnackBar(context, "Post success");
        Routemaster.of(context).pop();
      },
    );
  }

  Stream<List<PostModel>> fetchUserPosts(List<CommunityModel> communities) {
    if (communities.isEmpty) {
      return Stream.value([]);
    }
    return _postRepository.fetchUserPosts(communities);
  }

  Future<void> deletePost(String postId, BuildContext context) async {
    final res = await _postRepository.deletePost(postId);

    // update user karma
    _ref
        .read(userProfileControllerProvider.notifier)
        .updateUserKarma(UserKarma.deletePost);

    res.fold(
      (l) => showSnackBar(context, l.message),
      (_) => showSnackBar(context, "Post deleted"),
    );
  }

  Future<void> votes(
    PostModel post,
    String typeVotes,
    BuildContext context,
  ) async {
    final Either<Failure, void> res;

    if (typeVotes == 'upVotes') {
      // if typw votes is up
      res = await _postRepository.upVote(post, _ref.read(userProvider)!.uid);
    } else {
      res = await _postRepository.downVote(post, _ref.read(userProvider)!.uid);
    }
    res.fold(
      (l) => showSnackBar(context, l.message),
      (_) => null,
    );
  }

  Stream<PostModel> getPost(String postId) => _postRepository.getPost(postId);

  Future<void> addComment({
    required String text,
    required String postId,
    required BuildContext context,
  }) async {
    state = true;
    final user = _ref.read(userProvider)!;
    final comment = CommentModel(
      text: text,
      postId: postId,
      username: user.name,
      id: const Uuid().v1(),
      createdAt: DateTime.now(),
      profilePic: user.profileUrl,
    );

    final res = await _postRepository.addComment(comment);

    // update karma
    _ref
        .read(userProfileControllerProvider.notifier)
        .updateUserKarma(UserKarma.comment);

    state = false;

    res.fold(
      (l) => showSnackBar(context, l.message),
      (_) => null,
    );
  }

  Stream<List<CommentModel>> getCommentOfPost(String postId) =>
      _postRepository.getCommentOfPost(postId);
}
