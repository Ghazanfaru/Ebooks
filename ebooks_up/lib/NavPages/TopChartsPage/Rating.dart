import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Rating extends StatefulWidget {
  String type;
  String documentID;
  int oldRating;
  Rating(
      {Key? key,
      required this.type,
      required this.documentID,
      required this.oldRating})
      : super(key: key);
  @override
  State<Rating> createState() => _RatingState();
}


class _RatingState extends State<Rating> {
  var _myColorOne = Colors.grey;
  var _myColorTwo = Colors.grey;
  var _myColorThree = Colors.grey;
  var _myColorFour = Colors.grey;
  var _myColorFive = Colors.grey;
  double? rating;


  TextEditingController feedbackController=TextEditingController();

  int? selectedRating;
@override
void initState() {
    // TODO: implement initState
    super.initState();
 innit();

  }

  Future<void> innit() async{
  FirebaseFirestore store=FirebaseFirestore.instance;
   rating=await fetchAndCalculateAverage(widget.documentID);
    setState(() {
      updateRating(rating!);
    });
    if(widget.type=='text'){
    store.collection('text').doc(widget.documentID).update({
      'rating': rating
    });
    }
    else if(widget.type=='audio'){
      store.collection('audio').doc(widget.documentID).update({
        'rating':rating
      });
    }
  }
  // ignore: prefer_typing_uninitialized_variables

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: (){
        showDialog(context: context, builder: (context)=> AlertDialog(
          backgroundColor: const Color(0xff212121),
          content: Container(
            height: 150,
            width: 300,
            child: Column(
              children: [
                TextField(
                  controller: feedbackController,
                  decoration: const InputDecoration(
                    labelText: 'Review',
                    labelStyle: TextStyle(color: Colors.green),
                    focusColor: Colors.green,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff1db954)),
                    ),
                  ),
                ),
            const SizedBox(
              height: 30,
            ),
            RatingBar.builder(
              initialRating: 0,
              minRating: 1,
              maxRating: 5,
              itemCount: 5,
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                selectedRating = rating.toInt();
              },)
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context),
                child: const Text("Cancel",style: TextStyle(color: Colors.green),)),
            TextButton(onPressed: ()async{

              await setRating(widget.type, widget.documentID, selectedRating,feedbackController.text);
              // ignore: use_build_context_synchronously
              Navigator.pop(context);
             await Fluttertoast.showToast(msg: "Thank You! :)",
                toastLength:Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0
              );

            }, child: const Text("Submit",style: TextStyle(color: Colors.green),))
          ],
        ));
      },
      child: Row(
        children: [
          Icon(
            Icons.star,
            color: _myColorOne,
            size: 17,
          ),
          Icon(
            Icons.star,
            color: _myColorTwo,
            size: 17,
          ),
          Icon(
            Icons.star,
            color: _myColorThree,
            size: 17,
          ),
          Icon(
            Icons.star,
            color: _myColorFour,
            size: 17,
          ),
          Icon(
            Icons.star,
            color: _myColorFive,
            size: 17,
          ),
          const SizedBox(width: 5,),
          Text(rating.toString(),style: const TextStyle(
              color: Colors.white),)
        ],
      ),
    );
  }
Future<void> updateRating(double rating)async{
    int ratingInInt=(rating).toInt();
  switch(ratingInInt){
    case 1: _myColorOne=Colors.orange;
    break;
    case 2:_myColorOne=Colors.orange;
    _myColorTwo=Colors.orange;
    break;
    case 3: _myColorOne=Colors.orange;
    _myColorTwo=Colors.orange;
    _myColorThree=Colors.orange;
    break;
    case 4: _myColorOne=Colors.orange;
    _myColorTwo=Colors.orange;
    _myColorThree=Colors.orange;
    _myColorFour=Colors.orange;
    break;
    case 5: _myColorOne=Colors.orange;
    _myColorTwo=Colors.orange;
    _myColorThree=Colors.orange;
    _myColorFour=Colors.orange;
    _myColorFive=Colors.orange;
  }
}


  Future<void> setRating(String type, String documentID, dynamic rating,String review) async {
    FirebaseFirestore store = FirebaseFirestore.instance;


    store.collection("ratings").add({
      'book_id': documentID,
      'type': type,
      'rating': rating,
      'review': review
    });
  }
  Future<double> fetchAndCalculateAverage(String bookId) async {
    // ignore: prefer_typing_uninitialized_variables
    var averageRating=0.0;
    var totalRatings =0;

    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('ratings')
        .where('book_id', isEqualTo: bookId)
        .get();

    if (snapshot.size > 0) {
      for (var doc in snapshot.docs) {
        averageRating += doc['rating'];
        totalRatings++;
      }
      averageRating /= totalRatings;
    }
    return averageRating;
  }
}
