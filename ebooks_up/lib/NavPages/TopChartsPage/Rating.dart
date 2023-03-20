import 'package:flutter/material.dart';
class Rating extends StatefulWidget {
  const Rating({Key? key}) : super(key: key);

  @override
  State<Rating> createState() => _RatingState();
}

class _RatingState extends State<Rating> {
  var _myColorOne = Colors.grey;
  var _myColorTwo = Colors.grey;
  var _myColorThree = Colors.grey;
  var _myColorFour = Colors.grey;
  var _myColorFive = Colors.grey;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
      GestureDetector(child: Icon(Icons.star,color: _myColorOne,size: 17,),onTap: (){
        setState(() {
          _myColorOne=Colors.orange;
          _myColorTwo=Colors.grey;
          _myColorThree=Colors.grey;
          _myColorFour=Colors.grey;
          _myColorFive=Colors.grey;
        });
      },),
        GestureDetector(child: Icon(Icons.star,color: _myColorTwo,size: 17,),onTap: (){
          setState(() {
            _myColorOne=Colors.orange;
            _myColorTwo=Colors.orange;
            _myColorThree=Colors.grey;
            _myColorFour=Colors.grey;
            _myColorFive=Colors.grey;
          });
        },),
        GestureDetector(child: Icon(Icons.star,color: _myColorThree,size: 17,),onTap: (){
          setState(() {
            _myColorOne=Colors.orange;
            _myColorTwo=Colors.orange;
            _myColorThree=Colors.orange;
            _myColorFour=Colors.grey;
            _myColorFive=Colors.grey;
          });
        },),
        GestureDetector(child: Icon(Icons.star,color: _myColorFour,size: 17,),onTap: (){
          setState(() {
            _myColorOne=Colors.orange;
            _myColorTwo=Colors.orange;
            _myColorThree=Colors.orange;
            _myColorFour=Colors.orange;
            _myColorFive=Colors.grey;
          });
        },),
        GestureDetector(child: Icon(Icons.star,color: _myColorFive,size: 17,),onTap: (){
          setState(() {
            _myColorOne=Colors.orange;
            _myColorTwo=Colors.orange;
            _myColorThree=Colors.orange;
            _myColorFour=Colors.orange;
            _myColorFive=Colors.orange;
          });
        },),
        ],
    );
  }
}
