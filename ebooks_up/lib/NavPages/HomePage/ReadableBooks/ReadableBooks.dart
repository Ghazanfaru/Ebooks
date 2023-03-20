import 'package:flutter/material.dart';
import '../../TopChartsPage/Rating.dart';
import '../AudiableBooks/Listname.dart';
import 'BookModel.dart';
class ReadableBooks extends StatelessWidget {



  static List<String> Bookname=['Interaction Design',
    'Software Quality\n Engineering',
    'Software Project\n Management',
    'Interaction Design',
    'Software Quality\n Engineering',
    'Software Project\n Management',
    'Interaction Design',
    'Software Quality\n Engineering',
    'Software Project\n Management',];

  static List<String> Category=['Acedemics','Acedemics','Acedemics','Acedemics','Acedemics','Acedemics','Acedemics','Acedemics','Acedemics',];

  static List<String> imgpath=['lib/assets/images/t1.PNG',
    'lib/assets/images/t2.PNG',
    'lib/assets/images/t3.PNG',
    'lib/assets/images/t1.PNG',
    'lib/assets/images/t2.PNG',
    'lib/assets/images/t3.PNG',
    'lib/assets/images/t1.PNG',
    'lib/assets/images/t2.PNG',
    'lib/assets/images/t3.PNG',
  ];
  
  static List<String> Description=['This is an Interaction Design Book And the Author Name is John Wiley',
    'This is Software Quality Engineering Book And the Author name is Danile Galin',
    'This is Software Project Management Book and the author name is Unknown for now',
    'This is an Interaction Design Book And the Author Name is John Wiley',
    'This is Software Quality Engineering Book And the Author name is Danile Galin',
    'This is Software Project Management Book and the author name is Unknown for now',
    'This is an Interaction Design Book And the Author Name is John Wiley',
    'This is Software Quality Engineering Book And the Author name is Danile Galin',
    'This is Software Project Management Book and the author name is Unknown for now',];

  static List<String> Author=['John Wiley','Daniel Galin','Unknown','John Wiley','Daniel Galin','Unknown','John Wiley','Daniel Galin','Unknown',];

  final List<BookModel> BookData=List.generate(Bookname.length,
          (index) =>
              BookModel(Bookname[index], Category[index],Author[index],imgpath[index],Description[index]),);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffE2E5DE),
      body: SingleChildScrollView(
        child: Container(

          child: Column(
              children: [
               const TextButtons(text: 'Computers', btntxt: 'More',),
                SizedBox(
                  height: 260,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                      itemCount: BookData.length,itemBuilder: (context,index){
                    return SizedBox(
                      height: 250,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child:
                            Column(
                              children: [
                                InkWell(child: Container(child: Column(
                                  children: [
                                    Image.asset(BookData[index].imgpath,width: 100,height: 130,),
                                    Text(BookData[index].Bookname,style:const TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),

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
                                            Text(BookData[index].Bookname,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
                                            IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.close,size: 22,),),

                                          ],),
                                          Container(
                                              width: 100,
                                              height: 150,
                                              child: Image.asset(BookData[index].imgpath,fit: BoxFit.cover,)),
                                          Text(BookData[index].description,style: TextStyle(fontSize: 18),),
                                          SizedBox(height: 30,),
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
                                Text(BookData[index].Category,style: const TextStyle(fontSize: 13,fontWeight: FontWeight.w400),),
                                const SizedBox(height: 2,),
                                Text(BookData[index].Author,style: const TextStyle(fontSize: 11,fontWeight: FontWeight.w300),),
                                const SizedBox(height: 2,),
                                const Rating(),
                              ],
                            ),
                      ),
                    );
                  }),
                ),

                const Divider(height: 10,thickness: 3,),

                const TextButtons(text: 'Software Engineering', btntxt: 'More',),

                SizedBox(
                  height: 250,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: BookData.length,itemBuilder: (context,index){
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child:
                      Column(
                        children: [
                          InkWell(child: Container(child: Column(
                            children: [
                              Image.asset(BookData[index].imgpath,width: 100,height: 130,),
                              Text(BookData[index].Bookname,style:const TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),

                            ],
                          )),onTap: (){
                            showModalBottomSheet<dynamic>(isDismissible: true,
                                shape: RoundedRectangleBorder(
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
                                            Text(BookData[index].Bookname,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
                                            IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.close,size: 22,),),

                                          ],),
                                        Container(
                                            width: 100,
                                            height: 150,
                                            child: Image.asset(BookData[index].imgpath,fit: BoxFit.cover,)),
                                        Text(BookData[index].description,style: TextStyle(fontSize: 18),),
                                        SizedBox(height: 30,),
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
                          Text(BookData[index].Category,style:const TextStyle(fontSize: 13,fontWeight: FontWeight.w400),),
                          const SizedBox(height: 2,),
                          Text(BookData[index].Author,style:const TextStyle(fontSize: 11,fontWeight: FontWeight.w300),),
                          const SizedBox(height: 2,),
                          const Rating(),
                        ],
                      ),
                    );
                  }),
                ),

                const Divider(height: 10,thickness: 3,),

              ]),
        ),
      )
    );
  }
}


