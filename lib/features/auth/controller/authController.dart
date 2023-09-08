import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpodproject/features/auth/repository/authRepository.dart';
import 'package:riverpodproject/model/userModel.dart';

import '../../../core/util.dart';

final userProvider = StateProvider<UserModel?>((ref) => null);
final authControllerProvider = NotifierProvider<AuthController, bool>(
    () => AuthController(
       ));
final authStatusChangesProvider = StreamProvider(
    (ref) => ref.watch(authControllerProvider.notifier).authStatusChange);
final getUserDataProvider = StreamProvider.family((ref, String uid) =>
    ref.watch(authControllerProvider.notifier).getUserData(uid));

class AuthController extends Notifier<bool> {


  AuthController();

  AuthRepository getAuthRepository(){
    return  ref.read(authRepositoryProvider);
  }
  Stream<User?> get authStatusChange => getAuthRepository().authStatusChange;

  Future<void> googleSignIn(BuildContext context) async {
    state = true;
    final user = await getAuthRepository().googleSignIn();
    state = false;
    user.fold(
        (l) => showSnikerBar(l.message, context),
        (userModel) =>
            ref.read(userProvider.notifier).update((state) => userModel));
  }

  Stream<UserModel> getUserData(String uid) {
    return getAuthRepository().getUserData(uid);
  }
void logOut(){
  getAuthRepository().logOut();
}

  @override
  bool build() {
    // TODO: implement build
    return false;
  }
}
