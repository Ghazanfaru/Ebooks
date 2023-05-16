import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebooks_up/NavPages/HomePage/PDFViewer.dart';
import 'package:ebooks_up/model/BooksModel.dart';
import 'package:flutter/material.dart';
import '../../TopChartsPage/Rating.dart';
import '../AudiableBooks/Listname.dart';
class ReadableBooks extends StatefulWidget {

  @override
  State<ReadableBooks> createState() => _ReadableBooksState();
}

class _ReadableBooksState extends State<ReadableBooks> {
  FirebaseFirestore store=FirebaseFirestore.instance;
  List<String> categories=['Categories','Career & Growth','Business','Finance ','Money Management','Politics','Philosophy','Foreign Language Studies','Law','Art','Self Improvement','Wellness','Science & Mathematics','Computers','History','Technology','Engineering','Religion','Horror fiction','Humor','Mystery','Poetry','Crime','Children'];
  var category='Career & Growth';
  var category2='Business';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff212121),
      body: SingleChildScrollView(
        child: Container(

          child: Column(
              children: [
                InkWell(onTap: ()=>ShowCategory(),
                    child: TextButtons(text: category, btntxt: 'More',)),
                SizedBox(
                  height: 260,
                  child: StreamBuilder<QuerySnapshot<Map<String,dynamic>>>(
                      stream: store.collection('text').where('category',isEqualTo: category).snapshots(),
                      builder:(context,AsyncSnapshot snapshot){
                        if(snapshot.connectionState==ConnectionState.waiting)
                        {
                          return const Center(child: CircularProgressIndicator(color: Colors.green,));
                        }
                      else if(snapshot.connectionState==ConnectionState.active){
                        if(snapshot.hasData){

                          return ListView.builder(
                            itemCount: snapshot.data?.docs.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context,int index){
                              BooksModel book=BooksModel();
                              book.title =snapshot.data?.docs[index]['book_name'];
                              book.category=snapshot.data?.docs[index]['category'];
                              book.imgUrl=snapshot.data?.docs[index]['imgUrl'];
                              book.desc=snapshot.data?.docs[index]['description'];
                              book.author=snapshot.data?.docs[index]['author'];
                              book.fileUrl=snapshot.data?.docs[index]['Fileurl'];
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
                                SizedBox(height: 10,),
                                Text(book.title.toString(),style:const TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),

                              ],
                            )),onTap: (){
                              showModalBottomSheet<dynamic>(isDismissible: true,
                              backgroundColor: Color(0xffb3b3b3),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(30),
                                )
                              ),context: context, builder: (context)=>
                                      Padding(
                                        
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
                                      SizedBox(
                                        width: 300,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(primary: Color(0xff212121)
                                          ),
                                          onPressed: (){
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => PDFViewer(book: book,),
                                              ),
                                            );
                                          },
                                          child: Text(
                                            'Read Now',
                                            style: TextStyle(

                                                fontSize: 18),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10,),

                                      SizedBox(
                                        width: 300,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            primary: Color(0xff212121)
                                          ),
                                          onPressed: null,
                                          child: Text(
                                            'Add to Library',
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
                            Text(category,style: const TextStyle(fontSize: 13,fontWeight: FontWeight.w400),),
                            const SizedBox(height: 2,),
                            Text(book.author.toString(),style: const TextStyle(fontSize: 11,fontWeight: FontWeight.w300),),
                            const SizedBox(height: 2,),
                            const Rating(),
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
                ),

                const Divider(height: 10,thickness: 3,),

                 InkWell(onTap:()=>ShowCategory2(),child: TextButtons(text: category2, btntxt: 'More',)),

                SizedBox(
                  height: 260,
                  child: StreamBuilder<QuerySnapshot<Map<String,dynamic>>>(
                      stream: store.collection('text').where('category',isEqualTo: category2).snapshots(),
                      builder:(context,AsyncSnapshot snapshot){
                        if(snapshot.connectionState==ConnectionState.waiting)
                        {return const Center(child: CircularProgressIndicator(color: Colors.green,));}
                        else if(snapshot.connectionState==ConnectionState.active){
                          if(snapshot.hasData){

                            return ListView.builder(
                                itemCount: snapshot.data?.docs.length,
                                scrollDirection: Axis.horizontal,
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
                                                                  builder: (context) => PDFViewer(book: book,),
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
                                          Text(category,style: const TextStyle(fontSize: 13,fontWeight: FontWeight.w400),),
                                          const SizedBox(height: 2,),
                                          Text(book.author,style: const TextStyle(fontSize: 11,fontWeight: FontWeight.w300),),
                                          const SizedBox(height: 2,),
                                          const Rating(),
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
                ),
                const Divider(height: 10,thickness: 3,),

              ]),
        ),
      )
    );
  }

  void ShowCategory() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 200,
          child: ListView.builder(
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(categories[index]),
                onTap: () {
                  setState(() {
                    category= categories[index];
                  });
                  Navigator.pop(context);
                },
              );
            },
          ),
        );
      },
    );
  }
  void ShowCategory2() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 200,
          child: ListView.builder(
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(categories[index]),
                onTap: () {
                  setState(() {
                    category2= categories[index];
                  });
                  Navigator.pop(context);
                },
              );
            },
          ),
        );
      },
    );
  }
}


