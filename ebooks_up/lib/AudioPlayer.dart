import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class Audioplayer extends StatefulWidget {
  String title;
  String imgUrl;
  String fileUrl;
  bool offline;
  Audioplayer(
      {Key? key,
      required this.offline,
      required this.title,
      required this.imgUrl,
      required this.fileUrl})
      : super(key: key);

  @override
  State<Audioplayer> createState() => _AudioplayerState();
}

class _AudioplayerState extends State<Audioplayer> {
  bool isPlaying = false;
  double value = 0;
  final player = AudioPlayer();
  Duration? duration = const Duration(seconds: 0);

  @override
  void initState() {
    super.initState();
    initplayer();
  }

  Future<void> initplayer() async {
    if (widget.offline) {
      player.setSourceDeviceFile(widget.fileUrl);
    } else {
      await player.setSourceUrl(widget.fileUrl);
    }
    duration = await player.getDuration();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.offline);
    return Scaffold(
      body: Stack(
        children: [
          Container(
            constraints: const BoxConstraints.expand(),
            decoration: BoxDecoration(
                image: widget.offline
                    ? DecorationImage(
                    image: MemoryImage(File(widget.imgUrl).readAsBytesSync()),
                        fit: BoxFit.cover)
                    : DecorationImage(
                        image: NetworkImage(
                          widget.imgUrl,
                        ),
                        fit: BoxFit.cover)),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 28, sigmaY: 28),
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
                child: widget.offline
                    ? Image.memory(File(widget.imgUrl).readAsBytesSync(),width: 250.0,)
                    : Image.network(
                        widget.imgUrl,
                        width: 250.0,
                      ),
              ),
              const SizedBox(
                height: 40,
              ),
              Text(
                widget.title,
                style: const TextStyle(
                    color: Colors.white, fontSize: 35.0, letterSpacing: 5),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${(value / 60).floor()}:${(value % 60).floor()}",
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  Slider.adaptive(
                    onChanged: (v) {
                      setState(() {
                        value = v;
                      });
                    },
                    min: 10.0,
                    max: duration!.inSeconds.toDouble(),
                    value: value,
                    onChangeEnd: (newValue) async {
                      setState(() {
                        value = newValue;
                      });
                      player.pause();
                      await player.seek(Duration(seconds: newValue.toInt()));
                      await player.resume();
                    },
                    activeColor: Colors.green,
                  ),
                  Text(
                    "${duration!.inMinutes}:${duration!.inSeconds % 60}",
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  )
                ],
              ),
              const SizedBox(
                height: 30.0,
              ),
              Container(
                width: 60.0,
                height: 60.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(60.0),
                  color: Colors.black,
                  border: Border.all(color: Colors.black45),
                ),
                child: InkWell(
                  onTap: () async {
                    if (isPlaying) {
                      await player.pause();
                      setState(() {
                        isPlaying = false;
                      });
                    } else {
                      await player.resume();
                      setState(() {
                        isPlaying = true;
                      });
                      player.onPositionChanged.listen((position) {
                        setState(() {
                          value = position.inSeconds.toDouble();
                        });
                      });
                      setState(() async {
                        duration = await player.getDuration();
                      });
                    }
                  },
                  child: Icon(
                    isPlaying
                        ? Icons.pause_circle
                        : Icons.play_arrow,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
