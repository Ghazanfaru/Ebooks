import 'package:flutter/material.dart';
import '../TopChartsPage/Rating.dart';

class BookTiles extends StatefulWidget {
  BookTiles(
      {Key? key,
      required this.path,
      required this.name,
      required this.category,
      required this.author})
      : super(key: key);
  final String path;
  final String name;
  final String category;
  final String author;

  @override
  State<BookTiles> createState() => _BookTilesState();
}

class _BookTilesState extends State<BookTiles> {
  int value = 0;
   IconData icon=Icons.bookmark_border;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image(
          image: AssetImage(
            widget.path,
          ),
          width: 80,
          height: 130,
        ),
        const SizedBox(
          width: 17,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.name,
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              widget.category,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              widget.author,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
            ),
            const SizedBox(
              height: 8,
            ),
            const Rating(),
          ],
        ),
        const SizedBox(
          width: 30,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 60),
          child: Column(
            children: [
              IconButton(
                icon: Icon(
                  icon,
                  color: Color(0xff005C29),
                ),
                onPressed: () {
                  setState(() {
                    value = 1 - value;
                    if (value == 1) {
                      icon=Icons.bookmark;
                    } else {
                      icon=Icons.bookmark_border;
                    }
                  });
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
