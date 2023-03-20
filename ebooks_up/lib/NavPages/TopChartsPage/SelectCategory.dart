import 'package:flutter/material.dart';
class SelectCategoryButton extends StatefulWidget {
  const SelectCategoryButton({Key? key, required this.Txt}) : super(key: key);
final String Txt;

  @override
  State<SelectCategoryButton> createState() => _SelectCategoryButtonState();
}

class _SelectCategoryButtonState extends State<SelectCategoryButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(shape: StadiumBorder()),
      onPressed: null,
      child: Text(
        widget.Txt,
        style: TextStyle(
            color: Colors.black54,
            fontSize: 15),
      ),
    );
  }
}