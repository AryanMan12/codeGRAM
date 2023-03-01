import 'package:codegram/responsive/mobile_screen_layout.dart';
import 'package:codegram/responsive/responsive_layout_screen.dart';
import 'package:codegram/responsive/web_screen_layout.dart';
import 'package:codegram/screens/login_screen.dart';
import 'package:codegram/screens/signup_screen.dart';
import 'package:codegram/utils/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyAAupRaEd9j3MbqI_kDydhMc3VdEzcWINs",
        appId: "1:834453311592:web:01c36346f9b4f3ada1ebdd",
        messagingSenderId: "834453311592",
        projectId: "codegram-a0f5b",
        storageBucket: "codegram-a0f5b.appspot.com",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: mobileBackgroundColor,
      ),
      // title: "codeGRAM",
      // home: const ResponiveLayout(
      //  mobileScreenLayout: MobileScreenLayout(),
      // webScreenLayout: WebScreenLayout()),
      home: MobileScreenLayout(),
    );
  }
}
