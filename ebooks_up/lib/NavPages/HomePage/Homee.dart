import 'package:ebooks_up/Notifications.dart';
import 'package:flutter/material.dart';
import 'AudiableBooks/AuidableBooks.dart';
import 'ReadableBooks/ReadableBooks.dart';

class Homee extends StatefulWidget {
  const Homee({Key? key}) : super(key: key);

  @override
  State<Homee> createState() => _HomeeState();
}

class _HomeeState extends State<Homee> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom:Radius.circular(20),
              )
          ),
          centerTitle: true,
          backgroundColor: Color(0xff005C29),
          title: Column(
            children: const [
              Padding(
                padding: EdgeInsets.only(
                  top: 15,
                  bottom: 5,
                ),
                child: Text(
                  'E Books',
                  style: (TextStyle(color: Colors.white,fontWeight: FontWeight.w400)),
                ),
              ),
            ],
          ),
          actions: [
            IconButton(onPressed: (){
              Navigator.pushNamed(context, Notifications.id);
            }, icon: Icon(Icons.notifications_active_outlined,size: 25,)),
          ],
          bottom: const TabBar(
            indicatorColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorWeight: 3,
            tabs: [
              Tab(
                child: Text(
                  'Readable Books',
                  style: (TextStyle(color: Colors.white,fontWeight: FontWeight.w400)),
                ),
              ),
              Tab(
                child: Text(
                  'Audible Books',
                  style: (TextStyle(color: Colors.white,fontWeight: FontWeight.w400)),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ReadableBooks(),
            AudiableBooks(),
          ],
        ),
      ),
    );
  }
}
