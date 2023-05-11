import 'dart:ui';
import 'package:ebooks_up/model/BooksModel.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
class Audioplayer extends StatefulWidget {
  BooksModel booksModel=BooksModel();
   Audioplayer({Key? key,required this.booksModel}) : super(key: key);

  @override
  State<Audioplayer> createState() => _AudioplayerState();
}

class _AudioplayerState extends State<Audioplayer> {

  bool isPlaying=false;
  double value=0;
  final player=AudioPlayer();
  Duration? duration=Duration(seconds: 0);

  @override
  void initState() {
    super.initState();
    initplayer();

  }
void initplayer() async{
  await player.setSourceUrl(widget.booksModel.fileUrl.toString());
  duration= await player.getDuration();
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(body:Stack(
      children: [
        Container(
          constraints: BoxConstraints.expand(),
          decoration:  BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(widget.booksModel.imgUrl.toString(),),
              fit: BoxFit.cover
            )
          ),
          child: BackdropFilter(filter: ImageFilter.blur(sigmaX: 28,sigmaY: 28),
          child: Container(
            color: Colors.black45,
          ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(30.0),
              child: Image.network(widget.booksModel.imgUrl.toString(),width: 250.0,),
            ),
            SizedBox(height: 40,),
            Text(widget.booksModel.title.toString(),style: TextStyle(color: Colors.white,fontSize:35.0,letterSpacing: 5 ),),
        SizedBox(height: 30.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("${(value/60).floor()}:${(value%60).floor()}",style: TextStyle(fontSize: 16,color: Colors.white),),
                Slider.adaptive(
                  onChanged: (v){
                    setState(() {
                      value=v;
                    });
                  },
                  min: 0.0,
                  max: duration!.inSeconds.toDouble(),
                  value: value,
                  onChangeEnd: (newValue)async{
                    setState(() {
                      value=newValue;
                    });
                    player.pause();
                    await player.seek(Duration(seconds: newValue.toInt()));
                    await player.resume();
                  },activeColor: Colors.green,
                ),
                Text("${duration!.inMinutes}:${duration!.inSeconds%60}",style: TextStyle(color: Colors.white,fontSize: 16),)
              ],
            ),
            SizedBox(height: 30.0,),
            Container(
              width: 60.0,
              height: 60.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(60.0),
                color: Colors.green.withOpacity(0.5),
                border: Border.all(color: Colors.black45),
              ),
              child: InkWell(
                  onTap: ()async{
                    if(isPlaying)
                    {
                      await player.pause();
                      setState(() {
                        isPlaying=false;
                      });
                    }
                    else{
                   await player.resume();
                  setState(() {
                    isPlaying=true;
                  });
                   player.onPositionChanged.listen((position) {
                     setState(() {
                       value=position.inSeconds.toDouble();
                     });
                   });
                 setState(()async{
                   duration=await player.getDuration();
                 });}
                  },
                child: Icon(
                 isPlaying? Icons.pause_circle_outline:Icons.play_arrow_outlined,
                  color: Colors.black,
                  size: 40,
                ),
              ),
            )
          ],
        )
      ],
    ),);
  }
}
