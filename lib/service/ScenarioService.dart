import 'dart:convert';
import 'package:journeywest/model/Scenario.dart';
import 'package:http/http.dart' as http;

class ScenarioService {
  var url = 'https://journeytothewestapi.azurewebsites.net/api/scenario/';

  Future<List<Scenario>> loadScenario() async {
    var response = await http.get(url);
    List<Scenario> list = new List<Scenario>();
    if(response.statusCode == 200) {
      final parsed = json.decode(response.body);
      list = parsed.map<Scenario>((json) => Scenario.fromJson(json)).toList();
    }
    return list;
  }

  Future<bool> createScenario(Scenario scenario) async {
      var isCreated = false;

      var response = await http.post(
        url,
        body: scenario.toMap()
      );
      print(response.statusCode);
      print(response.body);
      if(response.statusCode == 201) {
        isCreated = true;
      }
      return isCreated;
  }

  Future<bool> updateScenario(Scenario scenario) async {
    var isUpdated = false;

    Map<String, String> map = scenario.toMap();
    map["IdScenario"] = scenario.id.toString();

    var response = await http.put(
        url+scenario.id.toString(),
        body: map
    );
    print(response.statusCode);
    print(response.body);
    if(response.statusCode == 200) {
      isUpdated = true;
    }
    return isUpdated;
  }

  Future<bool> deleteScenario(int id) async {
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