import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:reddit_tutorial/models/post_model.dart';
import 'package:reddit_tutorial/models/user_model.dart';

import '../../../core/constants/firebase_constatns.dart';
import '../../../core/failure.dart';
import '../../../core/providers/firebase_provider.dart';
import '../../../core/type_def.dart';

final userProfileRepositoryProvider = Provider<UserProfileRepository>((ref) {
  return UserProfileRepository(ref.watch(firestoreProvider));
});

class UserProfileRepository {
  final FirebaseFirestore _firestore;
  UserProfileRepository(FirebaseFirestore firestore) : _firestore = firestore;

  // users reference from firestore
  CollectionReference get _usersColl =>
      _firestore.collection(FirebaseConstant.userCollection);
  // posts reference from firestore
  CollectionReference get _postColl =>
      _firestore.collection(FirebaseConstant.postCollection);

  // editing user data in firestore
  FutureVoid editProfile(UserModel user) async {
    try {
      // update to firestore
      return right(_usersColl.doc(user.uid).update(user.toJson()));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  // get user posts
  Stream<List<PostModel>> getUserPosts(String uid) {
    return _postColl
        .where('uid', isEqualTo: uid)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (posts) => posts.docs
              .map((post) =>
                  PostModel.fromJson(post.data() as Map<String, dynamic>))
              .toList(),
        );
  }

  FutureVoid updateUserKarma(UserModel user) async {
    try {
      // update to firestore
      return right(_usersColl.doc(user.uid).update({'karma': user.karma}));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
