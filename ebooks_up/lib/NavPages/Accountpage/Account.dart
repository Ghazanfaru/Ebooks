import 'package:flutter/material.dart';
import 'AccountInfo.dart';
import 'AccountOptions.dart';
import 'Options/Downloads.dart';
import 'Options/Faqs.dart';
import 'Options/InviteFriend.dart';
import 'Options/NotificationSettings.dart';

class Account extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE2E5DE),
      appBar: AppBar(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom:Radius.circular(15),
            )
        ),
        centerTitle: true,
        backgroundColor: Color(0xff005C29),
        toolbarHeight: 60,
        title:const Text(
          'Account',
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.w400),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.asset(
                            'lib/assets/images/profileimg.png',
                            width: 70,
                            height: 70,
                          ))),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    'Hi, Name',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const Divider(
              thickness: 2,
              height: 5,
            ),
            AccountOptions(name: 'Account Information', onpressed: (){Navigator.pushNamed(context,AccountInfo.id);},),
            AccountOptions(name: 'FAQ\'s & Support',onpressed: (){Navigator.pushNamed(context,Faqs.id);},),
            AccountOptions(name: 'Downloads',onpressed: (){Navigator.pushNamed(context, Downloads.id);},),
            AccountOptions(name: 'Notification Settings', onpressed:(){Navigator.pushNamed(context, NotificationSettings.id);}),
            AccountOptions(name: 'Invite friends', onpressed: (){Navigator.pushNamed(context,InviteFriend.id);}),
          ],
        ),
      ),
    );
  }
}
