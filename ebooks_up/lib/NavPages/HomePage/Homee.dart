import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebooks_up/Notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'AudiableBooks/AuidableBooks.dart';
import 'ReadableBooks/ReadableBooks.dart';

class Homee extends StatefulWidget {
  const Homee({Key? key}) : super(key: key);

  @override
  State<Homee> createState() => _HomeeState();
}

class _HomeeState extends State<Homee> {
  TimeOfDay day=TimeOfDay.now();
  Icon notificationIcon=const Icon(Icons.notifications_none);
  Stream<QuerySnapshot<Map<String,dynamic>>> notficiations=FirebaseFirestore.instance.collection('news').snapshots();

  Future<void> updateIcon()async{
    notficiations.listen((event) {
      if(event.docs.isNotEmpty){
        setState(() {
           notificationIcon=const Icon(Icons.notifications_active_rounded);
        });
      }
      updateIcon();
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color(0xff1db954),
          title: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 15,
                  bottom: 5,
                ),
                child: day.period==DayPeriod.am?const Text(
                  'Good Morning!',
                  style: (TextStyle(color: Color(0xffffffff),fontWeight: FontWeight.bold)),
                ):const Text(
                  'Good Evening!',
                  style: (TextStyle(color: Color(0xffffffff),fontWeight: FontWeight.bold)),
                )
              ),
            ],
          ),
          actions: [
            IconButton(onPressed: (){
              Navigator.pushNamed(context, Notifications.id);
            }, icon: notificationIcon,)
          ],
          bottom: const TabBar(
            indicatorColor: Color(0xffb3b3b3),
            indicatorSize: TabBarIndicatorSize.label,
            indicatorWeight: 3,
            tabs: [
              Tab(
                child: Text(
                  'Text Books',
                  style: (TextStyle(color: Color(0xff212121),fontWeight: FontWeight.w700)),
                ),
              ),
              Tab(
                child: Text(
                  'Audio Books',
                  style: (TextStyle(color: Color(0xff212121),fontWeight: FontWeight.w700)),
                ),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            ReadableBooks(),
            AudiableBooks(),
          ],
        ),
      ),
    );
  }
}
