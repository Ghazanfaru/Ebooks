import 'package:flutter/material.dart';
class AudioBooks extends StatelessWidget {
  const AudioBooks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE2E5DE),
      body:Container(
        child:Center(child: Text('Audio Books')),
      ),
    );
  }
}