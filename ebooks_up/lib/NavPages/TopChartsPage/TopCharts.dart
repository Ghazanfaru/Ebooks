import 'package:cached_network_image/cached_network_image.dart';
import 'package:ebooks_up/AudioPlayer.dart';
import 'package:ebooks_up/NavPages/HomePage/PDFViewer.dart';
import 'package:ebooks_up/model/BooksModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'SelectCategory.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class TopCharts extends StatefulWidget {
  const TopCharts({Key? key}) : super(key: key);

  @override
  State<TopCharts> createState() => _TopChartsState();
}

class _TopChartsState extends State<TopCharts> {
  String type = 'text';
  String category = 'Career & Growth';
  List<String> categories = [
    'Career & Growth',
    'Business',
    'Finance ',
    'Money Management',
    'Politics',
    'Philosophy',
    'Foreign Language Studies',
    'Law',
    'Art',
    'Self Improvement',
    'Wellness',
    'Science & Mathematics',
    'Computers',
    'History',
    'Technology',
    'Engineering',
    'Religion',
    'Horror fiction',
    'Humor',
    'Mystery',
    'Poetry',
    'Crime',
    'Children'
  ];

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Icon formatIcon=const Icon(Icons.multitrack_audio);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff212121),
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(10),
        )),
        centerTitle: true,
        title: const Text(
          'Top Charts',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w400, fontSize: 20),
        ),
        backgroundColor: const Color(0xff1db954),
      ),
      floatingActionButton:SpeedDial(
        backgroundColor: Colors.green,
        animatedIcon: AnimatedIcons.menu_close,
        spaceBetweenChildren: 10,
        children: [
          SpeedDialChild(
            child: type=='text'? const Icon(Icons.multitrack_audio):
              const Icon(Icons.chrome_reader_mode),
            label: 'Format',
            onTap: (){
              setState(() {
                if(type=='text'){
                  type='audio';
                }
                else if(type=='audio'){
                  type='text';
                }
              });

            }
          ),
          SpeedDialChild(
            child: const Icon(Icons.category_outlined),
            label: 'Category',
            onTap: () =>showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return Container(
                  padding: const EdgeInsets.all(16),
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: categories.length,
                    itemBuilder: (BuildContext context, int index) {
                      final item = categories[index];
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            category= item;
                          });
                          Navigator.pop(context);
                        },
                        child: Container(
                          color: Colors.grey[300],
                          child: Center(
                            child: Text(item),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            )
          )
        ],
      ),
      body:StreamBuilder<QuerySnapshot<Map<String,dynamic>>>(
          stream:_firestore.collection(type)
              .where("category",isEqualTo:category)
              .orderBy('rating',descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              Fluttertoast.showToast(msg: snapshot.error.toString());
              print(snapshot.error);
            }  if (snapshot.connectionState ==
                ConnectionState.waiting) {
              return const Text("Loading...");
            }  if (snapshot.data!.docs.isEmpty) {
              return const Text(
                  'Books will be displayed on rating by users.'
                      '\n As soon as users will give the rating top books will be displayed here'
              );
            } else {
              return ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context, index) {
                    BooksModel book = BooksModel();
                    book.id = snapshot.data?.docs[index].id;
                    book.title =
                        snapshot.data?.docs[index]['book_name'];
                    book.category =
                        snapshot.data?.docs[index]['category'];
                    book.imgUrl = snapshot.data?.docs[index]['imgUrl'];
                    book.desc =
                        snapshot.data?.docs[index]['description'];
                    book.author = snapshot.data?.docs[index]['author'];
                    book.fileUrl =
                        snapshot.data?.docs[index]['Fileurl'];
                    return Container(
                      padding: const EdgeInsets.only(top: 50,bottom: 10),
                      decoration: const BoxDecoration(
                          border: Border(
                              top: BorderSide(
                                  width: 1.0,
                                  color: Colors.blueGrey
                              )
                          )
                      ),
                      child: CupertinoListTile(
                        leading: Text(
                          "${index + 1}.",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        trailing:TextButton.icon(onPressed: null, icon: const Icon(Icons.star,color: Colors.orange,),
                            label: Text("${snapshot.data?.docs[index]['rating']}",style: const TextStyle(
                              color: Colors.white70
                            ),)),
                        title: InkWell(
                          onTap: () {
                            showModalBottomSheet<dynamic>(
                                isDismissible: true,
                                backgroundColor:
                                    const Color(0xff212121),
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.vertical(
                                  top: Radius.circular(30),
                                )),
                                context: context,
                                builder: (context) => Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(50),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets
                                                .symmetric(
                                            vertical: 30,
                                            horizontal: 30),
                                        child: Column(
                                          mainAxisSize:
                                              MainAxisSize.max,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  book.title.toString(),
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w900,
                                                      color: Colors.white),
                                                ),
                                                SizedBox(
                                                  height: 50,
                                                  child: IconButton(
                                                    onPressed: () {
                                                      Navigator.pop(
                                                          context);
                                                    },
                                                    icon:
                                                        const Icon(
                                                      Icons.close,
                                                      color: Colors
                                                          .white,
                                                      size: 22,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              book.desc.toString(),
                                              style:
                                                  const TextStyle(
                                                      color: Colors
                                                          .white,
                                                      fontSize: 18),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            SizedBox(
                                              width: 300,
                                              child: ElevatedButton(
                                                style: ElevatedButton
                                                    .styleFrom(
                                                        backgroundColor:
                                                            Colors
                                                                .blueGrey),
                                                onPressed:
                                                    () async {
                                                  if (type ==
                                                      'audio') {
                                                    await Navigator
                                                        .pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              Audioplayer(
                                                                offline: false,
                                                                  booksModel: book)),
                                                    );
                                                  } else {
                                                    await Navigator
                                                        .pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) => PDFViewer(
                                                              fileUrl: book
                                                                  .fileUrl
                                                                  .toString(),
                                                              title: book
                                                                  .title
                                                                  .toString(),
                                                              offline:
                                                                  false, isBookmark: false, pageNo: 0,)),
                                                    );
                                                  }
                                                },
                                                child: type=='text'? const Text(
                                                  'Read',
                                                  style: TextStyle(
                                                      fontSize: 18),
                                                ):
                                                const Text(
                                                  'Play',
                                                  style: TextStyle(
                                                      fontSize: 18),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ));
                          },
                          child: Row(
                            children: [
                              CachedNetworkImage(
                                height: 80,
                                  errorWidget: (context, url, error) => const Icon(Icons.error),

                                  imageUrl: book.imgUrl.toString()),
                              const SizedBox(width: 30,),
                              Flexible(child: Text(book.title.toString(),
                                style: const TextStyle(
                                  color: Colors.white70
                                ),
                                overflow: TextOverflow.ellipsis,))
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            }
          }),
    );
  }


}
