import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../model/BooksModel.dart';
import '../HomePage/PDFViewer.dart';
import '../TopChartsPage/Rating.dart';
class Searchedbykey extends StatefulWidget {
  var query;

  static String id='SearchedPage';

  Searchedbykey({Key? key,required this.query}) : super(key: key);

  @override
  State<Searchedbykey> createState() => _SearchedbykeyState();
}

class _SearchedbykeyState extends State<Searchedbykey> {
  FirebaseFirestore store=FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      backgroundColor: Color(0xffE2E5DE),
      appBar: AppBar(
        title: Text("Explore Books"),
        backgroundColor:  Color(0xff005C29),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String,dynamic>>>(
          stream: store.collection('text').where('keywords', arrayContainsAny: widget.query.split(' ')).snapshots(),
          builder:(context,AsyncSnapshot snapshot){
            if(snapshot.connectionState==ConnectionState.waiting)
            {return const Center(child: CircularProgressIndicator(color: Colors.green,));}
            else if(snapshot.connectionState==ConnectionState.active){
              if(snapshot.hasData){

                return ListView.builder(
                    itemCount: snapshot.data?.docs.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context,int index){
                      BooksModel book=BooksModel();
                      book.title=snapshot.data?.docs[index]['book_name'];
                      book.category=snapshot.data?.docs[index]['category'];
                      book.imgUrl=snapshot.data?.docs[index]['imgUrl'];
                      book.desc=snapshot.data?.docs[index]['description'];
                      book.fileUrl=snapshot.data?.docs[index]['Fileurl'];
                      book.author=snapshot.data?.docs[index]['author'];
                      return  SizedBox(
                        height: 250,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child:
                          Column(
                            children: [
                              InkWell(child: Container(child: Column(
                                children: [
                                  Image.network(book.imgUrl.toString(),width: 100,height: 130,),
                                  Text(book.title.toString(),style:const TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),

                                ],
                              )),onTap: (){
                                showModalBottomSheet<dynamic>(isDismissible: true,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(30),
                                        )
                                    ),context: context, builder: (context)=>Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 30),
                                      child: SingleChildScrollView(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(book.title.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
                                                IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.close,size: 22,),),

                                              ],),
                                            Container(
                                                width: 100,
                                                height: 150,
                                                child: Image.network(book.imgUrl.toString(),fit: BoxFit.cover,)),
                                            Text(book.desc.toString(),style: TextStyle(fontSize: 18),),
                                            SizedBox(height: 30,),
                                            Container(
                                              decoration: BoxDecoration(
                                                color: Colors.lightBlue,
                                                borderRadius: BorderRadius.circular(5),
                                              ),
                                              width: 300,
                                              height: 40,
                                              child: ElevatedButton(
                                                onPressed: (){
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => PDFViewer(title: book.title.toString(),fileUrl:book.fileUrl.toString(),offline: false,),
                                                    ),
                                                  );
                                                },
                                                child: Text(
                                                  'Read',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18),
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 10,),

                                            Container(
                                              decoration: BoxDecoration(
                                                color: Colors.lightBlue,
                                                borderRadius: BorderRadius.circular(5),
                                              ),
                                              width: 300,
                                              height: 40,
                                              child: ElevatedButton(
                                                onPressed: null,
                                                child: Text(
                                                  'Download',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18),
                                                ),
                                              ),
                                            ),

                                          ],
                                        ),
                                      ),
                                    ));
                              }),
                              const SizedBox(height: 2,),
                              const SizedBox(height: 2,),
                              Text(book.author,style: const TextStyle(fontSize: 11,fontWeight: FontWeight.w300),),
                              const SizedBox(height: 2,),

                            ],
                          ),
                        ),
                      );
                    }
                );
              }
            }
            return Center(child: Text("Check Internet Connection"),);
          }
      ),
    );
  }
}
