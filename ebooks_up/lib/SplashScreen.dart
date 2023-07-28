import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:ebooks_up/Login/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  static String id = 'SplashScreen';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        splash: Lottie.asset(
          'lib/assets/splash/SplashScreen.json',
        ),
        backgroundColor: const Color(0xff1db954),
        nextScreen: LoginPage());
  }
}
