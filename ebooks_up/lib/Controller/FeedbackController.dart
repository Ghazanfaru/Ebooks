import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebooks_up/Controller/UserController.dart';
import 'package:fluttertoast/fluttertoast.dart';
class FeedbackController{
  final FirebaseFirestore _store=FirebaseFirestore.instance;
  void AddFeedback(String feedback,double rating){
    UserController user=UserController();
    _store.collection('Feedbacks').add({
      'feedback':feedback,
      'rating' :rating,
      'username':user.getName()
    }).whenComplete(() {
      Fluttertoast.showToast(msg: "Feedback Submitted");
    });
  }
}