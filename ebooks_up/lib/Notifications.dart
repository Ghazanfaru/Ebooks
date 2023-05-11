import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ebooks_up/model/Notification.dart';
class Notifications extends StatefulWidget {
  static const String id='Notifications';
  const Notifications({Key? key}) : super(key: key);
  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  Color ColorDark=Color(0xff1db954);
  Color ColorLight=Color(0xffE2E5DE);
  FirebaseFirestore store=FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorLight,
      appBar: AppBar(
        backgroundColor: ColorDark,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom:Radius.circular(10),
            )
        ),
        centerTitle: true,

        title: Text('Notifications',style: TextStyle(fontWeight: FontWeight.w400,color: Colors.white,fontSize: 20),),
      ),
      body:StreamBuilder<QuerySnapshot<Map<String,dynamic>>>(
        stream: store.collection('news').snapshots(),
        builder: (context,AsyncSnapshot snapshot){
          return ListView.builder(
            itemCount: snapshot.data?.docs.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context,int index){
              News news=News();
              news.notification=snapshot.data?.docs[index]['notification'];
              return Container(
                child: TextButton(
                  onPressed: (){},
                  child: Text(news.notification.toString()),

                ),
              );
            },
          );
        },
      )
    );
  }
}
