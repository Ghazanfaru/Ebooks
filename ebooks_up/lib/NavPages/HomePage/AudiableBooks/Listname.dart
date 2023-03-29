import 'package:flutter/material.dart';

class TextButtons extends StatelessWidget {
  const TextButtons({Key? key, required this.text, required this.btntxt})
      : super(key: key);
  final String text;
  final String btntxt;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20,color: Colors.black),
          ),
          Container(
            child: Row(
              children: [
                Text(
                  btntxt,
                  style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                  color: Colors.green,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
