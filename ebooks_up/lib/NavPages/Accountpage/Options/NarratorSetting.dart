import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class NarratorSettingsScreen extends StatefulWidget {
  static String id='NarratorSettings';
  @override
  _NarratorSettingsScreenState createState() => _NarratorSettingsScreenState();
}

class _NarratorSettingsScreenState extends State<NarratorSettingsScreen> {
  FlutterTts flutterTts=FlutterTts();
  String selectedVoice='';
  double volume = 1.0;
  double speechRate = 1.0;
  double pitch = 1.0;
  List<dynamic> availableVoices = [];

  @override
  void initState() {
    super.initState();
    flutterTts = FlutterTts();
    initTts();
  }
  Future<void> _speak(String text) async {
    Map<String, String> voice = {'name': selectedVoice};
    await flutterTts.setVoice(voice);
    await flutterTts.speak(text);
  }

  Future<void> initTts() async {
    availableVoices = await flutterTts.getVoices;
    setState(() {
      selectedVoice = availableVoices[0]['name'];
    });
  }

  void setVolume(double value) {
    setState(() {
      volume = value;
    });
    flutterTts.setVolume(volume);
  }

  void setSpeechRate(double value) {
    setState(() {
      speechRate = value;
    });
    flutterTts.setSpeechRate(speechRate);
  }

  void setPitch(double value) {
    setState(() {
      pitch = value;
    });
    flutterTts.setPitch(pitch);
  }

  void setSelectedVoice(String voice) {
    setState(() {
      selectedVoice = voice;
    });
    flutterTts.setVoice({"name": voice});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff212121),
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Narrator Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text(
            'Volume',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold,color: Colors.white),
          ),
          SliderTheme(
            data: SliderThemeData(
              activeTrackColor: Colors.green,
              inactiveTrackColor: Colors.grey,
              thumbColor: Colors.green,
              overlayColor: Colors.green.withOpacity(0.4),
            ),
            child: Slider(
              value: volume,
              onChanged: setVolume,
              min: 0.0,
              max: 1.0,
            ),
          ),
          const SizedBox(height: 16.0),
          const Text(
            'Speech Rate',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold,color: Colors.white),
          ),
          SliderTheme(
            data: SliderThemeData(
              activeTrackColor: Colors.green,
              inactiveTrackColor: Colors.grey,
              thumbColor: Colors.green,
              overlayColor: Colors.green.withOpacity(0.4),
            ),
            child: Slider(
              value: speechRate,
              onChanged: setSpeechRate,
              min: 0.5,
              max: 2.0,
              divisions: 15,
              label: speechRate.toStringAsFixed(2),
            ),
          ),
          const SizedBox(height: 16.0),
          const Text(
            'Pitch',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold,color: Colors.white),
          ),
          SliderTheme(
            data: SliderThemeData(
              activeTrackColor: Colors.green,
              inactiveTrackColor: Colors.grey,
              thumbColor: Colors.green,
              overlayColor: Colors.green.withOpacity(0.4),
            ),
            child: Slider(
              value: pitch,
              onChanged: setPitch,
              min: 0.5,
              max: 2.0,
              divisions: 15,
              label: pitch.toStringAsFixed(2),
            ),
          ),
          const SizedBox(height: 16.0),
          const Text(
            'Select Voice',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold,color: Colors.white),
          ),
          DropdownButton<String>(
            value: selectedVoice,
            onChanged: (value)=> setSelectedVoice(value.toString()),
            items: availableVoices.map((voice) {
              return DropdownMenuItem<String>(
                value: voice['name'],
                child: Text(voice['name']),
              );
            }).toList(),
          ),
          const SizedBox(height: 30),
          const Text(
            'Voice Preview:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white),
          ),
          const SizedBox(height: 15,),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green
            ),
            onPressed: () {
              _speak('This is a voice preview');
            },
            child: const Text('Preview Voice'),
          ),
        ],
      ),
    );
  }
}
