import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ebooks_up/AudioPlayer.dart';
import '../../../model/BooksModel.dart';
import '../../TopChartsPage/Rating.dart';
import '../ReadableBooks/ListsNames.dart';

class AudiableBooks extends StatefulWidget {
  const AudiableBooks({super.key});
  @override
  State<AudiableBooks> createState() => _AudiableBooksState();
}

class _AudiableBooksState extends State<AudiableBooks> {
  FirebaseFirestore store = FirebaseFirestore.instance;

  List<String> categories = [
    'Categories',
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

  var category = 'Career & Growth';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff212121),
      body: SingleChildScrollView(
        child: Center(
          child: Column(children: [
            InkWell(
                onTap: () => ShowCategory(),
                child: TextButtons(
                  text: category,
                  btntxt: 'Category',
                )),
            SizedBox(
              height: 200,
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: store
                      .collection('audio')
                      .where('category', isEqualTo: category)
                      .snapshots(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.none) {
                      return const Center(
                        child: Text("Please Connect to Internet"),
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                          child: CircularProgressIndicator(
                        color: Colors.green,
                      ));
                    } else if (snapshot.connectionState ==
                        ConnectionState.active) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            itemCount: snapshot.data?.docs.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                              BooksModel book = BooksModel();
                              book.id = snapshot.data?.docs[index].id;
                              book.title =
                                  snapshot.data?.docs[index]['book_name'];
                              book.category =
                                  snapshot.data?.docs[index]['category'];
                              book.imgUrl =
                                  snapshot.data?.docs[index]['imgUrl'];
                              book.desc =
                                  snapshot.data?.docs[index]['description'];
                              book.author =
                                  snapshot.data?.docs[index]['author'];
                              book.fileUrl =
                                  snapshot.data?.docs[index]['Fileurl'];
                              book.rating =
                                  snapshot.data?.docs[index]['rating'];
                              return SizedBox(
                                height: 200,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              book.imgUrl.toString()),
                                          fit: BoxFit.cover,
                                          opacity: 0.1),
                                    ),
                                    child: Row(
                                      children: [
                                        InkWell(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 30),
                                              child: Column(
                                                children: [
                                                  const SizedBox(
                                                    height: 15,
                                                  ),
                                                  Image.network(
                                                    book.imgUrl.toString(),
                                                    width: 100,
                                                    height: 130,
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Center(
                                                    child: Rating(
                                                        type: 'text',
                                                        documentID:
                                                            book.id.toString(),
                                                        oldRating:
                                                            book.rating ?? 0),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            onTap: () {
                                              showModalBottomSheet<dynamic>(
                                                  isDismissible: true,
                                                  backgroundColor:
                                                      const Color(0xffb3b3b3),
                                                  shape:
                                                      const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .vertical(
                                                    top: Radius.circular(30),
                                                  )),
                                                  context: context,
                                                  builder: (context) => Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(50),
                                                      image: DecorationImage(
                                                          image: NetworkImage(
                                                              book.imgUrl.toString()),
                                                          fit: BoxFit.cover,
                                                          opacity: 0.1),
                                                    ),
                                                    child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  vertical: 30,
                                                                  horizontal: 30),
                                                          child:
                                                              SingleChildScrollView(
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    SizedBox(
                                                                      height: 100,
                                                                      width: 200,
                                                                      child: Text(
                                                                        book.title
                                                                            .toString(),
                                                                        style: const TextStyle(
                                                                            fontWeight: FontWeight
                                                                                .bold,
                                                                            fontSize:
                                                                                22),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      height: 100,
                                                                      child:
                                                                          IconButton(
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                        icon:
                                                                            const Icon(
                                                                          Icons
                                                                              .close,
                                                                          size:
                                                                              22,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Text(
                                                                  book.desc
                                                                      .toString(),
                                                                  style:
                                                                      const TextStyle(
                                                                          fontSize:
                                                                              18),
                                                                ),
                                                                const SizedBox(
                                                                  height: 10,
                                                                ),
                                                                SizedBox(
                                                                  width: 300,
                                                                  child:
                                                                      ElevatedButton(
                                                                    style: ElevatedButton.styleFrom(
                                                                        backgroundColor:
                                                                            const Color(
                                                                                0xff212121)),
                                                                    onPressed:
                                                                        () async {
                                                                      await Navigator
                                                                          .pushReplacement(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                          builder:
                                                                              (context) =>
                                                                                  Audioplayer(
                                                                            booksModel:
                                                                                book,
                                                                          ),
                                                                        ),
                                                                      );
                                                                    },
                                                                    child:
                                                                        const Text(
                                                                      'Read Now',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              18),
                                                                    ),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  height: 10,
                                                                ),
                                                                SizedBox(
                                                                  width: 300,
                                                                  child:
                                                                      ElevatedButton(
                                                                    style: ElevatedButton.styleFrom(
                                                                        backgroundColor:
                                                                            const Color(
                                                                                0xff212121)),
                                                                    onPressed:
                                                                        () {},
                                                                    child:
                                                                        const Text(
                                                                      'Add to Library',
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .white,
                                                                          fontSize:
                                                                              18),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                  ));
                                            }),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        SizedBox(
                                          height: 260,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 50, left: 20),
                                            child: Column(
                                              children: [
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                SizedBox(
                                                  height: 50,
                                                  width: 200,
                                                  child: Text(
                                                    book.title.toString(),
                                                    style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  book.author.toString(),
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      color: Colors.white),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                      }
                    }
                    return const Center(
                      child: Text("Check Internet Connection"),
                    );
                  }),
            ),
          ]),
        ),
      ),
    );
  }

  void ShowCategory() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          height: 200,
          child: ListView.builder(
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(categories[index]),
                onTap: () {
                  setState(() {
                    category = categories[index];
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
