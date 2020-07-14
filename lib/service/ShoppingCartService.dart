
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:journeywest/model/RoleInScenario.dart';
import 'package:journeywest/model/RoleInScenarioForm.dart';
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
//
//  Future<bool> updateActor(Actor actor) async {
//    var isUpdated = false;
//
//    Map<String, String> map = actor.toMap();
//    map["IdActor"] = actor.id.toString();
//
//    var response = await http.put(
//        url+actor.id.toString(),
//        body: map
//    );
//    print(response.statusCode);
//    print(response.body);
//    if(response.statusCode == 200) {
//      isUpdated = true;
//    }
//    return isUpdated;
//  }
//
//  Future<bool> deleteActor(int id) async {
//    var isDeleted = false;
//
//    var response = await http.delete(
//        url+id.toString()
//    );
//    print(response.statusCode);
//    print(response.body);
//    if(response.statusCode == 200) {
//      isDeleted = true;
//    }
//    return isDeleted;
//  }

}