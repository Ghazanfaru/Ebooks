import 'package:ebooks_up/Login/ResetPage.dart';
import 'package:ebooks_up/Notifications.dart';
import 'package:ebooks_up/SplashScreen.dart';
import 'package:ebooks_up/UpdateProfile.dart';
import 'package:flutter/material.dart';
import 'Login/LoginPage.dart';
import 'NavPages/Accountpage/AccountInfo.dart';
import 'NavPages/Accountpage/Options/Downloads.dart';
import 'NavPages/Accountpage/Options/NotificationSettings.dart';
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
      title: 'eBooks',
      theme: ThemeData(
        hintColor: Color( 0xffb3b3b3),
        textTheme: TextTheme(titleMedium: TextStyle(
            color: Color(0xffb3b3b3)
        )
        ),
textSelectionTheme: TextSelectionThemeData(
  cursorColor: Color( 0xffb3b3b3),
  selectionColor:Color( 0xffb3b3b3).withOpacity(0.2),
  selectionHandleColor:  Color( 0xffb3b3b3),)
      ),
     initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id:(context)=>const SplashScreen(),
        UpdateProfile.id:(context)=>UpdateProfile(),
        Notifications.id:(context)=>const Notifications(),
        ResetPage.id:(context) =>const ResetPage(),
        LoginPage.id: (context) =>LoginPage(),
        SignUpPage.id: (context) =>SignUpPage(),
        Home.id: (context) => Home(),
        AccountInfo.id: (context) => AccountInfo(),
        Downloads.id: (context) => Downloads(),
        NotificationSettings.id: (context) => NotificationSettings()
      },
    );
  }
}

