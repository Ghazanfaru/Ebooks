import 'package:responsive_framework/responsive_framework.dart';
import 'package:flutter/material.dart';
import 'Login/LoginPage.dart';
import 'NavPages/Accountpage/AccountInfo.dart';
import 'NavPages/Accountpage/Options/Downloads.dart';
import 'NavPages/Accountpage/Options/Faqs.dart';
import 'NavPages/Accountpage/Options/InviteFriend.dart';
import 'NavPages/Accountpage/Options/NotificationSettings.dart';
import 'NavPages/Accountpage/Options/Shortcuts.dart';
import 'NavPages/HomePage/Home.dart';
import 'Signup/SignUpPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'e-books',
      theme: ThemeData(
      ),
     initialRoute: LoginPage.id,
      routes: {
        LoginPage.id: (context) =>LoginPage(),
        SignUpPage.id: (context) =>SignUpPage(),
        Home.id: (context) => Home(),
        AccountInfo.id: (context) => AccountInfo(),
        Faqs.id: (context) => Faqs(),
        Downloads.id: (context) => Downloads(),
        NotificationSettings.id: (context) => NotificationSettings(),
        Shortcutss.id: (context) => Shortcutss(),
        InviteFriend.id: (context) => InviteFriend(),
      },
    );
  }
}

