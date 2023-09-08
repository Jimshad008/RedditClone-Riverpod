import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpodproject/core/Constants/Constant.dart';
import 'package:riverpodproject/core/common/loder.dart';
import 'package:riverpodproject/core/common/sign_inButton.dart';
import 'package:riverpodproject/features/auth/controller/authController.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(authControllerProvider);
    return Scaffold(
            appBar: AppBar(
              title: Center(
                  child: Image.asset(Constant.logoWithNamePath, height: 50)),
              actions: [
                TextButton(
                    onPressed: () {},
                    child: Text(
                      "Skip",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ))
              ],
            ),
            body: isLoading ? Loader():
            Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Center(
                    child: const Text(
                  "Dive into anything",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                )),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    Constant.loginImagePath,
                    height: 400,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                SignInButtton(
                  context1: context,
                )
              ],
            ),
          );
  }
}
