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
           margin: EdgeInsets.only(left: 10,right: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.lightGreen.shade50
            ),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: (){},
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
          height: 10,
        ),
      ],
    );
  }
}
