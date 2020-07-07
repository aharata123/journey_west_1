

import 'package:flutter/material.dart';
import 'file:///E:/Term%207/PRM391/BT/journey_west/lib/view/admin/scenario/ScenarioPage.dart';
import 'package:journeywest/view/admin/actor/ActorPage.dart';
import 'package:journeywest/view/admin/tool/ToolPage.dart';

class HomeAdmin extends StatefulWidget {
  @override
  _HomeAdminState createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  int _currentIndex = 0;
  final tabs = [
    Center(child: Text('Home')),
    Center(child: ScenarioPage()),
    Center(child: ActorPage()),
    Center(child: ToolPage()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test'),
      ),
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
            backgroundColor: Colors.blue
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.broken_image),
              title: Text('Scenario'),
              backgroundColor: Colors.blue
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.accessibility),
              title: Text('Actor'),
              backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.airport_shuttle),
              title: Text('Tool'),
              backgroundColor: Colors.blue
          ),
        ],
      onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
      } ,
      ),
    );
  }
}
