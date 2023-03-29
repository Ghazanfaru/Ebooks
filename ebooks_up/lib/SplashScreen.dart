import 'dart:async';

import 'package:ebooks_up/Login/LoginPage.dart';
import 'package:flutter/material.dart';
class SplashScreen extends StatefulWidget {
  static const String id='SplashScreen';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();
 Timer(Duration(seconds: 3),(){Navigator.pushNamed(context, LoginPage.id);});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color(0xffE2E5DE) ,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Image.asset('lib/assets/images/logo1.png'),
          ),
          Text("Ebooks Application",style: TextStyle(color: Colors.black,fontSize: 22,fontWeight: FontWeight.bold),),
        ],
      ),
    );
  }
}
