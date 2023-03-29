import 'package:flutter/material.dart';
import '../BooksPage/BookTile.dart';
import 'SelectCategory.dart';

class TopCharts extends StatefulWidget {
  const TopCharts({Key? key}) : super(key: key);

  @override
  State<TopCharts> createState() => _TopChartsState();
}

class _TopChartsState extends State<TopCharts> {
  String dropdownvalue = 'formats';
  var items = [
    'formats',
    'Text',
    'Audio',
  ];
  String dropdownvaluee = 'categories';
  var itemss = [
    'categories',
    'Acedemics',
    'Novels',
    'Science',
    'General',
    'CS',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE2E5DE),
      appBar: AppBar(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom:Radius.circular(10),
            )
        ),
        centerTitle: true,
        title: Text(
          'Top Charts',
          style: TextStyle(
          color: Colors.white, fontWeight: FontWeight.w400, fontSize: 20),
        ),
        backgroundColor: Color(0xff005C29),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(30, 20, 0, 0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'The most popular books and audiobooks\nYou will find here for free with single click',
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(
                height: 22,
              ),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color(0xff005C29),
                      border: Border.all(color: Color(0xff005C29)),
                    ),

                    height: 35,
                    child: Center(
                      child: Padding(
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          child: TextButton(
                            child: Row(
                              children: [
                                Text('Formats',style: TextStyle(color: Colors.white),),
                                Icon(Icons.keyboard_arrow_down_outlined,color: Colors.white,)
                              ],
                            ),
                            onPressed: () {
                              showModalBottomSheet(
                                backgroundColor: Colors.grey[200],
                                  shape: RoundedRectangleBorder(
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
                                                Text(
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
                                                  icon: Icon(
                                                    Icons.close,
                                                    size: 22,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 30,
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
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
                                              padding: EdgeInsets.symmetric(vertical: 30),
                                              child: Column(
                                                children: [
                                                  Container(decoration: BoxDecoration(
                                                    color: Color(0xff005C29),
                                                    borderRadius: BorderRadius.circular(5),
                                                  ),

                                                      width: 300,
                                                      height: 40,
                                                      child: ElevatedButton(
                                                        onPressed: null,
                                                        child: Text(
                                                          'Books',
                                                          style: TextStyle(
                                                              color: Colors.white,
                                                              fontSize: 18),
                                                        ),
                                                      )),
                                                  SizedBox(height: 30,),
                                                  Container(
                                                      decoration: BoxDecoration(
                                                        color: Color(0xff005C29),
                                                        borderRadius: BorderRadius.circular(5),
                                                      ),
                                                      width: 300,
                                                      height: 40,
                                                      child: ElevatedButton(
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

                                            SizedBox(
                                              height: 20,
                                            )
                                          ],
                                        ),
                                      ));
                            },
                          )),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Color(0xff005C29)),
                      color: Color(0xff005C29),
                    ),
                    height: 35,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5, right: 5),
                      child: Center(
                          child: TextButton(
                        child: Row(
                          children: [
                            Text('Categories',style: TextStyle(color: Colors.white),),
                            Icon(Icons.keyboard_arrow_down_outlined,color: Colors.white,),
                          ],
                        ),
                        onPressed: () {
                          showModalBottomSheet(
                            isScrollControlled: true,
                              shape: RoundedRectangleBorder(
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
                                            Text(
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
                                              icon: Icon(
                                                Icons.close,
                                                size: 22,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Wrap(
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
                                      SizedBox(height: 30,),
                                    ],
                                  ));
                        },
                      )),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              BookTiles(
                path: 'lib/assets/images/t1.PNG',
                name: 'Interaction Design',
                category: 'Acedemics',
                author: 'John Wiley',
              ),
              BookTiles(
                path: 'lib/assets/images/t2.PNG',
                name: 'Software Quality\n Engineering',
                category: 'Acedemics',
                author: 'Daniel Galin',
              ),
              BookTiles(
                path: 'lib/assets/images/t3.PNG',
                name: 'Software Project\n Engineering',
                category: 'Acedemics',
                author: 'Unkown',
              ),
              BookTiles(
                path: 'lib/assets/images/t1.PNG',
                name: 'Interaction Design',
                category: 'Acedemics',
                author: 'John Wiley',
              ),
              BookTiles(
                path: 'lib/assets/images/t2.PNG',
                name: 'Software Quality\n Engineering',
                category: 'Acedemics',
                author: 'Daniel Galin',
              ),
              BookTiles(
                path: 'lib/assets/images/t3.PNG',
                name: 'Software Project\n Engineering',
                category: 'Acedemics',
                author: 'Unkown',
              ),
              BookTiles(
                path: 'lib/assets/images/t1.PNG',
                name: 'Interaction Design',
                category: 'Acedemics',
                author: 'John Wiley',
              ),
              BookTiles(
                path: 'lib/assets/images/t2.PNG',
                name: 'Software Quality\n Engineering',
                category: 'Acedemics',
                author: 'Daniel Galin',
              ),
              BookTiles(
                path: 'lib/assets/images/t3.PNG',
                name: 'Software Project\n Engineering',
                category: 'Acedemics',
                author: 'Unkown',
              ),
            ],
          ),
        ),
      ),
    );
  }
}