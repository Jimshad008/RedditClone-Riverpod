import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpodproject/core/Constants/Constant.dart';
import 'package:riverpodproject/core/common/errorText.dart';
import 'package:riverpodproject/core/common/loder.dart';
import 'package:riverpodproject/features/auth/controller/authController.dart';
import 'package:riverpodproject/model/userModel.dart';
import 'package:riverpodproject/root.dart';
import 'package:riverpodproject/router/router.dart';
import 'package:riverpodproject/theme/theme.dart';
import 'package:routemaster/routemaster.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
          apiKey:"AIzaSyChmQ-2V2KWfm5nI00IKQqynSkzj1zmVwc",
          appId: "1:866888132232:web:e54a30af79798d7f3f213d",
          messagingSenderId: "866888132232",
          projectId: "riverpodproject",
        ));
  } else {
    //for app initialising
    await Firebase.initializeApp().whenComplete(() => print('Connection success'));
  }

  runApp(const ProviderScope(child: MyApp()));
}
class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  UserModel? userModel;
  Future<void> getData(WidgetRef ref,User data) async {
    userModel=await ref.watch(authControllerProvider.notifier).getUserData(data.uid).first;
    ref.read(userProvider.notifier).update((state) => userModel);
    setState(() {

    });
  }

  Widget build(BuildContext context) {
    return ref.watch(authStatusChangesProvider).when(data: (data){
      return MaterialApp.router(
          title: "redditClone",
          theme: ThemePicker.darkModeAppTheme,
          debugShowCheckedModeBanner: false,


          routerDelegate: RoutemasterDelegate(routesBuilder: (context) {

            if(data!=null){
              getData(ref, data);
              if(userModel!=null){
                return logedInRoute;
              }
            }


              return logedOutRoute;


          } ),
          routeInformationParser: RoutemasterParser());
    },
      error:(error, stackTrace) => ErrorText(text: error.toString()), loading: () => Loader(),);
  }
}

