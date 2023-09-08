import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpodproject/core/Constants/Constant.dart';
import 'package:riverpodproject/router/router.dart';
import 'package:riverpodproject/theme/theme.dart';
import 'package:routemaster/routemaster.dart';

import 'core/common/errorText.dart';
import 'core/common/loder.dart';
import 'features/auth/controller/authController.dart';

class RootPage extends ConsumerWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {

     return ref.watch(authStatusChangesProvider).when(data: (data){
        return MaterialApp.router(
            title: "redditClone",
            theme: ThemePicker.darkModeAppTheme,
            debugShowCheckedModeBanner: false,


            routerDelegate: RoutemasterDelegate(routesBuilder: (context) {
              if(data!=null){
                return logedInRoute;
              }
              else{
                return logedOutRoute;
              }

            } ),
            routeInformationParser: RoutemasterParser());
      },
        error:(error, stackTrace) => ErrorText(text: error.toString()), loading: () => Loader(),);


  }
}
