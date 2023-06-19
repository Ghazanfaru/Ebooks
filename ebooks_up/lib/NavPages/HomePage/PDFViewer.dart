import 'dart:io';
import 'package:ebooks_up/main.dart';
import 'package:ebooks_up/model/Bookmark.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

// ignore: must_be_immutable
class PDFViewer extends StatefulWidget {
  static const String id = 'PDFViewer';
  String fileUrl;
  String title;
  bool offline;
  bool isBookmark;
  int pageNo;
  PDFViewer(
      {Key? key,
      required this.fileUrl,
      required this.title,
      required this.offline,
      required this.isBookmark,
      required this.pageNo})
      : super(key: key);

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
  var box;
  Future<void> openbox() async {
    box = await Hive.openBox<Bookmark>(RBM);
  }

  @override
  void initState() {
    super.initState();
    downloadFile(widget.fileUrl);
    openbox();
    jumpTobookmark();
  }
  void  jumpTobookmark(){
  if(widget.isBookmark){
  pdfViewerController.jumpToPage(widget.pageNo);
  }
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
                  onPressed: () async {
                    final currentPage = pdfViewerController.pageNumber;
                    await saveTobookmark(
                        currentPage, widget.title, widget.fileUrl);
                  },
                  icon: const Icon(Icons.bookmark_border_rounded)),
              IconButton(
                  onPressed: () {
                    setState(() {
                      if (!play) {
                        play = true;
                      } else {
                        play = false;
                      }
                    });
                    Text_Speech(pdfViewerController.pageNumber);
                  },
                  icon: play
                      ? const Icon(Icons.record_voice_over)
                      : const Icon(Icons.record_voice_over_outlined))
            ],
            title: Text(
              widget.title,
              style: const TextStyle(
                  fontSize: 26,
                  color: Color(0xffb3b3b3),
                  fontWeight: FontWeight.bold),
            ),
            backgroundColor: const Color(0xff535353)),
        body: widget.offline
            ? SfPdfViewer.file(
                File(widget.fileUrl),
                scrollDirection: PdfScrollDirection.horizontal,
                key: _pdfViewerKey,
                controller: pdfViewerController,
                pageLayoutMode: PdfPageLayoutMode.single,

                onPageChanged: (page) {
                  flutterTts.stop();

                    if (play) {
                      setState(() {
                        play = false;
                      });
                    }

                },
              )
            : SfPdfViewer.network(widget.fileUrl,
                scrollDirection: PdfScrollDirection.horizontal,
                key: _pdfViewerKey,
                controller: pdfViewerController,
                pageLayoutMode: PdfPageLayoutMode.single,
                onPageChanged: (page) {
                flutterTts.stop();
                setState(() {
                  if (play) {
                    play = false;
                  }
                });
              }));
  }

  Future<void> Text_Speech(int pageNo) async {
    PdfDocument document;
    if (widget.offline) {
      document =
          PdfDocument(inputBytes: File(widget.fileUrl).readAsBytesSync());
    } else {
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

  Future<void> HighlightSpeech() async {
    flutterTts.setProgressHandler((text, start, end, word) {
      setState(() {});
    });
  }

  Future<void> saveTobookmark(
      int currentPage, String title, String fileUrl) async {
    String filePath = await downloadAndSaveFile(fileUrl, title);
    var bookmark =
        Bookmark(title: title, currentPage: currentPage, fileUrl: filePath);
    box.add(bookmark).whenComplete(() {
      Fluttertoast.showToast(msg: "BookMark Added");
      setState(() {
        // added = true;
      });
    }).onError((error, r) async {
      await Fluttertoast.showToast(msg: error.toString());
      throw error.toString();
    });
  }

  Future<String> downloadAndSaveFile(String fileUrl, String fileName) async {
    final Directory appDirectory = await getApplicationDocumentsDirectory();
    final File file = File('${appDirectory.path}/$fileName');
    await firebase_storage.FirebaseStorage.instance
        .refFromURL(fileUrl)
        .writeToFile(file);

    return file.path;
  }
}
