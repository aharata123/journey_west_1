



import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:journeywest/enums/Status.dart';
import 'package:journeywest/model/Actor.dart';
import 'package:journeywest/view/admin/actor/ActorEditPage.dart';
import 'package:journeywest/view/login.dart';
import 'package:journeywest/view/user/UserHistoryPage.dart';
import 'package:journeywest/view/user/UserSchedulePage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserHomePage extends StatefulWidget {
  @override
  _UserHomePage createState() => _UserHomePage();
}

class _UserHomePage extends State<UserHomePage> {
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
    Center(child: UserHistoryPage()),
    Center(child: UserSchedulePage()),
//    Center(child: ActorPage()),
//    Center(child: ToolPage()),
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
//            ListTile(
//              leading: Icon(Icons.edit),
//              title: Text('Edit Profile'),
//              onTap: () async {
//                Actor actor = Actor(username: user['username'], password: user['password'],
//                name: user['Name'], description: user['Description'], email: user['Email'],
//                id: user['IdActor'], image: user['Image'], phone: user['PhoneNumber'], updatedBy: user['UpdatedBy'],
//                dateUpdated: DateTime.parse(user['DateUpdated']));
//
//                final updated = await Navigator.push(
//                  context,
//                  MaterialPageRoute(builder: (context) => ActorEditPage(actor: actor)),
//                );
//                if(updated == Status.isUpdated) {
//
//                }
//              },
//            ),
            ListTile(
              leading: Icon(Icons.arrow_back),
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
              icon: Icon(Icons.history),
              title: Text('History'),
              backgroundColor: Colors.blue
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            title: Text('Schedule'),
            backgroundColor: Colors.blue,
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
