import 'package:flutter/material.dart';
import 'package:ebooks_up/Controller/UserController.dart';

class ResetPage extends StatefulWidget {
  static const String id='ResetPage';

  const ResetPage({Key? key}) : super(key: key);

  @override
  State<ResetPage> createState() => _ResetPageState();
}

class _ResetPageState extends State<ResetPage> {
  String email="";
  UserController controller = UserController();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
            "Reset Password",
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400),
          ),
        ),
      body: Container(
        child: Column(
crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 40,),
            Container(
               padding:EdgeInsets.only(left: 10,right: 10) ,
                child: Text("Enter your Email And Get Reset Link.",style: TextStyle(fontSize: 20, color: Color(0xff005C29)),)
            ),
            SizedBox(height: 40,),
            Container(
              padding:EdgeInsets.only(left: 10,right: 10) ,
              child: TextField(
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
                  hintText: 'Someone@Example.com',
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
            ),
            SizedBox(height: 20,),
            Center(
              child: Container(
                decoration: BoxDecoration(
                    color: Color(0xff005C29),
                    borderRadius: BorderRadius.circular(30)
                ),
                height: 40,
                width: 300,
                child: TextButton(
                  child:const Text('Submit',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w400),),
                  onPressed: () {
                    controller.forgotPass(email);
                  },
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}
