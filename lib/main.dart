import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:scholer_chat_app/pages/chat_page.dart';
import 'package:scholer_chat_app/pages/sign_in.dart';
import 'package:scholer_chat_app/pages/sign_up_page.dart';
import 'package:scholer_chat_app/pages/splash_page.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Scholar Chat',
      routes: {
        SplashPage.id :(context) =>SplashPage(),
        SignInPage.id : (context) => SignInPage(),
        SignUpPage.id : (context) => SignUpPage(),
        ChatPage.id : (context) => ChatPage(),
      },
      initialRoute: SplashPage.id,
    );
  }
}

