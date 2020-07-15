

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:journeywest/view/admin/actor/ActorPage.dart';
import 'package:journeywest/view/admin/scenario/ScenarioPage.dart';
import 'package:journeywest/view/admin/tool/ToolPage.dart';
import 'package:journeywest/view/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeAdmin extends StatefulWidget {
  @override
  _HomeAdminState createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
   var user;

   void initState() {
     fetch();
    super.initState();

  }

  Future<void> fetch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      user = json.decode(prefs.get("User"));
    });
  }

  int _currentIndex = 0;
  final tabs = [
//    Center(child: Text('Home')),
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
            UserAccountsDrawerHeader(
              accountName: user == null ? Text('Loading') : Text(user['Name']),
              accountEmail: user == null ? Text('Loading') : Text(user['Email']),
              currentAccountPicture: CircleAvatar(
                radius: 30,
                child: ClipOval(
                  child: Image.network(
                    user == null ? "https://img.pngio.com/common-sitefinity-errors-clarity-errors-png-256_256.png" : user['Image'],
                  ),
                ),
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
        title: Center(child: Text('Journey To The West')),
      ),
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        items: [
//          BottomNavigationBarItem(
//            icon: Icon(Icons.home),
//            title: Text('Home'),
//            backgroundColor: Colors.blue
//          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.broken_image),
              title: Text('Scenario'),
              backgroundColor: Colors.blue
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
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
