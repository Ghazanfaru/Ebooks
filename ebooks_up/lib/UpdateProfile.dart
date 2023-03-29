import 'dart:async';

import 'package:flutter/material.dart';
class UpdateProfile extends StatefulWidget {
  static const String id='UpdateProfile';
  @override
  State<UpdateProfile> createState() => _AccountInfoState();
}
class _AccountInfoState extends State<UpdateProfile> {
  @override
  int btntitle=0;
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE2E5DE),
     appBar:  AppBar(
       shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.vertical(
             bottom:Radius.circular(10),
           )
       ),
       centerTitle: true,

       backgroundColor: Color(0xff005C29),
       title: const Text(
         "Update Profile",
         style: TextStyle(
             color: Colors.white, fontSize: 22, fontWeight: FontWeight.w400),
       ),
     ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children:[
              SizedBox(height: 30,),
              Text('Update Name',style: TextStyle(color: Colors.black54,fontWeight:FontWeight.bold,fontSize: 18),),
              SizedBox(height: 20,),
              TextField(textAlign: TextAlign.start,
                cursorColor: Color(0xff005C29),
                toolbarOptions:const ToolbarOptions(
                    copy: true, cut: true, paste: true, selectAll: true),
                decoration: InputDecoration(
                  labelText: 'Enter name',labelStyle: TextStyle(color: Color(0xff005C29),fontStyle: FontStyle.italic),
                  hintStyle:const TextStyle(fontSize: 12, color: Color(0xff005C29),),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide:const BorderSide(
                      color: Color(0xff005C29),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide:const BorderSide(
                      color: Color(0xff005C29),
                    ),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  fillColor: Colors.white,
                  contentPadding:const EdgeInsets.only(bottom: 10,left: 30),
                  filled: true,
               ),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(left: 220),
                child: Container(
                  decoration: BoxDecoration(
                      color: Color(0xff005C29),
                      borderRadius: BorderRadius.circular(30)
                  ),
                  height: 37,
                  width: 122,
                  child: TextButton(
                    child:btntitle==0?const Text('Change',style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.w400),):Container(width: 15,height: 25,child: CircularProgressIndicator(color: Colors.white,),),
                    onPressed: () {
                    },
                  ),
                ),
              ),
              SizedBox(height: 30,),

              Text('Update Password',style: TextStyle(color: Colors.black54,fontWeight:FontWeight.bold,fontSize: 18),),
              SizedBox(height: 20,),
              TextField(textAlign: TextAlign.start,
                cursorColor: Color(0xff005C29),
                toolbarOptions:const ToolbarOptions(
                    copy: true, cut: true, paste: true, selectAll: true),
                decoration: InputDecoration(
                  labelText: 'Old Password',labelStyle: TextStyle(color: Color(0xff005C29),fontStyle: FontStyle.italic),
                  hintStyle:const TextStyle(fontSize: 12, color: Color(0xff005C29)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide:const BorderSide(
                      color: Color(0xff005C29),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide:const BorderSide(
                      color: Color(0xff005C29),
                    ),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  fillColor: Colors.white,
                  contentPadding:const EdgeInsets.only(bottom: 10,left: 30),
                  filled: true,
                ),
              ),
              SizedBox(height: 30,),
              TextField(textAlign: TextAlign.start,
                cursorColor: Color(0xff005C29),
                toolbarOptions:const ToolbarOptions(
                    copy: true, cut: true, paste: true, selectAll: true),
                decoration: InputDecoration(
                  labelText: 'New Password',labelStyle: TextStyle(color: Color(0xff005C29),fontStyle: FontStyle.italic),
                  hintStyle:const TextStyle(fontSize: 12, color: Color(0xff005C29)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide:const BorderSide(
                      color: Color(0xff005C29),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide:const BorderSide(
                      color: Color(0xff005C29),
                    ),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  fillColor: Colors.white,
                  contentPadding:const EdgeInsets.only(bottom: 10,left: 30),
                  filled: true,
                ),
              ),
              SizedBox(height: 10,),
              TextField(textAlign: TextAlign.start,
                cursorColor: Color(0xff005C29),
                toolbarOptions:const ToolbarOptions(
                    copy: true, cut: true, paste: true, selectAll: true),
                decoration: InputDecoration(
                  labelText: 'Confirm Password',labelStyle: TextStyle(color: Color(0xff005C29),fontStyle: FontStyle.italic),
                  hintStyle:const TextStyle(fontSize: 12, color: Color(0xff005C29),),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide:const BorderSide(
                      color: Color(0xff005C29),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide:const BorderSide(
                      color: Color(0xff005C29),
                    ),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  fillColor: Colors.white,
                  contentPadding:const EdgeInsets.only(bottom: 10,left: 30),
                  filled: true,
                ),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(left: 220),
                child: Container(
                  decoration: BoxDecoration(
                      color: Color(0xff005C29),
                      borderRadius: BorderRadius.circular(30)
                  ),
                  height: 37,
                  width: 122,
                  child: TextButton(
                    child:btntitle==0?const Text('Change',style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.w400),):Container(width: 15,height: 25,child: CircularProgressIndicator(color: Colors.white,),),
                    onPressed: () {
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}