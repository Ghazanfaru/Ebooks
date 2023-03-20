import 'dart:ui';
import 'package:flutter/material.dart';

import '../NavPages/HomePage/Home.dart';
import '../Signup/SignUpPage.dart';
class LoginPage extends StatefulWidget {
  @override
  static const String id='LoginPage';
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool IsSelected=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE2E5DE),
      appBar: AppBar(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom:Radius.circular(10),
            )
        ),
        centerTitle: true,
        backgroundColor: Color(0xff005C29),
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
                  keyboardType: TextInputType.emailAddress,
                  maxLength: 30,
                  toolbarOptions:const ToolbarOptions(
                      copy: true, cut: true, paste: true, selectAll: true),
                  decoration: InputDecoration(
                    hintText: 'Username or Email',
                    hintStyle:const TextStyle(fontSize: 12, color: Color(0xff005C29)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide:const BorderSide(
                        color: Color(0xff005C29),
                      ),
                    ),
                    focusedBorder:  OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide:const BorderSide(
                        color: Color(0xff005C29),
                      ),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    fillColor: Colors.white,
                    contentPadding:const EdgeInsets.only(bottom: 10),
                    filled: true,
                    prefixIcon:const Icon(Icons.email_outlined,color: Color(0xff005C29),),
                  ),
                ),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    hintStyle:const TextStyle(fontSize: 12, color: Color(0xff005C29),),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide:const BorderSide(
                        color: Color(0xff005C29),
                      ),
                    ),
                    focusedBorder:  OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide:const BorderSide(
                        color: Color(0xff005C29),
                      ),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    fillColor: Colors.white,
                    contentPadding:const EdgeInsets.only(bottom: 10),
                    filled: true,
                    prefixIcon:const Icon(Icons.lock_outline,color: Color(0xff005C29),),
                  ),
                ),
                Row(
                  children: [
                    Checkbox(activeColor: Color(0xff005C29),value: IsSelected, onChanged: ( bool? value){
                      setState(() {
                        IsSelected=value!;
                        print(IsSelected);
                      });
                    }),
                    const Text('Remember me',style: TextStyle(color: Color(0xff005C29),fontSize: 15),),
                    const SizedBox(width: 50,),
                    const TextButton(
                      onPressed: null,
                      child: Text(
                        'Forgot Password',
                        style: TextStyle(
                            color:Color(0xff005C29), fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20,),
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xff005C29),
                      borderRadius: BorderRadius.circular(30)
                    ),
                    height: 40,
                    width: 300,
                    child: TextButton(
                      child:const Text('Sign In',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w400),),
                      onPressed: () {
                        Navigator.pushNamed(context,Home.id);
                      },
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
                      Navigator.pushNamed(context, Home.id);
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
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(0),
                        //border: Border.all(color: Colors.black54,width: 1.5,),
                      ),
                      child: IntrinsicHeight(
                        child: Row(
                          children: [
                            Image.asset('lib/assets/images/google.png'),
                            const VerticalDivider(width: 20,color: Colors.black45,thickness: 2,),
                            const SizedBox(width: 30,),
                            const Text("Sign In with Google",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.black54),)
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
