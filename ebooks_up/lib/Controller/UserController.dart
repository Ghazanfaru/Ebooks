import 'package:ebooks_up/NavPages/HomePage/Home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ebooks_up/model/UserModel.dart';
class UserController{
FirebaseAuth auth=FirebaseAuth.instance;

void register(UserModel userModel) async{
  await auth.createUserWithEmailAndPassword(email: userModel.email.toString(), password: userModel.pass.toString());
}
void login(UserModel userModel,BuildContext context)async{
  final user=await auth.signInWithEmailAndPassword(email: userModel.email.toString() , password: userModel.pass.toString());
  if(user!=null){
    Navigator.pushNamed(context, Home.id);
  }
}
void forgotPass(String email)async{
  await auth.sendPasswordResetEmail(email: email);
}

}