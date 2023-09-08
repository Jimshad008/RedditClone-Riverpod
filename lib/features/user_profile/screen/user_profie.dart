import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpodproject/features/auth/controller/authController.dart';

class UserProfile extends ConsumerWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String uid=ref.watch(userProvider)!.uid;
    return Scaffold(
      body: ref.watch(getUserDataProvider()),
    ) ;
  }
}
