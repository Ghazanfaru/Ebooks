import 'dart:ui';
import 'package:ebooks_up/Login/ResetPage.dart';
import 'package:flutter/material.dart';
import 'package:ebooks_up/Controller/UserController.dart';
import '../Signup/SignUpPage.dart';
import 'package:ebooks_up/model/UserModel.dart';
class LoginPage extends StatefulWidget {
  @override
  static const String id='LoginPage';
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool IsSelected=false;
  UserModel userModel=UserModel();
  UserController controller=UserController();
  String email="",pass="";
  int showpassword=1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff212121),
      appBar: AppBar(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom:Radius.circular(10),
            )
        ),
        centerTitle: true,
        backgroundColor: Color(0xff1db954),
        title: const Text(
          "Sign In ",
          style: TextStyle(
          color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400),
        ),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SizedBox(height: 80,),
                TextField(
                  onChanged: (value){
                    setState(() {
                      email=value.toString();
                    });
                  },
                  keyboardType: TextInputType.emailAddress,
                  maxLength: 30,
                  toolbarOptions:const ToolbarOptions(
                      copy: true, cut: true, paste: true, selectAll: true),
                  decoration: InputDecoration(
                    hintText: 'someone@example.com',
                    hintStyle:const TextStyle(fontSize: 12,fontStyle: FontStyle.italic, color: Color(0xff212121)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide:const BorderSide(
                        color: Color(0xff212121),
                      ),
                    ),
                    focusedBorder:  OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide:const BorderSide(
                        color: Color(0xff212121),
                      ),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    fillColor: Colors.white,
                    contentPadding:const EdgeInsets.only(bottom: 10),
                    filled: true,
                    prefixIcon:const Icon(Icons.email_outlined,color: Color(0xff212121),),
                  ),
                ),
                TextField(
                  onChanged: (value){
                    setState(() {
                      pass=value.toString();
                    });
                  },
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: showpassword==1?true:false,
                  decoration: InputDecoration(
                    hintText: '******',
                    hintStyle:const TextStyle(fontSize: 12,fontStyle: FontStyle.italic, color: Color(0xff212121),),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide:const BorderSide(
                        color: Color(0xff212121),
                      ),
                    ),
                    focusedBorder:  OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide:const BorderSide(
                        color: Color(0xff212121),
                      ),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    fillColor: Colors.white,
                    contentPadding:const EdgeInsets.only(bottom: 10),
                    filled: true,
                    suffixIcon: IconButton(onPressed: (){
                      setState(() {
                        showpassword=1-showpassword;
                      });
                    }, icon: Icon(showpassword==0?Icons.visibility_outlined:Icons.visibility_off_outlined),color: Color(0xff212121),),
                    prefixIcon:const Icon(Icons.lock_outline,color: Color(0xff212121),),
                  ),
                ),
                Row(
                  children: [
                    Checkbox(activeColor: Color(0xff212121),value: IsSelected, onChanged: ( bool? value){
                      setState(() {
                        IsSelected=value!;
                        print(IsSelected);
                      });
                    }),
                    const Text('Remember me',style: TextStyle(color:Colors.white,fontSize: 15),),
                    const SizedBox(width: 50,),
                     TextButton(
                      onPressed: (){
                       Navigator.pushNamed(context, ResetPage.id);
                      },
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(
                            color:Colors.white, fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20,),
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xff1db954),
                      borderRadius: BorderRadius.circular(30)
                    ),
                    height: 40,
                    width: 300,
                    child: TextButton(
                      child:const Text('Sign In',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w400),),
                      onPressed: () {

                       setState(() {
                         userModel.email=email;
                         userModel.pass=pass;
                       });
                        controller.login(userModel, context);
                        }
                    ),
                  ),
                ),
                Center(
                  child: Row(children: <Widget>[
                    Expanded(
                      child: Container(
                          margin:const EdgeInsets.only(left: 20, right: 5),
                          child: const Divider(
                            color: Colors.grey,
                            height: 50,
                            thickness: 2,
                          )),
                    ),
                    const Text("OR"),
                    Expanded(
                      child: Container(
                          margin:const EdgeInsets.only(left: 5, right: 20.0),
                          child:const Divider(
                            thickness: 2,
                            color: Colors.grey,
                            height: 50,
                          )),
                    ),
                  ]),
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: GestureDetector(
                    onTap: (){
                      try {
                        controller.signInWithGoogle(context);
                      } catch(e){
                        showDialog(context: context, builder: (BuildContext context){
                          return AlertDialog(
                            content: Text(e.toString()),
                            actions: [
                              Container(
                                  decoration: BoxDecoration(
                                      color: Color(0xff005C29),
                                      borderRadius: BorderRadius.circular(30)
                                  ),
                                  child: TextButton(onPressed: ()=> Navigator.pop(context), child: Text("Try Again")))
                            ],
                          );
                        });
                      }
                      },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 15,vertical: 8),
                      width: 300,
                      height: 47,
                      decoration: BoxDecoration(
                        boxShadow: [
                           BoxShadow(
                            color: Colors.black54,
                            offset: Offset(0.0, 1.0),
                            blurRadius: 6.0,
                          ),
                        ],
                        color: Color(0xff1db954),
                        borderRadius: BorderRadius.circular(50),

                      ),
                      child: IntrinsicHeight(
                        child: Row(
                          children: [
                            Image.asset('lib/assets/images/google.png'),
                            const VerticalDivider(width: 20,color: Colors.black45,thickness: 2,),
                            const SizedBox(width: 30,),
                            const Text("Continue with Google",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color:Colors.white),)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t have an account?',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    TextButton(
                      child:const Text(
                        'Create Account',
                        style: TextStyle(
                            color: Color(0xff005C29), fontWeight: FontWeight.w600),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, SignUpPage.id);
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
