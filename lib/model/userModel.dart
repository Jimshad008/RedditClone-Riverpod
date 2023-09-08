import 'package:flutter_riverpod/flutter_riverpod.dart';
// UserModel? userModel;

class UserModel {
  String name;
  String profile;
  String banner;
  String uid;
  bool isAuthenticated;
  int karma;
  List<String> award;

//<editor-fold desc="Data Methods">

  UserModel({
    required this.name,
    required this.profile,
    required this.banner,
    required this.uid,
    required this.isAuthenticated,
    required this.karma,
    required this.award,
  });

//<ed@override



  UserModel copyWith({
    String? name,
    String? profile,
    String? banner,
    String? uid,
    bool? isAuthenticated,
    int? karma,
    List<String>? award,
  }) {
    return UserModel(
      name: name ?? this.name,
      profile: profile ?? this.profile,
      banner: banner ?? this.banner,
      uid: uid ?? this.uid,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      karma: karma ?? this.karma,
      award: award ?? this.award,
    );
  }


  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'profile': this.profile,
      'banner': this.banner,
      'uid': this.uid,
      'isAuthenticated': this.isAuthenticated,
      'karma': this.karma,
      'award': this.award,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] as String,
      profile: map['profile']as String,
      banner: map['banner']as String,
      uid: map['uid']as String,
      isAuthenticated: map['isAuthenticated'] as bool,
      karma: map['karma'] as int,
      award: List<String>.from(map["award"]),
    );
  }



}
