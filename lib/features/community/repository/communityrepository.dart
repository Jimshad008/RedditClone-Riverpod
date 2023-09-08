import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpodproject/core/Constants/firebaseConstant.dart';
import 'package:riverpodproject/core/Providers/providers.dart';
import 'package:riverpodproject/core/failure.dart';
import 'package:riverpodproject/core/type_def.dart';
import 'package:riverpodproject/model/communityModel.dart';

import '../../../core/Providers/storageRepository.dart';
final communityRepositoryProvider=Provider((ref) =>CommunityRepository(firestore:  ref.read(firestoreProvider), )
);
class CommunityRepository{
  final FirebaseFirestore _firestore;

  CommunityRepository({required FirebaseFirestore firestore,}):_firestore=firestore;
Futurevoid communityCreate(CommunityModel community)async {
    try{
    var communityDoc=await _community.doc(community.name).get();
    if(communityDoc.exists){
      throw "Community with same name is already exist";
    }
    else{
      return right(await _community.doc(community.name).set(community.toMap()));
    }
    }on FirebaseException catch(e){
      throw e.message!;

    }catch(e){
      return left(Failure(e.toString()));
    }
  }
  Stream<List<CommunityModel>>getUserCommunities(String uid){
  return _community.where("members",arrayContains: uid).snapshots().map((event) {
    List<CommunityModel> community=[];
    for(var i in event.docs){
      community.add(CommunityModel.fromMap(i.data() as Map<String,dynamic>));
    }
    return community;
  });
  }
  Stream<CommunityModel> getCommunityByName(String name){
  return _community.doc(name).snapshots().map((event) => CommunityModel.fromMap(event.data()as Map<String,dynamic>));
  }
  Futurevoid editCommunity(CommunityModel communityModel) async{

  try{

        return right(_community.doc(communityModel.name).update(communityModel.toMap()));
  }on FirebaseException catch(e){
    throw e.message!;
  }
  catch(e){
    return left(Failure(e.toString()));
  }

  }
  CollectionReference get _community=>_firestore.collection(FirebaseConstant.communityConstant);
Stream<List<CommunityModel>> searchCommunity(String query){
  return _community.where('name',isGreaterThanOrEqualTo: query.isEmpty?0:query,isLessThan: query.isEmpty?null:query.substring(0,query.length-1)+String.fromCharCode(query.codeUnitAt(query.length-1)+1)).snapshots().map((event) {
   List<CommunityModel> searchCommunity =[];
    for(var i in event.docs){
      searchCommunity.add(CommunityModel.fromMap(i.data() as Map<String,dynamic>));
    }
    return searchCommunity;
  });
}

}