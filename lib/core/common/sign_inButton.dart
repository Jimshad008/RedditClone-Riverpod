
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpodproject/core/Constants/Constant.dart';
import 'package:riverpodproject/features/auth/controller/authController.dart';
import 'package:riverpodproject/theme/theme.dart';
class SignInButtton extends ConsumerWidget {
  final BuildContext context1;
   const SignInButtton({super.key,required this.context1});
  void googleSignIn(WidgetRef ref){
   ref.read(authControllerProvider.notifier).googleSignIn(context1);
  }

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: ElevatedButton(onPressed: () {
    googleSignIn(ref);
      }, child: Container(
        child: Row(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(Constant.googlePath,width: 35,),
           const Text("Continue with Google",style: TextStyle(fontSize: 18),)
          ],
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: ThemePicker.greyColor,
        minimumSize: Size(double.maxFinite, 50),
          shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
      )
      ),),
    );
  }
}
