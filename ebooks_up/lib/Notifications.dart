import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ebooks_up/model/Notification.dart';
class Notifications extends StatefulWidget {
  static const String id='Notifications';
  const Notifications({Key? key}) : super(key: key);
  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  Color ColorDark=const Color(0xff1db954);
  Color ColorLight=const Color(0xffE2E5DE);
  FirebaseFirestore store=FirebaseFirestore.instance;

  bool? hasNewData;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff212121),
      appBar: AppBar(
        backgroundColor: ColorDark,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom:Radius.circular(10),
            )
        ),
        centerTitle: true,

        title: const Text('Notifications',style: TextStyle(fontWeight: FontWeight.w400,color: Colors.white,fontSize: 20),),
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
              news.time=snapshot.data?.docs[index]['time'];
              news.title=snapshot.data?.docs[index]['title'];
             if(snapshot.hasData){
                 hasNewData = snapshot.data!.docChanges.isNotEmpty;
              return Container(
                decoration: BoxDecoration(
                  color: Colors.blueGrey.withOpacity(0.5),
                  border: const Border(
                    bottom: BorderSide( color: Colors.blueGrey,
                      width: 1,),
                  )
                ),
                padding: const EdgeInsets.only(top: 20),
                child: CupertinoListTile(
                  subtitle: Column(
                    children: [
                      Text(news.notification.toString(),
                        style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white70,
                      ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 10,),
                      Text("${news.time!.toDate()}",
                        style: const TextStyle(
                          fontSize: 14,
                            fontWeight: FontWeight.bold,
                          color: Colors.blueGrey
                        ),)
                    ],
                  ),
                  leading:const Icon(Icons.notifications,color: Colors.green,size: 28,),
                  title:Text(news.title.toString(),style:
                  const TextStyle(fontWeight:FontWeight.bold ,
                  color: Colors.green
                  ),),
                ),
              );
            }
             else {
               return const Center(child: Text("No Notifications."),);
             }
             },
          );
        },
      )
    );
  }
}
