import 'package:flutter/material.dart';

class AccountOptions extends StatelessWidget {
  const AccountOptions({Key? key, required this.name, required this.onpressed})
      : super(key: key);
  final String name;
  final VoidCallback onpressed;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onpressed,
          child: Container(
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: null,
                  child: Text(
                    name,
                    style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                  ),
                ),
                const IconButton(
                  onPressed: null,
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    size: 17,
                  ),
                ),
              ],
            ),
          ),
        ),
        const Divider(
          thickness: 2,
          height: 5,
        ),
      ],
    );
  }
}
