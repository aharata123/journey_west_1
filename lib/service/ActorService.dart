
import 'dart:convert';

import 'package:journeywest/model/Actor.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ActorService {
  var url = 'https://journeytothewestapi.azurewebsites.net/api/actor/';

  Future<List<Actor>> loadActor() async {
    var response = await http.get(url);
    List<Actor> list = new List<Actor>();
    if(response.statusCode == 200) {
      final parsed = json.decode(response.body);
      list = parsed.map<Actor>((json) => Actor.fromJson(json)).toList();
    }
    return list;
  }

  Future<bool> createActor(Actor actor) async {
    var isCreated = false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final user = json.decode(prefs.get("User"));
    Map map = actor.toMap();
    map['UpdatedBy'] = user['Name'];

    var response = await http.post(
        url,
        body: map
    );
    print(response.statusCode);
    print(response.body);
    if(response.statusCode == 201) {
      isCreated = true;
    }
    return isCreated;
  }

  Future<bool> updateActor(Actor actor) async {
    var isUpdated = false;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    final user = json.decode(prefs.get("User"));

    Map<String, String> map = actor.toMap();
    map["IdActor"] = actor.id.toString();
    map['UpdatedBy'] = user['Name'];
    var response = await http.put(
        url+actor.id.toString(),
        body: map
    );
    print(response.statusCode);
    print(response.body);
    if(response.statusCode == 200) {
      isUpdated = true;
    }
    return isUpdated;
  }

  Future<bool> deleteActor(int id) async {
    var isDeleted = false;

    var response = await http.delete(
        url+id.toString()
    );
    print(response.statusCode);
    print(response.body);
    if(response.statusCode == 200) {
      isDeleted = true;
    }
    return isDeleted;
  }
  
}