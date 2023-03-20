import 'package:flutter/material.dart';
class SearchClass extends StatelessWidget {
  const SearchClass({Key? key, required this.interst, required this.onpressed}) : super(key: key);
final String interst;
final VoidCallback onpressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10,left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextButton(child:Text(interst,style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 18),),onPressed:onpressed,),
          Divider(height: 2,thickness: 2,),
        ],
      ),
    );
  }
}
