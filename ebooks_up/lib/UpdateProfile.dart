import 'package:ebooks_up/Controller/UserController.dart';
import 'package:flutter/material.dart';
class UpdateProfile extends StatefulWidget {
  static const String id='UpdateProfile';
  @override
  State<UpdateProfile> createState() => _AccountInfoState();
}
class _AccountInfoState extends State<UpdateProfile> {
  @override
  int showpassword=1;
  int btntitle=0;
  UserController user=UserController();
  String? oldpass,ConfirmPass,Pass;


  String? name;
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff212121),
     appBar:  AppBar(
       shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.vertical(
             bottom:Radius.circular(10),
           )
       ),
       centerTitle: true,

       backgroundColor: Color(0xff1db954),
       title: const Text(
         "Update Profile",
         style: TextStyle(
             color: Colors.white, fontSize: 22, fontWeight: FontWeight.w400),
       ),
     ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children:[
              SizedBox(height: 30,),
              Text('Update Name',style: TextStyle(color: Color(0xffb3b3b3),fontWeight:FontWeight.bold,fontSize: 18),),
              SizedBox(height: 20,),
              TextField(textAlign: TextAlign.start,
onChanged: (value){
                setState(() {
                  name=value.toString();
                });
},
                toolbarOptions:const ToolbarOptions(
                    copy: true, cut: true, paste: true, selectAll: true),
                decoration: InputDecoration(
                  hintText: 'Enter name',labelStyle: TextStyle(color: Color(0xff212121),),
                  hintStyle:const TextStyle(fontSize: 12),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide:const BorderSide(
                      color: Color(0xff212121),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide:const BorderSide(
                      color: Color(0xff212121),
                    ),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  fillColor:  Color(0xff535353).withOpacity(0.5),
                  contentPadding:const EdgeInsets.only(bottom: 10,left: 30),
                  filled: true,
               ),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(left: 220),
                child: Container(
                  decoration: BoxDecoration(
                      color: Color(0xff1db954),
                      borderRadius: BorderRadius.circular(30)
                  ),
                  height: 37,
                  width: 122,
                  child: TextButton(
                    child:btntitle==0?const Text('Change',style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.w400),):Container(width: 15,height: 25,child: CircularProgressIndicator(color: Colors.white,),),
                    onPressed: () {
                      user.setName(name.toString());
                      showDialog(context: context, builder: (context)
                      {
                        return AlertDialog(content: Text("Name is updated."),
                      actions: [
                        TextButton(onPressed:() => Navigator.pop(context), child: Text("OK"))],);
                    },
                  );
                    }
                ),
              ),),
               SizedBox(height: 30,),

              Text('Update Password',style: TextStyle(color: Color(0xffb3b3b3),fontWeight:FontWeight.bold,fontSize: 18),),
              SizedBox(height: 20,),
              TextField(textAlign: TextAlign.start,
                obscureText: showpassword==1?true:false,
                onChanged: (value){
                setState(() {
                  oldpass=value.toString();
                });
                },
                toolbarOptions:const ToolbarOptions(
                    copy: true, cut: true, paste: true, selectAll: true),
                decoration: InputDecoration(
                  hintText: 'Old Password',
                  hintStyle:const TextStyle(fontSize: 12, color:Color( 0xffb3b3b3),),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide:const BorderSide(
                      color: Color(0xff212121),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide:const BorderSide(
                      color: Color(0xff212121),
                    ),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  fillColor:  Color(0xff535353).withOpacity(0.5),
                  contentPadding:const EdgeInsets.only(bottom: 10,left: 30),
                  filled: true,
                  suffixIcon: IconButton(onPressed: (){
                    setState(() {
                      showpassword=1-showpassword;
                    });
                  }, icon: Icon(showpassword==0?Icons.visibility_outlined:
                  Icons.visibility_off_outlined),color: Color(0xffb3b3b3),),
                ),
              ),
              SizedBox(height: 30,),
              TextField(
                textAlign: TextAlign.start,
                onChanged: (value){
                  Pass=value.toString();
                },
                obscureText: showpassword==1?true:false,
                toolbarOptions:const ToolbarOptions(
                    copy: true, cut: true, paste: true, selectAll: true),
                decoration: InputDecoration(
                  suffixIcon: IconButton(onPressed: (){
                    setState(() {
                      showpassword=1-showpassword;
                    });
                  }, icon: Icon(showpassword==0?Icons.visibility_outlined:
                  Icons.visibility_off_outlined),color: Color(0xffb3b3b3),),
                  hintText: 'New Password',

                  hintStyle:const TextStyle(fontSize: 12,),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide:const BorderSide(
                      color: Color(0xff212121),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide:const BorderSide(
                      color: Color(0xff212121),
                    ),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  fillColor:  Color(0xff535353).withOpacity(0.5),
                  contentPadding:const EdgeInsets.only(bottom: 10,left: 30),
                  filled: true,
                ),
              ),
              SizedBox(height: 10,),
              TextField(textAlign: TextAlign.start,
                onChanged: (value){
                setState(() {
                  ConfirmPass=value.toString();
                });
                },
                obscureText: showpassword==1?true:false,
                toolbarOptions:const ToolbarOptions(
                    copy: true, cut: true, paste: true, selectAll: true),
                decoration: InputDecoration(
                  suffixIcon: IconButton(onPressed: (){
                    setState(() {
                      showpassword=1-showpassword;
                    });
                  }, icon: Icon(showpassword==0?Icons.visibility_outlined:
                  Icons.visibility_off_outlined),color: Color(0xffb3b3b3),),
                  hintText: 'Confirm Password',labelStyle: TextStyle(color: Color(0xff212121),fontStyle: FontStyle.italic),
                  hintStyle:const TextStyle(fontSize: 12,),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide:const BorderSide(
                      color: Color(0xff212121),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide:const BorderSide(
                      color:Color(0xff212121),
                    ),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  fillColor:  Color(0xff535353).withOpacity(0.5),
                  contentPadding:const EdgeInsets.only(bottom: 10,left: 30),
                  filled: true,
                ),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(left: 220),
                child: Container(
                  decoration: BoxDecoration(
                      color: Color(0xff1db954),
                      borderRadius: BorderRadius.circular(30)
                  ),
                  height: 37,
                  width: 122,
                  child: TextButton(
                    child:btntitle==0?const Text('Change',style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.w400),):Container(width: 15,height: 25,child: CircularProgressIndicator(color: Colors.white,),),
                    onPressed: () {
                      if(Pass==ConfirmPass){
                      user.updatePass(oldpass.toString(), Pass.toString());
                    }
                      else{
                        showDialog(context: context, builder: (context){
                          return AlertDialog(
                            content: Text("Password Didn't Match"),
                            actions: [
                              TextButton(onPressed: ()=>Navigator.pop(context), child: Text("Try Again"))
                            ],
                          );
                        });
                      }
                      },
                  ),
                ),
              ),
              ],
          ),
        ),
      ),
    );
  }
}