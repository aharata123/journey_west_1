

import 'dart:io';

import 'package:file_picker/file_picker.dart';

import 'package:file_utils/file_utils.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:journeywest/model/Scenario.dart';
import 'package:journeywest/service/ScenarioService.dart';
import 'package:journeywest/service_locator.dart';
import 'package:journeywest/viewmodel/BaseModel.dart';

class ScenarioFormViewModel extends BaseModel {
  ScenarioService scenarioService = locator<ScenarioService>();
  Scenario scenario;
  File file;

  ScenarioFormViewModel() {
    scenario = Scenario();
    reset();
  }

  void reset() {
    this.scenario.fileURL = '';
    this.scenario.name = '';
    this.scenario.description = '';
    this.scenario.location = '';
    this.scenario.timeRecord = 0;
    this.scenario.startDate = DateTime.now();
    this.scenario.endDate = DateTime.now();
    notifyListeners();
  }

  Future<bool> create() async {
    if(this.scenario.fileURL == '') {
      return Future<bool>.value(false);
    } else {
      this.scenario.fileURL = await uploadToFireStore();
      return scenarioService.createScenario(scenario);
    }

  }

  Future<void> getFile() async {
    file = await FilePicker.getFile();
    if(file != null) {
      this.scenario.fileURL = FileUtils.basename(file.path);
    }
    notifyListeners();
  }

  Future<String> uploadToFireStore() async {
    String filename= FileUtils.basename(file.path);
    StorageReference ref = FirebaseStorage.instance.ref().child(filename);
    StorageUploadTask uploadTask = ref.putFile(file);
    var url = await (await uploadTask.onComplete).ref.getDownloadURL();
    return url.toString();
  }

}



