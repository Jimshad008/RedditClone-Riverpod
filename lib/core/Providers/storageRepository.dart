
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpodproject/core/Providers/providers.dart';
import 'package:riverpodproject/core/failure.dart';
import 'package:riverpodproject/core/type_def.dart';
final storageRepositoryProvider=Provider((ref) => StorageRepository(firebaseStorage: ref.watch(storageProvider)));
class StorageRepository{
  final FirebaseStorage _firebaseStorage;

  StorageRepository({required FirebaseStorage firebaseStorage}):_firebaseStorage=firebaseStorage;
  FutureEither<String> storeFile({required String path,required String id,required File? file}) async{
  try{
 final ref= _firebaseStorage.ref().child(path).child(id);
  final uploadSnapshot=await ref.putFile(file!);
  final snapshot= uploadSnapshot;

  return right(await snapshot.ref.getDownloadURL());
  }on FirebaseException catch(e){
    throw e.message!;
  }
  catch(e){
    return left(Failure(e.toString()));
  }
  }

}