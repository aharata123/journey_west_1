import 'dart:io';

import 'package:ext_storage/ext_storage.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:journeywest/enums/ViewState.dart';
import 'package:journeywest/model/Scenario.dart';
import 'package:journeywest/service/ScenarioService.dart';
import 'package:journeywest/service_locator.dart';
import 'package:journeywest/viewmodel/BaseModel.dart';
import 'package:permission_handler/permission_handler.dart';

class UserHistoryViewModel extends BaseModel {
  ScenarioService scenarioService = locator<ScenarioService>();
  List<Scenario> scenarios;
  List<Scenario> listForSearch = List<Scenario>();
  String content;

  Future<void> loadHistory() async {
    setState(ViewState.Busy);
    scenarios = await scenarioService.loadHistory();
    filterSearchResults("");
    setState(ViewState.Retrieved);
  }

  UserHistoryViewModel() {
    loadHistory();
  }

  void filterSearchResults(String search) {
    listForSearch.clear();
    if(search.isNotEmpty) {
      scenarios.forEach((scenario) {
        if(scenario.name.toLowerCase().contains(search.toLowerCase())) {
          listForSearch.add(scenario);
        }
      });
    } else {
      scenarios.forEach((scenario) {
        listForSearch.add(scenario);
      });
    }
    notifyListeners();
  }

  Future<void> readFromURL(String url) async {
       content = await scenarioService.readFromURL(url);
  }


  Future<File> downloadFile(String content, String url) async {
    final path = await ExtStorage.getExternalStoragePublicDirectory(ExtStorage.DIRECTORY_DOWNLOADS);
    StorageReference ref = await FirebaseStorage.instance.getReferenceFromUrl(url);
    var fileName = await ref.getName();
    File file = File('$path/'+fileName);
    print('$path/'+fileName);
    if(await Permission.storage.request().isGranted) {
      return file.writeAsString(content);
    } else return null;
  }

}