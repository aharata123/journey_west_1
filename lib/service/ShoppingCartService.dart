
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:journeywest/model/RoleInScenario.dart';
import 'package:journeywest/model/RoleInScenarioForm.dart';
import 'package:journeywest/model/ToolInScenarioForm.dart';
import 'package:journeywest/model/ToolInSenario.dart';
import 'package:journeywest/view/admin/scenario/ScenarioForm.dart';

class ShoppingCartService {
  var url = 'https://journeytothewestapi.azurewebsites.net/api/shoppingcart/';

  Future<List<RoleInScenario>> loadRoleInScenario(int idScenario) async {
    var response = await http.get(url+idScenario.toString());
    print(response.statusCode);
    List<RoleInScenario> list = List<RoleInScenario>();
    if(response.statusCode == 200) {
      final parsed = json.decode(response.body);
      list = parsed.map<RoleInScenario>((json) => RoleInScenario.fromJson(json)).toList();
    } else if(response.statusCode == 404) {
      list = null;
    }

    return list;
  }

  Future<bool> createRoleInScenario(List<RoleInScenarioForm> roles) async {
    var isCreated = false;

    print(jsonEncode(roles));

    Map<String,String> headers = {
      'Content-type' : 'application/json',
      'Accept': 'application/json',
    };

    var response = await http.post(
        url+"roles",
        headers: headers,
        body: jsonEncode(roles)
    );
    print(response.statusCode);
    print(response.body);
    if(response.statusCode == 204) {
      isCreated = true;
    }
    return isCreated;
  }

  Future<bool> deleteRoleInScene(int idScenario, String roleName, int idActor) async {
        var isDeleted = false;

        Map<String,String> headers = {
          'Content-type' : 'application/json',
          'Accept': 'application/json',
        };
        List<RoleInScenarioForm> list = List<RoleInScenarioForm>();
        RoleInScenarioForm deleted = RoleInScenarioForm(idActor: idActor, idScenario: idScenario, roleName: roleName);
        list.add(deleted);
        print(jsonEncode(list));
        var request = http.Request("DELETE", Uri.parse(url+"roles"));
        request.headers.addAll(headers);
        request.body = jsonEncode(list);
        final response = await request.send();
    print(response.statusCode);
    if(response.statusCode == 204) {
      isDeleted = true;
    }
    return isDeleted;

  }

  Future<List<ToolInScenario>> loadToolInScenario(int idScenario) async {

    var response = await http.get(url+"tool/"+idScenario.toString());
    print(response.statusCode);
    List<ToolInScenario> list = List<ToolInScenario>();
    if(response.statusCode == 200) {
      final parsed = json.decode(response.body);
      print(parsed);
      list = parsed.map<ToolInScenario>((json) => ToolInScenario.fromJson(json)).toList();
    } else if(response.statusCode == 404) {
      list = null;
    }
    return list;
  }

  Future<bool> createToolInScenario(List<ToolInScenarioForm> tools) async {
    var isCreated = false;

    print(jsonEncode(tools));

    Map<String,String> headers = {
      'Content-type' : 'application/json',
      'Accept': 'application/json',
    };

    var response = await http.post(
        url+"tools",
        headers: headers,
        body: jsonEncode(tools)
    );
    print(response.statusCode);
    print(response.body);
    if(response.statusCode == 204) {
      isCreated = true;
    }
    return isCreated;
  }

  Future<bool> deleteToolInScene(int idScenario, int quantity ,int idTool) async {
    var isDeleted = false;

    Map<String,String> headers = {
      'Content-type' : 'application/json',
      'Accept': 'application/json',
    };
    List<ToolInScenarioForm> list = List<ToolInScenarioForm>();
    ToolInScenarioForm deleted = ToolInScenarioForm(idTool: idTool, idScenario: idScenario, quantity: quantity);
    list.add(deleted);
    var request = http.Request("DELETE", Uri.parse(url+"tools"));
    request.headers.addAll(headers);
    request.body = jsonEncode(list);
    final response = await request.send();
    print(response.statusCode);
    if(response.statusCode == 204) {
      isDeleted = true;
    }
    return isDeleted;
  }

}