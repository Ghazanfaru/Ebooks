import 'package:flutter/material.dart';
import '../Accountpage/Account.dart';
import 'Homee.dart';
import '../Librarypage/Library.dart';
import '../searchpage/Search.dart';
import '../TopChartsPage/TopCharts.dart';
class Home extends StatefulWidget {
   Home({Key? key}) : super(key: key);
   static const String id='Home';
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
   int _SelectedIndex=0;

  List<Widget> _widgetOptions = <Widget>[
    Homee(),
    TopCharts(),
    Search(),
    Library(),
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
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Color(0xff005C29),
          unselectedItemColor: Colors.black54,
          items: [
          BottomNavigationBarItem(icon: Icon(Icons.home),label:'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.show_chart_sharp),label:'Top Charts'),
          BottomNavigationBarItem(icon: Icon(Icons.search),label:'Search',),
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
