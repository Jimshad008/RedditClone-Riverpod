import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpodproject/core/common/loder.dart';
import 'package:riverpodproject/features/community/controller/communitycontroller.dart';
class CreateCommiunity extends ConsumerStatefulWidget {
  const CreateCommiunity({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CreateCommiunityState();
}

class _CreateCommiunityState extends ConsumerState<CreateCommiunity> {
final  TextEditingController _community=TextEditingController();
createCommunity(WidgetRef ref,BuildContext context){
  ref.read(communityControllerProvider.notifier).communityCreate(_community.text.trim(), context);
}
@override
  void dispose() {
    super.dispose();
    // TODO: implement dispose
    _community.dispose();
  }
  @override
  Widget build(BuildContext context) {
  final isloading=ref.watch(communityControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create a community"),
      ),
      body:isloading?const Loader() :Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
           const Align(alignment: Alignment.topLeft,child: Text("Community name")),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _community,
              maxLength: 21,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "r/community_name/",
                filled: true,
                contentPadding: EdgeInsets.all(18),
                
              ),

            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(onPressed: () {
              createCommunity(ref, context);
              
            }, child:const Text("Create community"),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.maxFinite, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)
              )
            ),)
          ],
        ),
      ),

    );
  }
}
