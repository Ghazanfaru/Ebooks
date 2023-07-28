import 'package:flutter/material.dart';
import '../Accountpage/Account.dart';
import 'Homee.dart';
import '../Librarypage/Library.dart';
import '../searchpage/Search.dart';
import '../TopChartsPage/TopCharts.dart';
class Home extends StatefulWidget {
   const Home({Key? key}) : super(key: key);
   static const String id='Home';
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
   int _SelectedIndex=0;

  final List<Widget> _widgetOptions = <Widget>[
    const Homee(),
    const TopCharts(),
    const Search(),
    const Library(),
    Account(),
  ];

  void _SelectItem(int index){
    setState(() {
      _SelectedIndex =  index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: const Color(0xff121212),
          type: BottomNavigationBarType.fixed,
          selectedItemColor: const Color(0xff1db954),
          unselectedItemColor: const Color(0xffb3b3b3),
          items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home),label:'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.show_chart_sharp),label:'Top Charts'),
          BottomNavigationBarItem(icon: Icon(Icons.travel_explore),label:'Search',),
            BottomNavigationBarItem(icon: Icon(Icons.local_library_outlined),label:'Library',),
            BottomNavigationBarItem(icon: Icon(Icons.person),label:'Account',),
          ],
          currentIndex: _SelectedIndex,
          onTap: _SelectItem,

        ),
          body: _widgetOptions.elementAt(_SelectedIndex)
      ),
    );
  }
}
