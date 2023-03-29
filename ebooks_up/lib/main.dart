import 'package:ebooks_up/Login/ResetPage.dart';
import 'package:ebooks_up/NavPages/HomePage/PDFViewer.dart';
import 'package:ebooks_up/Notifications.dart';
import 'package:ebooks_up/SplashScreen.dart';
import 'package:ebooks_up/UpdateProfile.dart';
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
import 'package:firebase_core/firebase_core.dart';
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


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'e-books',
      theme: ThemeData(
      ),
     initialRoute: LoginPage.id,
      routes: {
        SplashScreen.id:(context)=>SplashScreen(),
        UpdateProfile.id:(context)=>UpdateProfile(),
        Notifications.id:(context)=>Notifications(),
        ResetPage.id:(context) =>ResetPage(),
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

