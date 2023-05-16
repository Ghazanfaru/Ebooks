import 'package:ebooks_up/NavPages/HomePage/Home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ebooks_up/model/UserModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
class UserController{
FirebaseAuth auth=FirebaseAuth.instance;
FirebaseFirestore store=FirebaseFirestore.instance;
String? Exception;
String? id;
GoogleSignIn _googleSignIn = GoogleSignIn();

void register(UserModel userModel) async{
  try {
    UserCredential user = await auth.createUserWithEmailAndPassword(
        email: userModel.email.toString(), password: userModel.pass.toString());
    id=user.user!.uid;
    setName(userModel.Uname.toString());
  } on FirebaseAuthException catch(e){
    Exception=e.code;
  }

}
void login(UserModel userModel,BuildContext context)async{
 try {
   UserCredential user = await auth.signInWithEmailAndPassword(
       email: userModel.email.toString(), password: userModel.pass.toString());
  if(user!=null){
    Navigator.pushReplacementNamed(context, Home.id);
  }
 }on FirebaseAuthException catch(e){
   showDialog(context: context, builder: (BuildContext context){
     return AlertDialog(
       content: Text(e.code),
       actions: [
         TextButton(onPressed: (){Navigator.pop(context);}, child: Text("Try Again"))
       ],
     );
   });
 }
}

void updatePass(String oldpass, String Pass)async{
   User? user=await auth.currentUser;
  AuthCredential credential=EmailAuthProvider.credential(email: user!.email.toString(), password: oldpass);
  await user.reauthenticateWithCredential(credential).whenComplete(() {
    user.updatePassword(Pass);
  });

}
void forgotPass(String email,BuildContext context)async{
  await auth.sendPasswordResetEmail(email: email).onError((error, stackTrace) => showDialog(context: context, builder: (BuildContext context){
    return AlertDialog(
      content: Text(error.toString()),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: Text("Try Again"))
      ],
    );
  }));
}

void logout()async{
  await auth.signOut();
  await _googleSignIn.signOut();
}

void addUsername(UserModel model) async {
  try {
    await FirebaseFirestore.instance.collection('users').doc(id).set({
      'username': model.Uname,
      'email':model.email,
      'User_id': id
    });
    print(model.Uname);
  } on FirebaseException catch (e) {
Exception=e.code;
  }
}
String? getName(){
  String? name= FirebaseAuth.instance.currentUser!.displayName.toString();
  return name;
}

void setName(String displaName)async{
User? user=auth.currentUser;
if(user!=null){
  await user.updateDisplayName(displaName);
}
}

Future<UserCredential> signInWithGoogle(BuildContext context) async {
  // Trigger the Google authentication flow
  final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
  final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );
  return await auth.signInWithCredential(credential).whenComplete(() => {
  Navigator.pushReplacementNamed(context, Home.id)
  }).catchError((){
    showDialog(context: context, builder: (context){
      return AlertDialog(
        content:Text("Sign In Failed"),
        actions: [
          TextButton(onPressed:() => Navigator.pop(context), child: Text("Try Again"))
        ],
      );
    });
  });

}
}