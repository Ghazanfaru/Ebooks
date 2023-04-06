import 'package:flutter/material.dart';
class TextBooks extends StatefulWidget {
  const TextBooks({Key? key}) : super(key: key);
  @override
  State<TextBooks> createState() => _TextBooksState();
}

class _TextBooksState extends State<TextBooks> {
  @override
  double Value=5;
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff212121),
      body:Center(
        child: Container(
          child:Text('TextBooks'),
        ),
      ),
    );
  }
}