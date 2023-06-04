import 'dart:io';
import 'package:ebooks_up/main.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';


// ignore: must_be_immutable
class PDFViewer extends StatefulWidget {
  static const String id = 'PDFViewer';
  String fileUrl;
  String title;
  bool offline;
  PDFViewer({Key? key, required this.fileUrl,required this.title, required this.offline}) : super(key: key);

  @override
  State<PDFViewer> createState() => _PDFViewerState();
}

class _PDFViewerState extends State<PDFViewer> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  PdfViewerController pdfViewerController = PdfViewerController();
  int pageNum = 0;
  FlutterTts flutterTts = FlutterTts();
  bool isSpeaking = false;
  String? text;
  String? filePath;
  bool play = false;
  @override
  void initState() {
    super.initState();
    downloadFile(widget.fileUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () {
                    _pdfViewerKey.currentState?.openBookmarkView();
                  },
                  icon: const Icon(Icons.table_rows)),
              IconButton(
                  onPressed: () {
                    final currentPage = pdfViewerController.pageNumber;
                    setBookMark(currentPage, widget.title);
                  },
                  icon: const Icon(Icons.bookmark_border_rounded)),
              IconButton(
                  onPressed: () {
                    setState(() {
                      if (!play) {
                        play = true;
                      }
                      else {
                        play=false;
                      }
                    });
                    Text_Speech(pdfViewerController.pageNumber);

                  },
                  icon: play
                       ? const Icon(Icons.record_voice_over)
                      :const Icon(Icons.record_voice_over_outlined)
              ) ],
            title: Text(
              widget.title,
              style: const TextStyle(
                  fontSize: 26,
                  color: Color(0xffb3b3b3),
                  fontWeight: FontWeight.bold),
            ),
            backgroundColor: const Color(0xff535353)),
        body: widget.offline?SfPdfViewer.file(
          File(widget.fileUrl),
          scrollDirection: PdfScrollDirection.horizontal,
          key: _pdfViewerKey,
          controller: pdfViewerController,
          pageLayoutMode: PdfPageLayoutMode.single,
          onPageChanged: (page){
            flutterTts.stop();
            setState(() {
              if(play){
                play=false;
              }
            });

            },

        ):SfPdfViewer.network(
          widget.fileUrl,
          scrollDirection: PdfScrollDirection.horizontal,
          key: _pdfViewerKey,
          controller: pdfViewerController,
          pageLayoutMode: PdfPageLayoutMode.single,
            onPageChanged: (page){
              flutterTts.stop();
              setState(() {
                if(play){
                  play=false;
                }
              });

            }
        )
    );
  }


  Future<void> Text_Speech(int pageNo) async {
    PdfDocument document;
    if(widget.offline){
      document=PdfDocument(inputBytes: File(widget.fileUrl).readAsBytesSync());
    }
    else {
      document =
      PdfDocument(inputBytes: File(filePath.toString()).readAsBytesSync());
    }
    text = PdfTextExtractor(document).extractText(startPageIndex: pageNo - 1);

    if (play) {
      flutterTts.speak(text!);
    } else {
      flutterTts.pause();
    }
  }

  Future<void> downloadFile(String url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String appDocPath = appDocDir.path;
      String fileName = '${widget.title}.txt';
      File file = File('$appDocPath/$fileName');
      await file.writeAsBytes(response.bodyBytes);
      filePath = file.path;
    } else {
      throw Exception('Failed to download file');
    }
  }

  Future<void> setBookMark(int pageNo,String title)async{
    await Hive.box(Bookmarks).putAll({
      'title':"Last Read: $title",
      'page_no':pageNum
    }).whenComplete(() => Fluttertoast.showToast(msg: "BookMark Added")).onError((error, stackTrace) => Fluttertoast.showToast(msg: "Couldn't save bookmark please try again")
    );
  }

  Future<void> HighlightSpeech() async {
    flutterTts.setProgressHandler((text, start, end, word) {
      setState(() {});
    });
  }
}
