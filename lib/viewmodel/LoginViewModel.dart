import 'dart:convert';

import 'package:journeywest/enums/Role.dart';
import 'package:journeywest/enums/ViewState.dart';
import 'package:journeywest/model/Actor.dart';
import 'package:journeywest/viewmodel/BaseModel.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class LoginViewModel extends BaseModel {
  String username, password;

  Future<Role> login() async {
    setState(ViewState.Busy);
    Map<String,String> map = Map();
    map['username'] = username;
    map['password'] = password;

    var response = await http.post(
        'http://journeytothewestapi.azurewebsites.net/api/actor/login',
        body: map
    );

    if(response.statusCode == 200) {
      final parsed = json.decode(response.body);
      Actor actor = Actor.fromJson(parsed);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("User", response.body);


      setState(ViewState.Retrieved);
      if(parsed['role'] == 1) {
        return Role.ADMIN;
      } else if(parsed['role'] == 2) {
        return Role.EMPLOYEE;
      }
    } else {
      setState(ViewState.Retrieved);
      return null;
    }


//    if(username == 'admin' && password == '123') {
//      setState(ViewState.Retrieved);
//      return Role.ADMIN;
//    } else if (username == 'test1' && password == '123') {
//      setState(ViewState.Retrieved);
//      return Role.EMPLOYEE;
//    } else {
//      setState(ViewState.Retrieved);
//      return null;
//    }
  }

}