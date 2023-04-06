
import 'package:flutter/material.dart';
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
            backgroundColor:  Color(0xff1db954),
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
            TextBooks(),
            AudioBooks(),

          ],
        ),
      ),
    );
  }
}
