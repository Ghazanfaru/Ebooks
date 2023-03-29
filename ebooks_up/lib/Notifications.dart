import 'package:flutter/material.dart';
class Notifications extends StatefulWidget {
  static const String id='Notifications';
  const Notifications({Key? key}) : super(key: key);
  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  Color ColorDark=Color(0xff005C29);
  Color ColorLight=Color(0xffE2E5DE);
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
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Notifications',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 22),),
            Divider(thickness: 2,height: 20,),
            Center(child: Text('There are no notifications available here',style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w400),),),
          ],
        ),
      ),
    );
  }
}
