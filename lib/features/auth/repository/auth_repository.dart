import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:reddit_tutorial/core/constants/constants.dart';
import 'package:reddit_tutorial/core/type_def.dart';
import 'package:reddit_tutorial/models/user_model.dart';

import '../../../core/constants/firebase_constatns.dart';
import '../../../core/failure.dart';
import '../../../core/providers/firebase_provider.dart';

final authRepositoryProvider = Provider(
  (ref) => AuthRepository(
    firestore: ref.read(firestoreProvider),
    auth: ref.read(authProvider),
    googleSignIn: ref.read(googleSignInProvider),
  ),
);

class AuthRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;

  AuthRepository({
    required FirebaseFirestore firestore,
    required FirebaseAuth auth,
    required GoogleSignIn googleSignIn,
  })  : _firestore = firestore,
        _auth = auth,
        _googleSignIn = googleSignIn;

  CollectionReference get _userRef =>
      _firestore.collection(FirebaseConstant.userCollection);

  // Check user signIn or not
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  /// Function login with google account
  /// and save data user to firestore with [UserModel]
  /// [FutureEither] is typeDef for handle if function has Error
  FutureEither<UserModel> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      late UserModel userModel;

      // Check user is new user or not
      if (userCredential.additionalUserInfo!.isNewUser) {
        // set user model
        userModel = UserModel(
          name: userCredential.user?.displayName ?? '',
          uid: userCredential.user?.uid ?? '',
          profileUrl: userCredential.user?.photoURL ?? Constants.avatarDefault,
          banner: Constants.bannerDefault,
          isAuth: true,
          karma: 0,
          awards: [],
        );
        // create data users in firestore
        await _userRef.doc(userCredential.user?.uid).set(userModel.toJson());
      } else {
        // get data user from firestore
        userModel = await getUserData(userCredential.user!.uid);
      }

      return right(userModel);
    } on FirebaseAuthException catch (e) {
      throw e.message!;
    } catch (e) {
      if (kDebugMode) print(e);
      return left(Failure(e.toString()));
    }
  }

  // get data user form firestore
  Future<UserModel> getUserData(String uid) async {
    final userData =
        (await _userRef.doc(uid).get()).data() as Map<String, dynamic>;
    return UserModel.fromJson(userData);
  }

  // logout
  Future<void> logOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}
