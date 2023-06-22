import 'dart:ui';
import 'package:ebooks_up/Login/ResetPage.dart';
import 'package:flutter/material.dart';
import 'package:ebooks_up/Controller/UserController.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  void initState(){
    _loadUserEmailPassword();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff212121),
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom:Radius.circular(10),
            )
        ),
        centerTitle: true,
        backgroundColor: const Color(0xff1db954),
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20,),
                Container(child: const Text("Sign In to continue.",style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold,)),),
                const SizedBox(height: 50,),
                TextField(
                  onChanged: (value){
                    setState(() {
                      email=value.toString();
                    });
                  },
                  keyboardType: TextInputType.emailAddress,
                  toolbarOptions:const ToolbarOptions(
                      copy: true, cut: true, paste: true, selectAll: true),
                  decoration: InputDecoration(
                    hintText: 'Email',
                    hintStyle:const TextStyle(fontSize: 12, color:Color(0xffb3b3b3) ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:const BorderSide(
                        color: Color(0xff212121),
                      ),
                    ),
                    focusedBorder:  OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:const BorderSide(
                        color: Color(0xff212121),
                      ),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    fillColor: const Color(0xff535353).withOpacity(0.5),
                    contentPadding:const EdgeInsets.only(left:20,bottom: 10),
                    filled: true,
                    suffixIcon:const Icon(Icons.email_outlined,color: Color(0xffb3b3b3),),
                  ),
                ),
                const SizedBox(height: 20,),
                TextField(
                  onChanged: (value){
                    setState(() {
                      pass=value.toString();
                    });
                  },
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: showpassword==1?true:false,
                  decoration: InputDecoration(

                    hintText: 'Password',
                    hintStyle:const TextStyle(fontSize: 12, color: Color(0xffb3b3b3),),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:const BorderSide(
                        color: Color(0xff212121),
                      ),
                    ),
                    focusedBorder:  OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:const BorderSide(
                        color: Color(0xff212121),
                      ),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    fillColor: const Color(0xff535353).withOpacity(0.5),
                    contentPadding:const EdgeInsets.only(left:20,bottom: 10),
                    filled: true,
                    suffixIcon: IconButton(onPressed: (){
                      setState(() {
                        showpassword=1-showpassword;
                      });
                    }, icon: Icon(showpassword==0?Icons.visibility_outlined:
                    Icons.visibility_off_outlined),color: const Color(0xffb3b3b3),),

                  ),
                ),
                const SizedBox(height: 20,),
                Row(
                  children: [
                    Checkbox(
                      side: const BorderSide(color: Colors.white70),
                        checkColor: Colors.black45,
                        activeColor: const Color(0xffb3b3b3),value: IsSelected, onChanged: ( bool? value){
                      setState(() {
                        IsSelected=value!;
                 _handleRemeberme(IsSelected);
                      });
                    }),
                    const Text('Remember me',style: TextStyle(color:Color(0xffb3b3b3),fontSize: 15),),
                    const SizedBox(width: 50,),
                     TextButton(
                      onPressed: ()
                      {
                       Navigator.pushNamed(context, ResetPage.id);
                      },
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(
                            color:Color(0xffb3b3b3), fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height:30,),
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xff1db954),
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
                       if(userModel.email!=null && userModel.email!.isNotEmpty && userModel.pass!=null && userModel.pass!.isNotEmpty) {
                         controller.login(userModel, context);
                       }
                       else {
                         Fluttertoast.showToast(msg: "Enter your Email/Password");
                       }
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
                    const Text("OR",style: TextStyle(color:Color( 0xffb3b3b3),),),
                    Expanded(
                      child: Container(
                          margin:const EdgeInsets.only(left: 5, right: 20.0),
                          child:const Divider(
                            thickness: 2,
                            color: Colors.grey,
                            height: 40,
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
                                      color: const Color(0xff005C29),
                                      borderRadius: BorderRadius.circular(30)
                                  ),
                                  child: TextButton(onPressed: ()=> Navigator.pop(context), child: const Text("Try Again")))
                            ],
                          );
                        });
                      }
                      },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 8),
                      width: 300,
                      height: 47,
                      decoration: BoxDecoration(
                        boxShadow: const [
                           BoxShadow(
                            color: Colors.white70,
                            offset: Offset(0.0, 1.0),
                            blurRadius: 6.0,
                          ),
                        ],
                        color: const Color(0xff212121),
                        borderRadius: BorderRadius.circular(50),

                      ),
                      child: IntrinsicHeight(
                        child: Row(
                          children: [
                            Image.asset('lib/assets/images/google.png'),
                            const VerticalDivider(width: 20,color: Colors.white70,thickness: 2,),
                            const SizedBox(width: 30,),
                            const Text("Continue with Google",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color:Colors.white),)
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
                        Navigator.pushReplacementNamed(context, SignUpPage.id);
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

  Future<void> _handleRemeberme(bool value) async {
    SharedPreferences preferences=await SharedPreferences.getInstance();
  preferences.setString("email", email);
  preferences.setString("pass", pass);
  }

  void _loadUserEmailPassword() async {
SharedPreferences preferences= await SharedPreferences.getInstance();
String? email=preferences.getString("email");
String? pass=preferences.getString("pass");
if(email!.isNotEmpty && email!=null) {
  userModel.email=email;
  userModel.pass=pass;
  setState(() {
    controller.login(userModel, context);
  });
}

}
}
