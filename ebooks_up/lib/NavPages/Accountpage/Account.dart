import 'package:ebooks_up/UpdateProfile.dart';
import 'package:flutter/material.dart';
import 'AccountOptions.dart';
import 'Options/Downloads.dart';
import 'Options/NotificationSettings.dart';
import 'package:ebooks_up/Controller/UserController.dart';
import 'package:ebooks_up/Login/LoginPage.dart';
import 'package:ebooks_up/model/UserModel.dart';

class Account extends StatelessWidget {

UserController controller=UserController();
UserModel model=UserModel();


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
                  Text(
                    'Hi, ${controller.getName()}.',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const Divider(
              height: 10,
            ),
            AccountOptions(name: 'Update Profile', onpressed: (){Navigator.pushNamed(context,UpdateProfile.id);},),
            AccountOptions(name: 'Downloads',onpressed: (){Navigator.pushNamed(context, Downloads.id);},),
            AccountOptions(name: 'Notification Settings', onpressed:(){Navigator.pushNamed(context, NotificationSettings.id);}),
            AccountOptions(name: 'Log Out', onpressed: (){controller.logout();Navigator.pushNamed(context, LoginPage.id);}),

          ],
        ),
      ),
    );
  }
}
