import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpodproject/features/Home/delegator/search_delegator.dart';
import 'package:riverpodproject/features/Home/drawer/community_list_drawer.dart';
import 'package:riverpodproject/features/Home/drawer/profile-drawer.dart';
import 'package:riverpodproject/features/auth/controller/authController.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});
void displayDrawer(BuildContext context){
  Scaffold.of(context).openDrawer();
}
  void displayEndDrawer(BuildContext context){
    Scaffold.of(context).openEndDrawer();
  }
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final user=ref.watch(userProvider);

    return Scaffold(
      drawer: const CommunityListDrawer(),
      endDrawer: const ProfileDrawer(),
      appBar: AppBar(

        leading:Builder(
          builder: (context) {
            return IconButton(onPressed:() =>displayDrawer(context), icon:const Icon(Icons.menu));
          }
        ) ,
        title: const Text("Home"),
        actions: [
          IconButton(onPressed:() {
                showSearch(context: context, delegate: CommunitySearchDelegator(ref));
          }
              , icon: const Icon(Icons.search_outlined))
          ,
          Builder(
            builder: (context) =>
         IconButton(onPressed: () =>displayEndDrawer(context), icon: CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(user?.profile??""),
            ) ),
          )

        ],
      ),

           body: Center(
             child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Row(
                   children: [
                     Text("Name:${user?.name??''}"),
                   ],
                 ),
                 Row(
                   children: [
                     Text("age:${user?.karma??''}"),
                   ],
                 ),]),
                 )
    );
  }
}
