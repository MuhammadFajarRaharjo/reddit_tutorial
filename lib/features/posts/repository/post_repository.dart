import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import '../../../core/constants/firebase_constatns.dart';
import '../../../core/failure.dart';
import '../../../core/providers/firebase_provider.dart';
import '../../../core/type_def.dart';
import '../../../models/comment_model.dart';
import '../../../models/community_model.dart';
import '../../../models/post_model.dart';

final postRepositoryProvider = Provider<PostRepository>((ref) {
  return PostRepository(ref.watch(firestoreProvider));
});

class PostRepository {
  final FirebaseFirestore _firestore;
  PostRepository(FirebaseFirestore firestore) : _firestore = firestore;

  // get communitie reference from firestore
  CollectionReference get _postColleciton =>
      _firestore.collection(FirebaseConstant.postCollection);
  // get communitie reference from firestore
  CollectionReference get _commentCollection =>
      _firestore.collection(FirebaseConstant.commentCollection);

  // update members community
  FutureVoid addPost(PostModel post) async {
    try {
      return right(
        // create new data post to firestore
        await _postColleciton.doc(post.id).set(post.toJson()),
      );
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  // fetch user posts
  Stream<List<PostModel>> fetchUserPosts(List<CommunityModel> communities) {
    return _postColleciton
        .where('communityName',
            whereIn: communities.map((community) => community.name).toList())
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (posts) => posts.docs
              .map((post) =>
                  PostModel.fromJson(post.data() as Map<String, dynamic>))
              .toList(),
        );
  }

  // delete post id firestore
  FutureVoid deletePost(String postId) async {
    try {
      return right(await _postColleciton.doc(postId).delete());
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  // vote up
  FutureVoid upVote(PostModel post, String uid) async {
    try {
      return right(await _postColleciton.doc(post.id).update({
        if (post.downVotes.contains(uid))
          "downVotes": FieldValue.arrayRemove([uid]),
        if (post.upVotes.contains(uid))
          "upVotes": FieldValue.arrayRemove([uid])
        else
          "upVotes": FieldValue.arrayUnion([uid])
      }));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  // vote down
  FutureVoid downVote(PostModel post, String uid) async {
    try {
      return right(await _postColleciton.doc(post.id).update({
        if (post.upVotes.contains(uid))
          "upVotes": FieldValue.arrayRemove([uid]),
        if (post.downVotes.contains(uid))
          "downVotes": FieldValue.arrayRemove([uid])
        else
          "downVotes": FieldValue.arrayUnion([uid])
      }));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  // get post
  Stream<PostModel> getPost(String postId) {
    return _postColleciton
        .doc(postId)
        .snapshots()
        .map((post) => PostModel.fromJson(post.data() as Map<String, dynamic>));
  }

  // add comment to firestore
  FutureVoid addComment(CommentModel comment) async {
    try {
      await _commentCollection.doc(comment.id).set(comment.toJson());
      return right(await _postColleciton
          .doc(comment.postId)
          .update({"commentCount": FieldValue.increment(1)}));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  // get comment post
  Stream<List<CommentModel>> getCommentOfPost(String postId) {
    return _commentCollection
        .where('postId', isEqualTo: postId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (comments) => comments.docs
              .map((comment) =>
                  CommentModel.fromJson(comment.data() as Map<String, dynamic>))
              .toList(),
        );
  }
}
