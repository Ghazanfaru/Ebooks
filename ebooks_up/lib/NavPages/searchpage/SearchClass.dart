import 'package:ebooks_up/NavPages/searchpage/SearchedPage.dart';
import 'package:flutter/material.dart';

class SearchClass extends StatefulWidget {
  String category;
  SearchClass({Key? key, required this.category, }) : super(key: key);

  @override
  State<SearchClass> createState() => _SearchClassState();
}

class _SearchClassState extends State<SearchClass> {


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10,left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextButton(child:Text(widget.category,style: TextStyle(color: Color(0xffb3b3b3),fontWeight: FontWeight.w400,fontSize: 18),),
            onPressed:(){
            Navigator.push(context,new MaterialPageRoute(builder: (context)=> new Searched(category: widget.category,)));
          },),
          Divider(height: 2,thickness: 2,),
        ],
      ),
    );
  }
}
