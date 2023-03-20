import 'package:flutter/material.dart';

import 'SearchClass.dart';
class Search extends StatelessWidget {
  const Search({Key? key}) : super(key: key);

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
        toolbarHeight: 70,
        backgroundColor: Color(0xff005C29),
        title: Container(
          padding: EdgeInsets.only(right: 30),
          height: 40,
          decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
          ),
          child: TextField(decoration: InputDecoration(
            hintText: 'Search the World\'s most popular books',
            hintStyle: TextStyle(fontSize: 12,color: Color(0xff005C29)),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide: BorderSide(color: Colors.black54,),
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            focusColor: Colors.green,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.only(bottom: 10),
            filled: true,
            prefixIcon: Icon(Icons.search,color: Color(0xff005C29),),
          ),),
        ),),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(padding: EdgeInsets.only(top: 20,bottom: 5,left: 20,right: 20),height: 50,child: Text('Browse All Interests',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 22),)),
             SizedBox(height: 20,),
              SearchClass( interst: 'Business', onpressed: () {  },),
              SearchClass( interst: 'Career & Growth', onpressed: () {  },),
              SearchClass( interst: 'Finance and money management', onpressed: () {  },),
              SearchClass( interst: 'Politics', onpressed: () {  },),
              SearchClass( interst: 'Sports', onpressed: () {  },),
              SearchClass( interst: 'Games & Activities', onpressed: () {  },),
              SearchClass( interst: 'Comic & Graphic Novels', onpressed: () {  },),
              SearchClass( interst: 'Social Science', onpressed: () {  },),
              SearchClass( interst: 'Travel', onpressed: () {  },),
              SearchClass( interst: 'Philophy', onpressed: () {  },),
              SearchClass( interst: 'Cooking & food', onpressed: () {  },),
              SearchClass( interst: 'Study aids & Test Preparation', onpressed: () {  },),
              SearchClass( interst: 'Language', onpressed: () {  },),
              SearchClass( interst: 'Law', onpressed: () {  },),
              SearchClass( interst: 'Self-Improvement', onpressed: () {  },),
              SearchClass( interst: 'Science & Mathematics', onpressed: () {  },),
              SearchClass( interst: 'Computers', onpressed: () {  },),
              SearchClass( interst: 'History', onpressed: () {  },),
              SearchClass( interst: 'Fiction', onpressed: () {  },),
              SearchClass( interst: 'News ', onpressed: () {  },),
              SearchClass( interst: 'Life Style', onpressed: () {  },),
              SearchClass( interst: 'General Fiction', onpressed: () {  },),
              SearchClass( interst: 'Historical Fiction', onpressed: () {  },),
            ],
          ),
        ),
      ),
    );
  }
}
