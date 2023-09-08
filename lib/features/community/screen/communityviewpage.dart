import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpodproject/core/common/errorText.dart';
import 'package:riverpodproject/core/common/loder.dart';
import 'package:riverpodproject/features/auth/controller/authController.dart';
import 'package:riverpodproject/features/community/controller/communitycontroller.dart';
import 'package:riverpodproject/model/communityModel.dart';
import 'package:routemaster/routemaster.dart';

class CommunityViewPage extends ConsumerWidget {
  String name;
  CommunityViewPage({super.key, required this.name});
void navigateModTool(BuildContext context){
  Routemaster.of(context).push("/mod_tools/$name");
}
void joinCommunity(CommunityModel communityModel,String uid,WidgetRef ref,BuildContext context){

    ref.watch(communityControllerProvider.notifier).joinCommunity(uid: uid, communityModel: communityModel, context: context);

}
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uid=ref.watch(userProvider)?.uid;
    return Scaffold(
      body: ref.watch(getUserCommunityByNameProvider(name)).when(
          data: (data) => NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    floating: true,
                    snap: true,

                    expandedHeight: 150,
                    flexibleSpace: Stack(
                      children: [
                        Positioned.fill(
                            child: Image.network(
                          data.banner,
                          fit: BoxFit.cover,
                        ))
                      ],
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.all(16),
                    sliver: SliverList(
                        delegate: SliverChildListDelegate([
                      Align(
                        alignment: Alignment.topLeft,
                        child: CircleAvatar(
                          radius: 35,
                          backgroundImage: NetworkImage(data.avatar),
                        ),
                      ),
                          const SizedBox(height: 5,),
                          data.mods.contains(uid)? Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("r/${data.name}",style: const TextStyle(fontSize: 19,fontWeight: FontWeight.bold),),
                              OutlinedButton(onPressed: () =>navigateModTool(context),style: OutlinedButton.styleFrom(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),
                                  ),padding: const EdgeInsets.symmetric(horizontal: 25)
                              ), child: const Text("Mod Tools"),)
                            ],):
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                            Text("r/${data.name}",style: const TextStyle(fontSize: 19,fontWeight: FontWeight.bold),),
                            OutlinedButton(onPressed: () =>joinCommunity(data, uid!, ref, context),style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),
                              ),padding: const EdgeInsets.symmetric(horizontal: 25)
                            ), child:Text(data.members.contains(uid)?"Joined":"Join"),)
                          ],),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Text("${data.members.length} members"),
                          )
                    ])),
                  ),
                ];
              },
              body: Container()),
          error: (error, stackTrace) => ErrorText(text: error.toString()),
          loading: () => const Loader()),
    );
  }
}
