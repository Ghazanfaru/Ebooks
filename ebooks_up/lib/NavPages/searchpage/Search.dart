import 'package:ebooks_up/NavPages/searchpage/searchedbykey.dart';
import 'package:flutter/material.dart';

import 'SearchClass.dart';
class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String? query;
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
        title:Text("Search"),),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20,),
              Container(
                padding: EdgeInsets.only(right: 30,left: 30),
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextField(
                  onSubmitted: (query){
Navigator.push(context, new MaterialPageRoute(builder: (context)=> new Searchedbykey(query: query)));
print(query);
                  },
                  decoration: InputDecoration(
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
              ),
              SizedBox(height: 20,),
              Container(padding: EdgeInsets.only(top: 20,bottom: 5,left: 20,right: 20),height: 50,child: Text('Browse All Interests',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 22),)),
             SizedBox(height: 20,),
              SearchClass(category: 'Business',),
              SearchClass(category: 'Career & Growth',),
              SearchClass(category: 'Finance and money management',),
              SearchClass(category: 'Politics',),
              SearchClass(category: 'Sports',),
              SearchClass(category: 'Games & Activities',),
              SearchClass(category: 'Comic & Graphic Novels',),
              SearchClass(category: 'Social Science',),
              SearchClass(category: 'Travel',),
              SearchClass(category: 'Philosophy',),
              SearchClass(category: 'Cooking & food',),
              SearchClass(category: 'Study aids & Test Preparation',),
              SearchClass(category: 'Language',),
              SearchClass(category: 'Law',),
              SearchClass(category: 'Self-Improvement',),
              SearchClass(category: 'Science & Mathematics',),
              SearchClass(category: 'Computers',),
              SearchClass(category: 'History',),
              SearchClass(category: 'Fiction',),
              SearchClass(category: 'News ',),
              SearchClass(category: 'Life Style',),
              SearchClass(category: 'General Fiction',),
              SearchClass(category: 'Historical Fiction',),

            ],
          ),
        ),
      ),
    );
  }
}
