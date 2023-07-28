import 'package:ebooks_up/Liking.dart';
import 'package:ebooks_up/NavPages/HomePage/Home.dart';
import 'package:ebooks_up/main.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ebooks_up/model/UserModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore store = FirebaseFirestore.instance;
  String? Exception;
  String? id;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  void OpenBox() async {
    await Hive.openBox(checkNewUSer);
  }

  void register(UserModel userModel) async {
    try {
      UserCredential user = await auth.createUserWithEmailAndPassword(
          email: userModel.email.toString(),
          password: userModel.pass.toString());
      id = user.user!.uid;
      setName(userModel.Uname.toString());
      addUsername(userModel);
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.code.toString());
    }
  }

  void login(UserModel userModel, BuildContext context) async {
    try {
      OpenBox();
      auth
          .signInWithEmailAndPassword(
              email: userModel.email.toString(),
              password: userModel.pass.toString())
          .whenComplete(() {
            if(Hive.box(checkNewUSer).get('newUser')==true){
              Navigator.pushReplacementNamed(context, LikingCategoriesScreen.id);
            }
            else {
              Navigator.pushReplacementNamed(context, Home.id);
            }
      });
    } on FirebaseAuthException catch (e) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text(e.code.toString()),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Try Again"))
              ],
            );
          });
    }
  }

  void updatePass(String oldpass, String Pass) async {
    User? user = auth.currentUser;
    AuthCredential credential = EmailAuthProvider.credential(
        email: user!.email.toString(), password: oldpass);
    await user.reauthenticateWithCredential(credential).whenComplete(() {
      user.updatePassword(Pass);
    });
  }

  void forgotPass(String email, BuildContext context) async {
    await auth
        .sendPasswordResetEmail(email: email)
        .onError((error, stackTrace) => showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Text(error.toString()),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Try Again"))
                ],
              );
            }));
  }

  void logout() async {
    await auth.signOut();
    await _googleSignIn.signOut();
  }

  void addUsername(UserModel model) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(id)
          .set({'username': model.Uname, 'email': model.email, 'User_id': id});
      print(model.Uname);
    } on FirebaseException catch (e) {
      Exception = e.code;
    }
  }

  String? getName() {
    String? name = FirebaseAuth.instance.currentUser?.displayName.toString();
    return name;
  }

  void setName(String displaName) async {
    User? user = auth.currentUser;
    if (user != null) {
      await user.updateDisplayName(displaName);
    }
  }

  void clearPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  Future<UserCredential> signInWithGoogle(BuildContext context) async {

    // Trigger the Google authentication flow
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    return await auth.signInWithCredential(credential).whenComplete(() {
      OpenBox();
      if(Hive.box(checkNewUSer).get('newUser')==true){
        Navigator.pushReplacementNamed(context, LikingCategoriesScreen.id);
      }
      else {
        Navigator.pushReplacementNamed(context, Home.id);
      }
    }
        // ignore: argument_type_not_assignable_to_error_handler, body_might_complete_normally_catch_error
        );
  }
}
