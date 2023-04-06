import 'package:flutter/material.dart';

class TextButtons extends StatelessWidget {
  const TextButtons({Key? key, required this.text, required this.btntxt})
      : super(key: key);
  final String text;
  final String btntxt;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20,color: Color(0xffb3b3b3)),
              ),
              Row(
                children: [
                  Text(
                    btntxt,
                    style: const TextStyle(
                        color: Color(0xffb3b3b3),
                        fontWeight: FontWeight.w600,
                        fontSize: 15),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 18,
                    color: Colors.green,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
