import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpodproject/features/auth/controller/authController.dart';
import 'package:riverpodproject/theme/theme.dart';

class ProfileDrawer extends ConsumerWidget {
  const ProfileDrawer({super.key});
  void logOut(WidgetRef ref){
    ref.watch(authControllerProvider.notifier).logOut();
  }

  @override
  Widget build(BuildContext ,WidgetRef ref) {
    final user=ref.watch(userProvider);
    return Drawer(
      child: Column(
        children: [
          CircleAvatar(
            radius: 55,
            backgroundImage: NetworkImage(user?.profile??""),
          ),
          const SizedBox(
            height: 10,

          ),
          Text(user?.name??"",style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
          const SizedBox(
            height: 5,

          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.person_rounded),
            title: const Text("My Profile"),
            onTap: () {

            },
          ),
          ListTile(
            leading:  Icon(Icons.logout,color: ThemePicker.redColor,),
            title: const Text("Log Out"),
            onTap: () =>logOut(ref),
          ),
          Switch.adaptive(value:true , onChanged:(value) {},)
        ],
      ),
    );
  }
}
