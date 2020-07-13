

import 'package:flutter/material.dart';

import 'package:journeywest/view/admin/actor/ActorPage.dart';
import 'package:journeywest/view/admin/scenario/ScenarioPage.dart';
import 'package:journeywest/view/admin/tool/ToolPage.dart';
import 'package:journeywest/view/login.dart';

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
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Item 1'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Log Out'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                    LoginPage()), (Route<dynamic> route) => false);
              },
            ),
          ],
        ),
      ),
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
