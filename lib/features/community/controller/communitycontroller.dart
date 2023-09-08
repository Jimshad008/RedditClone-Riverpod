// import 'dart:io';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:riverpodproject/core/Constants/Constant.dart';
// import 'package:riverpodproject/core/Providers/storageRepository.dart';
// import 'package:riverpodproject/features/auth/controller/authController.dart';
// import 'package:riverpodproject/features/community/repository/communityrepository.dart';
// import 'package:riverpodproject/model/communityModel.dart';
// import 'package:routemaster/routemaster.dart';
//
// import '../../../core/util.dart';
//
// final getUserCommunitiesProvider = StreamProvider((ref) =>
//     ref.watch(communityControllerProvider.notifier).getUserCommunities());
// final communityControllerProvider =
//     StateNotifierProvider<CommunityController, bool>((ref) =>
//         CommunityController(
//             communityRepository: ref.watch(communityRepositoryProvider),
//             ref: ref,
//             storageRepository: ref.watch(storageRepositoryProvider)));
// final getUserCommunityByNameProvider = StreamProvider.family((ref,
//         String name) =>
//     ref.watch(communityControllerProvider.notifier).getCommunityByName(name));
// final communitySearchProvider=StreamProvider.family((ref,String query) => ref.watch(communityControllerProvider.notifier).searchCommunity(query));
//
// class CommunityController extends StateNotifier<bool> {
//   final CommunityRepository _communityRepository;
//   final Ref _ref;
//   final StorageRepository _storageRepository;
//   CommunityController(
//       {required CommunityRepository communityRepository,
//       required Ref ref,
//       required StorageRepository storageRepository})
//       : _communityRepository = communityRepository,
//         _ref = ref,
//         _storageRepository = storageRepository,
//         super(false);
//   CommunityModel? communityModel;
//   communityCreate(String name, BuildContext context) async {
//     state = true;
//     final uid = _ref.read(userProvider)?.uid ?? "";
//     communityModel = CommunityModel(
//         id: name,
//         name: name,
//         banner: Constant.bannerDefault,
//         avatar: Constant.avatarDefault,
//         members: [uid],
//         mods: [uid]);
//     final user = await _communityRepository.communityCreate(communityModel!);
//     state = false;
//     user.fold((l) => showSnikerBar(l.message, context), (r) {
//       showSnikerBar("Community Created Succesfully", context);
//       Routemaster.of(context).pop();
//     });
//   }
//
//   Stream<List<CommunityModel>> getUserCommunities() {
//     final uid = _ref.read(userProvider)?.uid;
//     return _communityRepository.getUserCommunities(uid!);
//   }
//
//   Stream<CommunityModel> getCommunityByName(String name) {
//     return _communityRepository.getCommunityByName(name);
//   }
//
//   editCommunity(
//       {required CommunityModel communityModel,
//       required File? profileFile,
//       required File? bannerFile,
//       required BuildContext context}) async {
//     state = true;
//     if (profileFile != null) {
//       final res = await _storageRepository.storeFile(
//           path: "/community/profile",
//           id: communityModel.name,
//           file: profileFile);
//       res.fold((l) => showSnikerBar(l.message, context),
//           (r) => communityModel=communityModel.copyWith(avatar: r));
//
//     }
//     if (bannerFile != null) {
//       final res = await _storageRepository.storeFile(
//           path: "/community/banner", id: communityModel.name, file: bannerFile);
//       res.fold((l) => showSnikerBar(l.message, context),
//           (r)=> communityModel =communityModel.copyWith(banner: r));
//
//     }
//     state = false;
//     final res = await _communityRepository.editCommunity(communityModel);
//     res.fold((l) => showSnikerBar(l.message, context),
//         (r) => Routemaster.of(context).pop());
//   }
//   Stream<List<CommunityModel>> searchCommunity(String query){
//     return _communityRepository.searchCommunity(query);
//   }
// joinCommunity({required String uid,required CommunityModel communityModel,required BuildContext context}) async {
//     bool a=true;
//     if(!communityModel.members.contains(uid)) {
//       communityModel.members.add(uid);
//       a=true;
//     }
//     else{
//       communityModel.members.remove(uid);
//       a=false;
//     }
//     communityModel=communityModel.copyWith(members: communityModel.members);
//     final res=await _communityRepository.editCommunity(communityModel);
//     res.fold((l) => showSnikerBar(l.message,context), (r) {
//
//       showSnikerBar(a?"you are joined  the community ":"you are exit from the community", context);
//     });
// }
// addModerator({required List<String> uids,required CommunityModel communityModel,required BuildContext context}) async {
//     List<String> res=communityModel.mods+uids;
//     res=res.toSet().toList();
//     communityModel=communityModel.copyWith(mods: res);
//     final result=await _communityRepository.editCommunity(communityModel);
//     result.fold((l) => showSnikerBar(l.message,context), (r) {
//       Routemaster.of(context).pop();
//     showSnikerBar("Update moderator succesfully", context);
//     });
// }
//
// }
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpodproject/core/Constants/Constant.dart';
import 'package:riverpodproject/core/Providers/storageRepository.dart';
import 'package:riverpodproject/features/auth/controller/authController.dart';
import 'package:riverpodproject/features/community/repository/communityrepository.dart';
import 'package:riverpodproject/model/communityModel.dart';
import 'package:routemaster/routemaster.dart';

import '../../../core/util.dart';

final getUserCommunitiesProvider = StreamProvider((ref) =>
    ref.watch(communityControllerProvider.notifier).getUserCommunities());
final communityControllerProvider =
NotifierProvider<CommunityController, bool>(() =>
    CommunityController());
final getUserCommunityByNameProvider = StreamProvider.family((ref,
    String name) =>
    ref.watch(communityControllerProvider.notifier).getCommunityByName(name));
final communitySearchProvider=StreamProvider.family((ref,String query) => ref.watch(communityControllerProvider.notifier).searchCommunity(query));

class CommunityController extends Notifier<bool> {


  CommunityController();
  CommunityModel? communityModel;

  CommunityRepository getCommunityRepository(){
    return ref.watch(communityRepositoryProvider);
  }
  StorageRepository getStorageRepository(){
    return ref.watch(storageRepositoryProvider);
  }

  communityCreate(String name, BuildContext context) async {
    // CommunityRepository _communityRepository=getComm();
    state = true;
    final uid = ref.read(userProvider)?.uid ?? "";
    communityModel = CommunityModel(
        id: name,
        name: name,
        banner: Constant.bannerDefault,
        avatar: Constant.avatarDefault,
        members: [uid],
        mods: [uid]);
    final user = await getCommunityRepository().communityCreate(communityModel!);
    state = false;
    user.fold((l) => showSnikerBar(l.message, context), (r) {
      showSnikerBar("Community Created Succesfully", context);
      Routemaster.of(context).pop();
    });
  }

  Stream<List<CommunityModel>> getUserCommunities() {

    final uid = ref.read(userProvider)?.uid;
    return getCommunityRepository().getUserCommunities(uid!);
  }

  Stream<CommunityModel> getCommunityByName(String name) {

    return getCommunityRepository().getCommunityByName(name);
  }

  editCommunity(
      {required CommunityModel communityModel,
        required File? profileFile,
        required File? bannerFile,
        required BuildContext context}) async {

    state = true;
    if (profileFile != null) {
      final res = await getStorageRepository().storeFile(
          path: "/community/profile",
          id: communityModel.name,
          file: profileFile);
      res.fold((l) => showSnikerBar(l.message, context),
              (r) => communityModel=communityModel.copyWith(avatar: r));

    }
    if (bannerFile != null) {
      final res = await getStorageRepository().storeFile(
          path: "/community/banner", id: communityModel.name, file: bannerFile);
      res.fold((l) => showSnikerBar(l.message, context),
              (r)=> communityModel =communityModel.copyWith(banner: r));

    }
    state = false;
    final res = await getCommunityRepository().editCommunity(communityModel);
    res.fold((l) => showSnikerBar(l.message, context),
            (r) => Routemaster.of(context).pop());
  }
  Stream<List<CommunityModel>> searchCommunity(String query){
    // CommunityRepository _communityRepository=ref.watch(communityRepositoryProvider);
    return getCommunityRepository().searchCommunity(query);
  }
  joinCommunity({required String uid,required CommunityModel communityModel,required BuildContext context}) async {
    bool a=true;

    if(!communityModel.members.contains(uid)) {
      communityModel.members.add(uid);
      a=true;
    }
    else{
      communityModel.members.remove(uid);
      a=false;
    }
    communityModel=communityModel.copyWith(members: communityModel.members);
    final res=await getCommunityRepository().editCommunity(communityModel);
    res.fold((l) => showSnikerBar(l.message,context), (r) {

      showSnikerBar(a?"you are joined  the community ":"you are exit from the community", context);
    });
  }
  addModerator({required List<String> uids,required CommunityModel communityModel,required BuildContext context}) async {

    List<String> res=communityModel.mods+uids;
    res=res.toSet().toList();
    communityModel=communityModel.copyWith(mods: res);
    final result=await getCommunityRepository().editCommunity(communityModel);
    result.fold((l) => showSnikerBar(l.message,context), (r) {
      Routemaster.of(context).pop();
      showSnikerBar("Update moderator succesfully", context);
    });
  }

  @override
  bool build() {
    // TODO: implement build
    return false;
  }

}
