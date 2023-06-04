
import 'package:ebooks_up/main.dart';
import 'package:ebooks_up/model/SavedBook.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'AudioBooks.dart';
import 'TextBooks.dart';
class Library extends StatefulWidget {
  const Library({Key? key}) : super(key: key);

  @override
  State<Library> createState() => _SavedState();
}


class _SavedState extends State<Library> {


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar:AppBar(
          centerTitle: true,
            backgroundColor:  const Color(0xff1db954),
            title: const Text('Saved',style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),
            bottom: const TabBar(
              indicatorSize: TabBarIndicatorSize.label,
                  automaticIndicatorColorAdjustment: true,
                  indicatorColor: Color(0xffb3b3b3),
                  unselectedLabelColor: Colors.white,
                  labelColor: Colors.white,
            tabs: [
              Tab(child: Text('Text Books ',style: (TextStyle(fontWeight: FontWeight.w700,color: Color(0xff121212))),),),
              Tab(child: Text('Audio Books',style: (TextStyle(fontWeight: FontWeight.w700,color: Color(0xff121212))),),),
            ],
            ),
            ),
        body: TabBarView(

          children: [
            Hive.box<SavedBook>(Rbooks).isEmpty?Container(
                color: const Color(0xff212121),
                child: const Center(child: Text("No Books in Library",style: TextStyle(color: Colors.white70),),)):const TextBooks(),
            Hive.box<SavedBook>(Abooks).isEmpty?Container(
                color: const Color(0xff212121),
                child: const Center(child: Text("No Books in Library",style: TextStyle(color: Colors.white70),),)):const AudioBooks(),

          ],
        ),
      ),
    );
  }
}
