
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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom:Radius.circular(20),
            )
          ),
          centerTitle: true,
            backgroundColor: const Color(0xff005C29),
            title: const Text('Saved',style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.w400),),
            bottom: const TabBar(
              indicatorSize: TabBarIndicatorSize.label,
                  automaticIndicatorColorAdjustment: true,
                  indicatorColor: Colors.white,
                  unselectedLabelColor: Colors.white,
                  labelColor: Colors.white,
            tabs: [
              Tab(child: Text('Text Books ',style: (TextStyle(fontSize: 17,fontWeight: FontWeight.w400)),),),
              Tab(child: Text('Audio Books',style: (TextStyle(fontSize: 17,fontWeight: FontWeight.w400)),),),
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
