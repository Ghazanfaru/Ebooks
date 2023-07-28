import 'package:ebooks_up/Controller/FeedbackController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
class Feedbacks extends StatefulWidget {
  static const String id = 'Feedbacks';
  @override
  State<Feedbacks> createState() => _FeedbacksState();
}

class _FeedbacksState extends State<Feedbacks> {
  double _rating=0;
  final TextEditingController _feedbackController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff1db954),
        title: const Text('Feedback'),
      ),
      body: Container(
        color: const Color(0xff212121),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Provide Feedback',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _feedbackController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: 'Enter your feedback',
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff1db954)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff1db954)),
                ),
              ),
              maxLines: 5,
            ),
            const SizedBox(height: 16.0),
            RatingBar.builder(
              initialRating: 0,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.orange,
              ),
              onRatingUpdate: (rating) {
                setState(() {
                  _rating=rating;
                });
              },
            ),
            const SizedBox(height: 25),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: const Color(0xff1db954),
                onPrimary: Colors.white,
              ),
              onPressed: () {
                FeedbackController feedback=FeedbackController();
                feedback.AddFeedback(_feedbackController.text, _rating);
                setState(() {
                  _rating=0;
                  _feedbackController.text='';
                });
              },
              child: const Text('Submit Feedback'),
            ),
          ],
        ),
      ),
    );
  }
}