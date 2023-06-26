import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:reddit_tutorial/core/constants/firebase_constatns.dart';
import 'package:reddit_tutorial/core/failure.dart';
import 'package:reddit_tutorial/core/type_def.dart';
import 'package:reddit_tutorial/models/community_model.dart';

import '../../../core/providers/firebase_provider.dart';
import '../../../models/post_model.dart';

final communityRepositoryProvider = Provider<CommunityRepository>((ref) {
  return CommunityRepository(ref.watch(firestoreProvider));
});

class CommunityRepository {
  final FirebaseFirestore _firestore;
  CommunityRepository(FirebaseFirestore firestore) : _firestore = firestore;

  // get communitie reference from firestore
  CollectionReference get _communitiesColl =>
      _firestore.collection(FirebaseConstant.communitiesCollection);
  // posts reference from firestore
  CollectionReference get _postColl =>
      _firestore.collection(FirebaseConstant.postCollection);

  // create community to firestroe
  FutureVoid createCommunity(CommunityModel community) async {
    try {
      // get community with name
      final communityDoc = await _communitiesColl.doc(community.name).get();

      // check doc is already or not
      if (communityDoc.exists) {
        throw 'Community with the same name already exists!';
      }

      // create if document not already
      return right(
          _communitiesColl.doc(community.name).set(community.toJson()));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  // update members community
  FutureVoid updateMembersCommunity({
    required String communityName,
    required String uid,
    bool join = true,
  }) async {
    try {
      // is join add uid member but is not join remove uid member
      final fieldValue =
          join ? FieldValue.arrayUnion([uid]) : FieldValue.arrayRemove([uid]);
      return right(
        await _communitiesColl.doc(communityName).update({
          "members": fieldValue,
        }),
      );
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  // get the communities the user following
  Stream<List<CommunityModel>> getUserCommunity(String uid) {
    return _communitiesColl
        .where('members', arrayContains: uid) // users following community
        .snapshots() // get reasltime data
        .map((event) {
      final List<CommunityModel> community = [];
      for (var doc in event.docs) {
        community
            .add(CommunityModel.fromJson(doc.data() as Map<String, dynamic>));
      }
      return community;
    });
  }

  // get community data
  Stream<CommunityModel> getCommunityByName(String name) =>
      _communitiesColl.doc(name).snapshots().map((event) =>
          CommunityModel.fromJson(event.data() as Map<String, dynamic>));

  // search community by name
  Stream<List<CommunityModel>> searchCommunity(String query) {
    return _communitiesColl
        .where(
          "name",
          isGreaterThanOrEqualTo: query.isEmpty ? 0 : query,
          isLessThan: query.isEmpty
              ? null
              : query.substring(0, query.length - 1) +
                  String.fromCharCode(query.codeUnitAt(query.length - 1) + 1),
        )
        .snapshots()
        .map(
      (event) {
        List<CommunityModel> communites = [];
        for (var community in event.docs) {
          communites.add(CommunityModel.fromJson(
              community.data() as Map<String, dynamic>));
        }
        if (kDebugMode) {
          print(communites);
        }
        return communites;
      },
    );
  }

  // editing community data in firestore
  FutureVoid editCommunity(CommunityModel community) async {
    try {
      // update to firestore
      return right(
          _communitiesColl.doc(community.name).update(community.toJson()));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  // update mods community
  FutureVoid addMods(String communityName, List<String> uids) async {
    try {
      // update mods to firestore
      return right(_communitiesColl.doc(communityName).update({"mods": uids}));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  // get community posts
  Stream<List<PostModel>> getCommunityPosts(String name) {
    return _postColl
        .where('communityName', isEqualTo: name)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (posts) => posts.docs
              .map((post) =>
                  PostModel.fromJson(post.data() as Map<String, dynamic>))
              .toList(),
        );
  }
}
