
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:journeywest/model/RoleInScenario.dart';

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

//  Future<bool> createActor(Actor actor) async {
//    var isCreated = false;
//
//    var response = await http.post(
//        url,
//        body: actor.toMap()
//    );
//    print(response.statusCode);
//    print(response.body);
//    if(response.statusCode == 201) {
//      isCreated = true;
//    }
//    return isCreated;
//  }
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