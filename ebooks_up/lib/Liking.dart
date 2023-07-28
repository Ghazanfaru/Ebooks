import 'package:ebooks_up/NavPages/HomePage/Home.dart';
import 'package:ebooks_up/main.dart';
import 'package:ebooks_up/model/LikingCategory.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';

class Liking extends StatelessWidget {
  const Liking({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Liking Categories',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const LikingCategoriesScreen(),
    );
  }
}

class LikingCategoriesScreen extends StatefulWidget {
  static const String id='LikingPage';
  const LikingCategoriesScreen({super.key});

  @override
  _LikingCategoriesScreenState createState() => _LikingCategoriesScreenState();
}

class _LikingCategoriesScreenState extends State<LikingCategoriesScreen> {
  bool check=false;
  final List<LikingCategory> _likingCategories = [
    LikingCategory(name: 'Career & Growth', isSelected: false),
    LikingCategory(name: 'Business',isSelected:false),
    LikingCategory(name: 'Finance', isSelected: false),
    LikingCategory(name: 'Money Management', isSelected: false),
    LikingCategory(name: 'Politics', isSelected: false),
    LikingCategory(name: 'Philosophy', isSelected: false),
    LikingCategory(name: 'Foreign Language Studies', isSelected: false),
    LikingCategory(name: 'Law', isSelected: false),
    LikingCategory(name: 'Art', isSelected: false),
    LikingCategory(name: 'Self Improvement', isSelected: false),
    LikingCategory(name: 'Wellness', isSelected: false),
    LikingCategory(name: 'Science & Mathematics', isSelected: false),
    LikingCategory(name: 'Computers', isSelected: false),
    LikingCategory(name: 'History', isSelected: false),
    LikingCategory(name: 'Technology', isSelected: false),
    LikingCategory(name: 'Engineering', isSelected: false),
    LikingCategory(name: 'Religion', isSelected: false),
    LikingCategory(name: 'Horror fiction', isSelected: false),
    LikingCategory(name: 'Humor', isSelected: false),
    LikingCategory(name: 'Mystery', isSelected: false),
    LikingCategory(name: 'Poetry', isSelected: false),
    LikingCategory(name: 'Crime', isSelected: false),
    LikingCategory(name: 'Children', isSelected: false),
  ];
  var _likingBox;
  void OpenBox(){
   Hive.openBox<LikingCategory>(liking).then((value) {
     setState(() {
       _likingBox=value;
     });
   });

  }

    @override
  void initState() {
    super.initState();
    OpenBox();
  }
  var _selectedCount=0;
  void _toggleCategorySelection(int index) {
    setState(() {
      if (_likingCategories[index].isSelected) {
        _selectedCount--;
        _likingCategories[index].isSelected=false;
      } else {
        if (_selectedCount < 5) {
          _likingCategories[index].isSelected=true;
          _selectedCount++;
        } else {
          return;
        }
      }
    });
  }


  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: const Color(0xff212121),
      appBar: AppBar(
        backgroundColor: const Color(0xff1db954),
        title:const Center(child: Text("Categories"),) ,
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'What you like?   😊📚️',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height:15),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
              ),
              itemCount: _likingCategories.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => _toggleCategorySelection(index),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: _likingCategories[index].isSelected? const Color(0xff1db954) : Colors.grey[800],
                    ),
                    child: Center(
                      child: Text(
                        _likingCategories[index].name,
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: const Icon(Icons.navigate_next),
        onPressed: () {
          _likingBox.clear();
          final selectedCategories = _likingCategories.where((category) => category.isSelected).toList();
          setState(() {
            Hive.box(checkNewUSer).put("newUser",false);
          });
          if(_selectedCount==5) {
            Navigator.pushReplacementNamed(context, Home.id);
          }
          else {
            Fluttertoast.showToast(msg: "Select 5 categories",toastLength: Toast.LENGTH_LONG);
          }
          for (final category in selectedCategories) {
            _likingBox.add(category);
          }
          for(final value in _likingBox.values){
            print(value.name);
          }
        },
      ),
    );
  }
}