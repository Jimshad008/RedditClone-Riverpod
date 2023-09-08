import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpodproject/core/Constants/Constant.dart';
import 'package:riverpodproject/core/common/errorText.dart';
import 'package:riverpodproject/core/common/loder.dart';
import 'package:riverpodproject/core/util.dart';
import 'package:riverpodproject/features/community/controller/communitycontroller.dart';
import 'package:riverpodproject/model/communityModel.dart';
import 'package:riverpodproject/theme/theme.dart';

class EditCommunity extends ConsumerStatefulWidget {
  String name;
  EditCommunity({super.key,required this.name});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditCommunityState();
}

class _EditCommunityState extends ConsumerState<EditCommunity> {
  File? bannerFile;
  File? profileFile;
  void save(CommunityModel communityModel,BuildContext context){

    ref.watch(communityControllerProvider.notifier).editCommunity(communityModel: communityModel, profileFile: profileFile, bannerFile: bannerFile, context: context);
  }

  selectBannerImage() async {
    final res= await pickImage();
    if(res!=null){

      setState(() {
        bannerFile=File(res.files.first.path!);

      });

    }
  }
    selectProfileImage() async {
    final res=await pickImage();
    if(res!=null){
           setState(() {
             profileFile=File(res.files.first.path!);
           });


    }
  }
  @override
  Widget build(BuildContext context) {
    final isLoading=ref.watch(communityControllerProvider);
    return isLoading?const Loader():ref.watch(getUserCommunityByNameProvider(widget.name)).when(data: (data) =>  Scaffold(
      backgroundColor: ThemePicker.darkModeAppTheme.appBarTheme.backgroundColor,
      appBar: AppBar(
        title: const Text("Edit Community"),
        actions:  [Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: IconButton(onPressed:() => save(data, context), icon:Text("Save")),
        )],
      ),
      body:Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 200,
              child: Stack(
                children: [
                  GestureDetector(
                    onTap: () => selectBannerImage(),
                    child: DottedBorder(radius: const Radius.circular(10),
                        dashPattern: const [10,4],
                        strokeCap: StrokeCap.round,
                        borderType: BorderType.RRect,

                        color: ThemePicker.darkModeAppTheme.textTheme.bodyText2!.color!,
                        child: Container(
                          width: double.maxFinite,
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),

                          ),
                          child:bannerFile !=null?Image.file(bannerFile!,fit: BoxFit.cover,):data.banner.isEmpty|| data.banner==Constant.bannerDefault?const Icon(Icons.camera_alt_outlined,size: 40,):Image.network(data.banner,fit: BoxFit.cover,),
                        )),
                  ),
                  Positioned(
                    left: 20,
                    bottom: 20,
                    child: GestureDetector(
                     onTap: () => selectProfileImage(),
                      child: profileFile !=null?CircleAvatar(
                        radius: 28,
                        backgroundImage: FileImage(profileFile!,),
                    ):CircleAvatar(
                        radius: 28,
                        backgroundImage: NetworkImage(data.avatar),),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ) ,

    ), error: (error, stackTrace) =>ErrorText(text: error.toString()) , loading:() => const Loader());



  }
}
