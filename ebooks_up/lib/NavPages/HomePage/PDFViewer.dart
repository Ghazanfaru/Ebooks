import 'package:ebooks_up/model/BooksModel.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
class PDFViewer extends StatefulWidget {
  static const String id='PDFViewer';
 BooksModel book=BooksModel();
  PDFViewer({Key? key,required this.book}) : super(key: key);

  @override
  State<PDFViewer> createState() => _PDFViewerState();
}
class _PDFViewerState extends State<PDFViewer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.book.title.toString()),backgroundColor: Color(0xffE2E5DE),),
      body: Container(child: SfPdfViewer.network(widget.book.fileUrl))
    );
  }
}
