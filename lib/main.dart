// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, use_key_in_widget_constructors
import 'home_page.dart';
import 'model/firebaseUser.dart';
import 'pages/account/login.dart';
import 'authentication/userAuthentication.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var currentUserEmail = prefs.getString('email');
  runApp(MobileApp(currentUserEmail));
}

class MobileApp extends StatelessWidget {
  MobileApp(this.currentUserEmail);
  final dynamic currentUserEmail;

  @override
  Widget build(BuildContext context) {
    return StreamProvider<FirebaseUser?>.value(
      value: Authentication().user,
      initialData: null,
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: currentUserEmail == null ? Login() : HomePage(),
      ),
    );
  }
}
