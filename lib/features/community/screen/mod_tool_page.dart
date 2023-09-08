import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

class ModToolPage extends StatelessWidget {
  String name;
ModToolPage({super.key,required this.name});
void navigateEditCommunity(BuildContext context){
  Routemaster.of(context).push("/edit_community/$name");
}
  void navigateAddModerator(BuildContext context){
    Routemaster.of(context).push("/mod_add/$name");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mod Tools"),
      ),
      body:   Column(
        children: [
          ListTile(
            leading: const Icon(Icons.add_moderator),
            title: const Text("Add Moderator"),
            onTap:() =>navigateAddModerator(context),
          ),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text("Edit Community"),
            onTap:()=>navigateEditCommunity(context),
          )
        ],
      ),

    );
  }
}
