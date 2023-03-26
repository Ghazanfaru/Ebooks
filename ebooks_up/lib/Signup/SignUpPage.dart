import 'package:flutter/material.dart';
import '../Login/LoginPage.dart';
import '../NavPages/HomePage/Home.dart';
import 'package:ebooks_up/Controller/UserController.dart';
import 'package:ebooks_up/model/UserModel.dart';
class SignUpPage extends StatefulWidget {
  static const String id='SignUpPage';
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  UserController user=UserController();
 String? email,pass,name,cPass;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE2E5DE),
      appBar: AppBar(
        toolbarHeight: 60,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom:Radius.circular(10),
            )
        ),
        centerTitle: true,

        backgroundColor: Color(0xff005C29),
        title: const Text(
          "Sign Up ",
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400),
        ),
      ),
      body: Padding(
          padding:const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 45,),
                TextField(
                  onChanged: (value){
                    name=value.toString();
                  },
                  cursorColor: Color(0xff005C29),
                  maxLength: 30,
                  toolbarOptions:const ToolbarOptions(
                      copy: true, cut: true, paste: true, selectAll: true),
                  decoration: InputDecoration(
                    hintText: 'Username',
                    hintStyle:const TextStyle(fontSize: 12, color: Color(0xff005C29),),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide:const BorderSide(
                        color: Color(0xff005C29),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
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
                    prefixIcon:const Icon(Icons.person,color: Color(0xff005C29),),
                  ),
                ),
                TextField(
                  onChanged: (value){
                    email=value.toString();
                  },
                  cursorColor: Color(0xff005C29),
                  keyboardType: TextInputType.emailAddress,
                  maxLength: 30,
                  toolbarOptions:const ToolbarOptions(
                      copy: true, cut: true, paste: true, selectAll: true),
                  decoration: InputDecoration(
                    hintText: 'Email',
                    hintStyle:const TextStyle(fontSize: 12, color:Color(0xff005C29),),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide:const BorderSide(
                        color: Color(0xff005C29),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
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
                    prefixIcon:const Icon(Icons.email_outlined,color:Color(0xff005C29),),
                  ),
                ),
                TextField(
                  cursorColor: Color(0xff005C29),
                  obscureText: true,
                  onChanged: (value){
                    pass=value.toString();
                  },
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    hintStyle:const TextStyle(fontSize: 12, color:Color(0xff005C29)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide:const BorderSide(
                        color:Color(0xff005C29),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
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
                    prefixIcon:const Icon(Icons.lock_outline,color:Color(0xff005C29)),
                  ),
                ),
                const SizedBox(height: 15,),
                TextField(
                  onChanged: (value){
                    cPass=value.toString();
                  },
                  cursorColor: Color(0xff005C29),
                  obscureText: true,
                  toolbarOptions:const ToolbarOptions(
                      copy: true, cut: true, paste: true, selectAll: true),
                  decoration: InputDecoration(
                    hintText: 'Confirm Password',
                    hintStyle:const TextStyle(fontSize: 12, color:Color(0xff005C29)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide:const BorderSide(
                        color:Color(0xff005C29),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
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
                const SizedBox(height: 50,),
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xff005C29),
                        borderRadius: BorderRadius.circular(30)
                    ),
                    height: 40,
                    width: 350,
                    child: TextButton(
                      child:const Text('Sign Up',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w400),),
                      onPressed: () {
                        print(email);
                        if(pass==cPass) {
                          UserModel userModel =new UserModel(email: email, pass: pass, Uname: name);
                          user.register(userModel);

                          Navigator.pushNamed(context, Home.id);
                        }
                        else showDialog(context: context, builder: (context)=>AlertDialog(
                          content: Text("Password didn't match"),
                          actions: [
                            ElevatedButton(onPressed: ()=>Navigator.pushNamed(context, SignUpPage.id), child: Text("Try Again"))
                          ],
                        ));
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    TextButton(
                      child:const Text(
                        'Sign In',
                        style: TextStyle(
                            color:Color(0xff005C29), fontWeight: FontWeight.w600),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, LoginPage.id);
                      },
                    ),
                  ],
                )

              ],
            ),
          ),
        ),

    );
  }
}
