import 'dart:convert';

import 'package:journeywest/model/Tool.dart';

import 'package:http/http.dart' as http;

class ToolService {
  var url = 'https://journeytothewestapi.azurewebsites.net/api/tool/';

  Future<List<Tool>> loadTool() async {
    var response = await http.get(url);
    List<Tool> list = new List<Tool>();
    if(response.statusCode == 200) {
      final parsed = json.decode(response.body);
      list = parsed.map<Tool>((json) => Tool.fromJson(json)).toList();
    }
    return list;
  }

  Future<bool> createTool(Tool tool) async {
    var isCreated = false;

    var response = await http.post(
        url,
        body: tool.toMap()
    );
    print(response.statusCode);
    print(response.body);
    if(response.statusCode == 201) {
      isCreated = true;
    }
    return isCreated;
  }

  Future<bool> updateTool(Tool tool) async {
    var isUpdated = false;

    Map<String, String> map = tool.toMap();
    map["IdTool"] = tool.id.toString();
    map["DateCreated"] = tool.dateCreated.toIso8601String();

    var response = await http.put(
        url+tool.id.toString(),
        body: map
    );
    print(response.statusCode);
    print(response.body);
    if(response.statusCode == 200) {
      isUpdated = true;
    }
    return isUpdated;
  }

  Future<bool> deleteTool(int id) async {
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