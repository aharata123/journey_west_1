import 'package:journeywest/enums/Role.dart';
import 'package:journeywest/enums/ViewState.dart';
import 'package:journeywest/viewmodel/BaseModel.dart';

class LoginViewModel extends BaseModel {
  String username, password;


  Future<Role> login() async {
    setState(ViewState.Busy);
    await Future.delayed(Duration(seconds: 0));
    if(username == 'admin' && password == '123') {
      setState(ViewState.Retrieved);
      return Role.ADMIN;
    } else if (username == 'test1' && password == '123') {
      setState(ViewState.Retrieved);
      return Role.EMPLOYEE;
    } else {
      setState(ViewState.Retrieved);
      return null;
    }
  }

}