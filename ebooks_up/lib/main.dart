import 'package:ebooks_up/Login/ResetPage.dart';
import 'package:ebooks_up/Notifications.dart';
import 'package:ebooks_up/SplashScreen.dart';
import 'package:ebooks_up/UpdateProfile.dart';
import 'package:ebooks_up/model/Bookmark.dart';
import 'package:ebooks_up/model/SavedBook.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'Login/LoginPage.dart';
import 'NavPages/Accountpage/AccountInfo.dart';
import 'NavPages/Accountpage/Options/Downloads.dart';
import 'NavPages/Accountpage/Options/NotificationSettings.dart';
import 'NavPages/HomePage/Home.dart';
import 'Signup/SignUpPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:hive_flutter/hive_flutter.dart';



// ignore: constant_identifier_names
const String Rbooks= 'Textbooks';
const String Abooks='Audiobooks';
const String RBM='readBookmark';
const String checkNewUSer = 'newUser';
const String Bookmarks='bookmarks';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter<SavedBook>(SavedBookAdapter());
  Hive.registerAdapter<Bookmark>(BookmarkAdapter());
  await Hive.openBox<SavedBook>(Rbooks);
  await Hive.openBox<SavedBook>(Abooks);
  await Hive.openBox<Bookmark>(RBM);
  await Hive.openBox(checkNewUSer);
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
      darkTheme: ThemeData(

      ),
      theme: ThemeData(
          hintColor: const Color(0xffb3b3b3),
          textTheme:
          const TextTheme(
              titleMedium: TextStyle(color: Color(0xffb3b3b3))),
              backgroundColor: const Color(0xff212121),

              textSelectionTheme: TextSelectionThemeData(
                cursorColor: const Color(0xffb3b3b3),
                selectionColor: const Color(0xffb3b3b3).withOpacity(0.2),
                selectionHandleColor: const Color(0xffb3b3b3),
              )
      ),

      initialRoute:SplashScreen.id,

      routes: {

        SplashScreen.id: (context) => const SplashScreen(),
        UpdateProfile.id: (context) => UpdateProfile(),
        Notifications.id: (context) => const Notifications(),
        ResetPage.id: (context) => const ResetPage(),
        LoginPage.id: (context) => LoginPage(),
        SignUpPage.id: (context) => SignUpPage(),
        Home.id: (context) => const Home(),
        AccountInfo.id: (context) => AccountInfo(),
        Downloads.id: (context) => Downloads(),
        NotificationSettings.id: (context) => NotificationSettings()
      },
    );
  }
}
