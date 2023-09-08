import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpodproject/core/common/errorText.dart';
import 'package:riverpodproject/core/common/loder.dart';
import 'package:riverpodproject/features/community/controller/communitycontroller.dart';
import 'package:routemaster/routemaster.dart';

class CommunityListDrawer extends ConsumerWidget {
  const CommunityListDrawer({super.key});
  void navigateCreateCommunity(BuildContext context){
    Routemaster.of(context).push('/create-community');
  }
  void navigateCommunityView(BuildContext context,String name){
    Routemaster.of(context).push('/r/${name}');
  }

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return  Drawer(
         child: SafeArea(child:
         SizedBox(
           child: Column(
             children: [
               ListTile(title: const Text("Create a community"),
               leading: const Icon(Icons.add),
               onTap:() =>navigateCreateCommunity(context),),
               ref.watch(getUserCommunitiesProvider).when(data: (data) =>
                 Expanded(
                   child: ListView.builder(itemCount: data.length,
                     itemBuilder: (context, index) => ListTile(
                       leading: CircleAvatar(
                         backgroundImage: NetworkImage(data[index].avatar),

                       ),
                       title: Text("r/${data[index].name}"),
                       onTap: () {
                          navigateCommunityView(context, data[index].name);
                       },
                     )),
                 ), error:(error, stackTrace) => ErrorText(text: error.toString()), loading:() => const Loader())
             ],
           ),
         )),
    );
  }
}
