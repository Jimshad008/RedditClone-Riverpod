

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpodproject/core/Constants/Constant.dart';
import 'package:riverpodproject/core/Constants/firebaseConstant.dart';
import 'package:riverpodproject/core/type_def.dart';
import 'package:riverpodproject/core/Providers/providers.dart';
import 'package:riverpodproject/core/failure.dart';
import 'package:riverpodproject/model/userModel.dart';
final authRepositoryProvider=Provider((ref) => AuthRepository(firebaseFirestore: ref.read(firestoreProvider), firebaseAuth: ref.read(authProvider), googleSignIn: ref.read(googleSignInProvider)));
class AuthRepository{
 final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;
  AuthRepository({required FirebaseFirestore firebaseFirestore,required FirebaseAuth firebaseAuth,required GoogleSignIn googleSignIn}):_firestore=firebaseFirestore,_auth=firebaseAuth,_googleSignIn=googleSignIn;
  CollectionReference get _users=>_firestore.collection(FirebaseConstant.userConstant);
  Stream<User?> get authStatusChange=>_auth.authStateChanges();

  FutureEither<UserModel> googleSignIn() async {
   try {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    var googleAuth = await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken);
    UserCredential userCredential = await _auth.signInWithCredential(
        credential);
    UserModel userModel;
    if (userCredential.additionalUserInfo!.isNewUser) {
     userModel = UserModel(name: googleUser?.displayName ?? "",
         profile: googleUser?.photoUrl ?? Constant.avatarDefault,
         banner: Constant.bannerDefault,
         uid: userCredential.user!.uid,
         isAuthenticated: true,
         karma: 0,
         award: []);
     await _users.doc(userCredential.user!.uid).set(userModel.toMap());
    }
    else{
       userModel=await getUserData(userCredential.user!.uid).first;
    }
    return right(userModel);
   } on FirebaseException catch (e) {
    throw (e.message!);
   }
   catch (e) {
    return left(Failure(e.toString()));
   }
  }  
  Stream<UserModel>getUserData(String uid){
   return _users.doc(uid).snapshots().map((event) => UserModel.fromMap(event.data()as Map<String,dynamic>));
  }
 void logOut() async{
  await _googleSignIn.signOut();
  await _auth.signOut();

  }
}