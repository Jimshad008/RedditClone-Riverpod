import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpodproject/core/common/errorText.dart';
import 'package:riverpodproject/core/common/loder.dart';
import 'package:riverpodproject/features/auth/controller/authController.dart';
import 'package:riverpodproject/features/community/controller/communitycontroller.dart';
import 'package:riverpodproject/model/communityModel.dart';

class AddModerator extends ConsumerStatefulWidget {
  String name;
  AddModerator({super.key,required this.name});

  @override
  ConsumerState createState() => _AddModeratorState();
}

class _AddModeratorState extends ConsumerState<AddModerator> {
  List<String> uids=[];
  void addModerator(String uid,){
    uids.add(uid);


  }
  void removeModerator(String uid){
    uids.remove(uid);
  }
  void updateModerator(WidgetRef ref,CommunityModel communityModel,BuildContext context){
    ref.watch(communityControllerProvider.notifier).addModerator(uids: uids, communityModel: communityModel, context: context);
  }
  @override
  Widget build(BuildContext context) {
    return  ref.watch(getUserCommunityByNameProvider(widget.name)).when(data: (data) {
      uids=data.mods;
      return Scaffold(
          appBar: AppBar(
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: IconButton(onPressed: () =>updateModerator(ref,data, context), icon: const Icon(Icons.done)),
              )
            ],
          ),
          body: ListView.builder( itemCount: data.members.length,itemBuilder: (context, index) {
            return ref.watch(getUserDataProvider(data.members[index].toString())).when(data: (user) {
              return CheckboxListTile(value: uids.contains(user.uid), onChanged: (value) {
                if(value!){
                  addModerator(user.uid);
                }
                else{
                  removeModerator(user.uid);
                }

              },title: Text(user.name),);
            }, error: (error, stackTrace) => ErrorText(text: error.toString()), loading:() => const Loader(),);
          }
          ));
    }, error: (error, stackTrace) => ErrorText(text: error.toString()), loading: () => const Loader(),);
  }
}
