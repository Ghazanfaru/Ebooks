import 'package:flutter/material.dart';
import '../Login/LoginPage.dart';
import '../NavPages/HomePage/Home.dart';
import 'package:ebooks_up/Controller/UserController.dart';
import 'package:ebooks_up/model/UserModel.dart';
import 'package:fluttertoast/fluttertoast.dart';
class SignUpPage extends StatefulWidget {
  static const String id='SignUpPage';
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  UserController user=UserController();
 String? email,pass,name,cPass;

 int showpassword=1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff212121),
      appBar: AppBar(
        toolbarHeight: 60,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom:Radius.circular(10),
            )
        ),
        centerTitle: true,

        backgroundColor: const Color(0xff1db954),
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
                  cursorColor: const Color( 0xffb3b3b3),
                  maxLength: 30,
                  toolbarOptions:const ToolbarOptions(
                      copy: true, cut: true, paste: true, selectAll: true),
                  decoration: InputDecoration(
                    hintText: 'Username',
                    hintStyle:const TextStyle(fontSize: 12,  color:Color(0xffb3b3b3),),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:const BorderSide(
                        color: Color(0xff212121),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:const BorderSide(
                        color: Color(0xff212121),
                      ),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    fillColor: const Color(0xff535353).withOpacity(0.5),
                    contentPadding:const EdgeInsets.only(left: 20,bottom: 10),
                    filled: true,
                    suffixIcon:const Icon(Icons.person,color:Color(0xffb3b3b3),),


                  ),
                ),
                TextField(
                  onChanged: (value){
                    email=value.toString();
                  },
                  cursorColor: const Color( 0xffb3b3b3),
                  keyboardType: TextInputType.emailAddress,
                  maxLength: 30,
                  toolbarOptions:const ToolbarOptions(
                      copy: true, cut: true, paste: true, selectAll: true),
                  decoration: InputDecoration(
                    hintText: 'Email',
                    hintStyle:const TextStyle(fontSize: 12,  color:Color(0xffb3b3b3)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:const BorderSide(
                        color: Color(0xff212121),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:const BorderSide(
                        color: Color(0xff212121),
                      ),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    fillColor:const Color(0xff535353).withOpacity(0.5),
                    contentPadding:const EdgeInsets.only(left: 20,bottom: 10),
                    filled: true,
                    suffixIcon:const Icon(Icons.person, color:Color(0xffb3b3b3),),
                  ),
                ),
                TextField(
                  cursorColor: const Color( 0xffb3b3b3),
                  obscureText: showpassword==1?true:false,
                  onChanged: (value){
                    pass=value.toString();
                  },
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    hintStyle:const TextStyle(fontSize: 12,  color:Color(0xffb3b3b3)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:const BorderSide(
                        color:Color(0xff212121),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:const BorderSide(
                        color: Color(0xff212121),
                      ),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    fillColor:const Color(0xff535353).withOpacity(0.5),
                      contentPadding:const EdgeInsets.only(left: 20,bottom: 10),
                      filled: true,
                      suffixIcon:IconButton(onPressed: (){
                        setState(() {
                          showpassword=1-showpassword;
                        });
                      },
                        icon:Icon(showpassword==0?Icons.visibility_outlined:Icons.visibility_off_outlined),color: const Color(0xffb3b3b3),)
                  ),
                ),
                const SizedBox(height: 15,),
                TextField(
                  onChanged: (value){
                    cPass=value.toString();
                  },
                  cursorColor: const Color( 0xffb3b3b3),
                  obscureText: showpassword==0?false:true,
                  toolbarOptions:const ToolbarOptions(
                      copy: true, cut: true, paste: true, selectAll: true),
                  decoration: InputDecoration(
                    hintText: 'Confirm Password',
                    hintStyle:const TextStyle(fontSize: 12,  color:Color(0xffb3b3b3)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:const BorderSide(
                        color:Color(0xff212121),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:const BorderSide(
                        color: Color(0xff212121),
                      ),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    fillColor: const Color(0xff535353).withOpacity(0.5),
                    contentPadding:const EdgeInsets.only(left: 20,bottom: 10),
                    filled: true,
                    suffixIcon:IconButton(onPressed: (){
                      setState(() {
                        showpassword=1-showpassword;
                      });
                    },
                        icon:Icon(showpassword==0?Icons.visibility_outlined:Icons.visibility_off_outlined),color: const Color(0xffb3b3b3),)
                  ),
                ),
                const SizedBox(height: 50,),
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                        color: const Color(0xff1db954),
                        borderRadius: BorderRadius.circular(30)
                    ),
                    height: 40,
                    width: 350,
                    child: TextButton(
                      child:const Text('Sign Up',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w400),),
                      onPressed: () {
                        print(email);
                        if(pass==cPass) {
                         try {
                           UserModel userModel = new UserModel(email: email, pass: pass, Uname: name);
                           user.register(userModel);
                           Navigator.pushNamed(context, LoginPage.id);
                         }
                         catch(e){
                           Fluttertoast.showToast(
                               msg: user.Exception.toString(),
                               toastLength: Toast.LENGTH_SHORT,
                               gravity: ToastGravity.CENTER,
                               timeInSecForIosWeb: 1,
                               backgroundColor: Colors.red,
                               textColor: Colors.white,
                               fontSize: 16.0
                           );
                         }
                         }
                        else {
                          showDialog(context: context, builder: (context)=>AlertDialog(
                          content: const Text("Password didn't match"),
                          actions: [
                            ElevatedButton(onPressed: ()=>Navigator.pushNamed(context, SignUpPage.id), child: const Text("Try Again"))
                          ],
                        ));
                        }
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
                            color:Color(0xff1db954), fontWeight: FontWeight.w600),
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
