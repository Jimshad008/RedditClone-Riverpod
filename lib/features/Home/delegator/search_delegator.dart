import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpodproject/core/common/errorText.dart';
import 'package:riverpodproject/core/common/loder.dart';
import 'package:riverpodproject/features/community/controller/communitycontroller.dart';
import 'package:routemaster/routemaster.dart';

class CommunitySearchDelegator extends  SearchDelegate {
  final WidgetRef ref;
CommunitySearchDelegator(this.ref);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [IconButton(onPressed: () =>query='' , icon:const Icon(Icons.close))];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
   return const SizedBox();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ref.watch(communitySearchProvider(query)).when(data: (data) {
      return ListView.builder(itemCount: data.length,
        itemBuilder: (context, index) => ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(data[index].avatar),

        ),
        title: Text("r/${data[index].name}"),
        onTap: () => navigateCommunityView(context, data[index].name),
      ),);
    }, error: (error, stackTrace) => ErrorText(text: error.toString()), loading:() => const Loader(), );
  }
  void navigateCommunityView(BuildContext context,String name){
    Routemaster.of(context).push('/r/${name}');
  }
}