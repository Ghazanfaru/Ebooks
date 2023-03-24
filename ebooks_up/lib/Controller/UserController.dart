import 'package:firebase_auth/firebase_auth.dart';
import 'package:ebooks_up/model/UserModel.dart';
class UserController{
FirebaseAuth auth=FirebaseAuth.instance;
void register(UserModel userModel){
  auth.createUserWithEmailAndPassword(email: userModel.email.toString(), password: userModel.pass.toString());
}
void login(String email,String pass){
  auth.signInWithEmailAndPassword(email: email , password: pass);
}
void forgotPass(UserModel userModel){
  auth.sendPasswordResetEmail(email: userModel.email.toString());
}
}