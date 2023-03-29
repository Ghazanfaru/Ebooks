import 'package:flutter/material.dart';
class PlayAudioBook extends StatefulWidget {
  static const String id='PlayAudiobook';
  const PlayAudioBook({super.key,});
  @override
  State<PlayAudioBook> createState() => _PlayAudioBookState();
}

class _PlayAudioBookState extends State<PlayAudioBook> {
  @override

  int status=0;
  IconData icon=Icons.play_arrow;
  double maxDuration=12;
  double Position=5;
  double startDuration=0;
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE2E5DE),
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom:Radius.circular(10),
            )
        ),
        centerTitle: true,
        backgroundColor: const Color(0xff005C29),

        title: const Text('Player',style: TextStyle(fontWeight: FontWeight.w400,color: Colors.white),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                //here take image of book from database for now i'm using this image
                Container(
                  width: 150,
                  height: 180,
                  child:  Image.asset('lib/assets/images/t1.PNG'),
                ),
                SizedBox(height: 20,),
                Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
                  Text('Book name:',style: TextStyle(color: Color(0xff005C29),fontSize: 18,fontWeight: FontWeight.bold),),
                  Text('Interaction Design',style: TextStyle(color: Color(0xff005C29),fontSize: 16),),
                ],
                ),
                SizedBox(height: 10,),
                Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
                  Text('Author:',style: TextStyle(color: Color(0xff005C29),fontSize: 18,fontWeight: FontWeight.bold),),
                  Text('John Wiley',style: TextStyle(color: Color(0xff005C29),fontSize: 16),),
                ],
                ),
                SizedBox(height: 10,),
                Divider(thickness: 5),
                SizedBox(height: 10,),
                Slider.adaptive(inactiveColor: Colors.grey,activeColor: Color(0xff005C29),value: Position,min: startDuration,max: maxDuration, onChanged: (value){}),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20,),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('time',style: TextStyle(fontSize: 16,color: Color(0xff005C29)),),
                      Text('R time',style: TextStyle(fontSize: 16,color: Color(0xff005C29)),),
                    ],
                  ),
                ),


                Padding(
                  padding: const EdgeInsets.only(top: 30,left: 10,right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(onPressed: (){}, icon: Icon(Icons.shuffle,size: 25,color: Color(0xff005C29),),),
                      IconButton(onPressed: (){}, icon: Icon(Icons.skip_previous,size: 30,color: Color(0xff005C29),),),
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.white70,
                        child: IconButton(onPressed: (){
                          setState(() {
                            if(status==1){
                              icon=Icons.play_arrow;
                            }

                            else {
                              icon=Icons.pause;
                            }
                            status=1-status;
                          });
                        }, icon:Icon(icon,size: 30,color:Color(0xff005C29),)),
                      ),
                      IconButton(onPressed: (){}, icon: const Icon(Icons.skip_next,size: 30,color: Color(0xff005C29),),),
                      IconButton(onPressed: (){}, icon: Icon(Icons.loop,size: 25,color: Color(0xff005C29),),),

                    ],),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
