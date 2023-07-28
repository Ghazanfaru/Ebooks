import 'package:ebooks_up/NavPages/searchpage/searchedbykey.dart';
import 'package:flutter/material.dart';

import 'SearchClass.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff212121),
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(15),
        )),
        centerTitle: true,
        toolbarHeight: 70,
        backgroundColor: const Color(0xff1db954),
        title: const Text("Search"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.only(right: 30, left: 30),
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextField(
                  onSubmitted: (query) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Searchedbykey(query: query)));
                  },
                  decoration: InputDecoration(
                    hintText: 'Search',
                    hintStyle:
                        const TextStyle(fontSize: 12, color: Color(0xff212121)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        color: Colors.black54,
                      ),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    focusColor: Colors.green,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.only(bottom: 10),
                    filled: true,
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Color(0xff212121),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                  padding: const EdgeInsets.only(
                      top: 20, bottom: 5, left: 20, right: 20),
                  height: 50,
                  child: const Text(
                    'Browse All Interests',
                    style: TextStyle(
                        color: Color(0xffb3b3b3),
                        fontWeight: FontWeight.bold,
                        fontSize: 22),
                  )),
              const SizedBox(
                height: 20,
              ),
              SearchClass(
                category: 'Business',
              ),
              SearchClass(
                category: 'Career & Growth',
              ),
              SearchClass(
                category: 'Finance and money management',
              ),
              SearchClass(
                category: 'Politics',
              ),
              SearchClass(
                category: 'Sports',
              ),
              SearchClass(
                category: 'Games & Activities',
              ),
              SearchClass(
                category: 'Comic & Graphic Novels',
              ),
              SearchClass(
                category: 'Social Science',
              ),
              SearchClass(
                category: 'Travel',
              ),
              SearchClass(
                category: 'Philosophy',
              ),
              SearchClass(
                category: 'Cooking & food',
              ),
              SearchClass(
                category: 'Study aids & Test Preparation',
              ),
              SearchClass(
                category: 'Language',
              ),
              SearchClass(
                category: 'Law',
              ),
              SearchClass(
                category: 'Self-Improvement',
              ),
              SearchClass(
                category: 'Science & Mathematics',
              ),
              SearchClass(
                category: 'Computers',
              ),
              SearchClass(
                category: 'History',
              ),
              SearchClass(
                category: 'Fiction',
              ),
              SearchClass(
                category: 'News ',
              ),
              SearchClass(
                category: 'Life Style',
              ),
              SearchClass(
                category: 'General Fiction',
              ),
              SearchClass(
                category: 'Historical Fiction',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
