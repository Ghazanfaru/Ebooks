import 'package:flutter/material.dart';
class AccountInfo extends StatefulWidget {
  static const String id='AccountInfo';
  @override
  State<AccountInfo> createState() => _AccountInfoState();
}
class _AccountInfoState extends State<AccountInfo> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body:  Center(child: Text('Account Info')),
    );
  }
}