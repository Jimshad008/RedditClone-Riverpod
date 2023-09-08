import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:riverpodproject/features/Home/screen/Homepage.dart';
import 'package:riverpodproject/features/auth/screen/LoginPage.dart';
import 'package:riverpodproject/features/community/screen/add_moderator.dart';
import 'package:riverpodproject/features/community/screen/communityviewpage.dart';



import 'package:riverpodproject/features/community/screen/create_a_community.dart';
import 'package:riverpodproject/features/community/screen/edit_community.dart';
import 'package:riverpodproject/features/community/screen/mod_tool_page.dart';

import 'package:routemaster/routemaster.dart';






final logedOutRoute=RouteMap(routes: {
  "/":(_)=> const CupertinoPage(child: LoginPage())
});
final logedInRoute=RouteMap(routes: {
  "/":(_)=> const CupertinoPage(child: HomePage()),
  "/create-community":(_)=> const CupertinoPage(child: CreateCommiunity()),
  "/r/:name":(route)=>CupertinoPage(child:CommunityViewPage(name: route.pathParameters['name']!)),
  "/mod_tools/:name":(route)=>CupertinoPage(child:ModToolPage(name: route.pathParameters['name']!)),
  "/edit_community/:name":(route)=>CupertinoPage(child:EditCommunity(name: route.pathParameters['name']!)),
  "/mod_add/:name":(route)=>CupertinoPage(child:AddModerator(name: route.pathParameters['name']!)),
});