import 'package:flutter/material.dart';
import 'SelectCategory.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class TopCharts extends StatefulWidget {
  const TopCharts({Key? key}) : super(key: key);

  @override
  State<TopCharts> createState() => _TopChartsState();
}

class _TopChartsState extends State<TopCharts> {
  String type = 'formats';
  var types = [
    'formats',
    'Text',
    'Audio',
  ];
  String category = 'categories';
  var categories = [
    'categories',
    'Acedemics',
    'Novels',
    'Science',
    'General',
    'CS',
  ];

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff212121),
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom:Radius.circular(10),
            )
        ),
        centerTitle: true,
        title: const Text(
          'Top Charts',
          style: TextStyle(
          color: Colors.white, fontWeight: FontWeight.w400, fontSize: 20),
        ),
        backgroundColor: const Color(0xff1db954),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 20, 0, 0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'The most popular books and audiobooks\nYou will find here for free with single click',
                style: TextStyle(fontSize: 15,color: Color(0xffb3b3b3)),
              ),
              const SizedBox(
                height: 22,
              ),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color(0xff1db954),
                      border: Border.all(color: const Color(0xff1db954)),
                    ),

                    height: 35,
                    child: Center(
                      child: Padding(
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          child: TextButton(
                            child: const Row(
                              children: [
                                Text('Formats',style: TextStyle(color: Colors.white),),
                                Icon(Icons.keyboard_arrow_down_outlined,color: Colors.white,)
                              ],
                            ),
                            onPressed: () {
                              showModalBottomSheet(
                                backgroundColor: Colors.grey[200],
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(30),
                                  )
                                  ),
                                  context: context,
                                  builder: (context) => Padding(
                                        padding: const EdgeInsets.all(20),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Text(
                                                  'Formats',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 22),
                                                ),
                                                IconButton(
                                                  onPressed: (){
                                                    Navigator.pop(context);
                                                  },
                                                  icon: const Icon(
                                                    Icons.close,
                                                    size: 22,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 30,
                                            ),
                                            Container(
                                              decoration: const BoxDecoration(
                                                color: Colors.white,
                                                boxShadow: [
                                                BoxShadow(
                                                color: Colors.black54,
                                                offset: Offset(0.0, 1.0),
                                                blurRadius: 6.0,
                                              ),
                                              ],
                                              ),

                                              height: 170,
                                              width: 360,
                                              padding: const EdgeInsets.symmetric(vertical: 30),
                                              child: Column(
                                                children: [
                                                  Container(decoration: BoxDecoration(
                                                    color: const Color(0xff1db954),
                                                    borderRadius: BorderRadius.circular(5),
                                                  ),

                                                      width: 300,
                                                      height: 40,
                                                      child: const ElevatedButton(
                                                        onPressed: null,
                                                        child: Text(
                                                          'Books',
                                                          style: TextStyle(
                                                              color: Colors.white,
                                                              fontSize: 18),
                                                        ),
                                                      )),
                                                  const SizedBox(height: 30,),
                                                  Container(
                                                      decoration: BoxDecoration(
                                                        color: const Color(0xff005C29),
                                                        borderRadius: BorderRadius.circular(5),
                                                      ),
                                                      width: 300,
                                                      height: 40,
                                                      child: const ElevatedButton(
                                                        onPressed: null,
                                                        child: Text(
                                                          'Audio Books',
                                                          style: TextStyle(
                                                              color: Colors.white,
                                                              fontSize: 18),
                                                        ),
                                                      )),
                                                ],
                                              ),
                                            ),

                                            const SizedBox(
                                              height: 20,
                                            )
                                          ],
                                        ),
                                      ));
                            },
                          )),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xff1db954)),
                      color: const Color(0xff1db954),
                    ),
                    height: 35,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5, right: 5),
                      child: Center(
                          child: TextButton(
                        child: const Row(
                          children: [
                            Text('Categories',style: TextStyle(color: Colors.white),),
                            Icon(Icons.keyboard_arrow_down_outlined,color: Colors.white,),
                          ],
                        ),
                        onPressed: () {
                          showModalBottomSheet(
                            isScrollControlled: true,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                top: Radius.circular(30),
                              )),
                              context: context,
                              builder: (context) => Column(
                                mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(20),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            const Text(
                                              'Categories',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight:
                                                  FontWeight.bold,
                                                  fontSize: 22),
                                            ),
                                            IconButton(
                                              onPressed: (){
                                                Navigator.pop(context);
                                              },
                                              icon: const Icon(
                                                Icons.close,
                                                size: 22,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Wrap(
                                        spacing: 10,
                                        runSpacing: 10,
                                        children: [
                                          SelectCategoryButton(Txt: 'Business',),
                                          SelectCategoryButton(Txt: 'Politics'),
                                          SelectCategoryButton(Txt: 'Education'),
                                          SelectCategoryButton(Txt: 'Business',),
                                          SelectCategoryButton(Txt: 'Politics'),
                                          SelectCategoryButton(Txt: 'Education'),
                                          SelectCategoryButton(Txt: 'Business',),
                                          SelectCategoryButton(Txt: 'Politics'),
                                          SelectCategoryButton(Txt: 'Education'),
                                          SelectCategoryButton(Txt: 'Business',),
                                          SelectCategoryButton(Txt: 'Politics'),
                                          SelectCategoryButton(Txt: 'Education'),
                                          SelectCategoryButton(Txt: 'Business',),
                                          SelectCategoryButton(Txt: 'Politics'),
                                          SelectCategoryButton(Txt: 'Education'),

                                        ],
                                      ),
                                      const SizedBox(height: 30,),
                                    ],
                                  ));
                        },
                      )),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Stream<QuerySnapshot> getDocumentsStream(String category) {
    return _firestore
        .collection('text')
        .where('category', isEqualTo: category)
        .orderBy('rating', descending: true)
        .snapshots();
  }

}