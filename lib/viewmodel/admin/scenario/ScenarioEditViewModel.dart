import 'dart:io';

import 'package:file_utils/file_utils.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';
import 'package:journeywest/model/Scenario.dart';
import 'package:journeywest/service/ScenarioService.dart';
import 'package:journeywest/service_locator.dart';
import 'package:journeywest/viewmodel/BaseModel.dart';
import 'package:file_picker/file_picker.dart';


class ScenarioEditViewModel extends BaseModel {
  ScenarioService scenarioService = locator<ScenarioService>();
  Scenario scenario;
  File file;
  String fileName;

  Future<Scenario> fetchData(Scenario scenario) async {
    if(file == null) {
      this.scenario = scenario;
      StorageReference ref = await FirebaseStorage.instance.getReferenceFromUrl(this.scenario.fileURL);
      this.fileName = await ref.getName();
    } else {
      this.scenario = scenario;
    }
  }


  Future<bool> update() async {
    if(file != null) {
      try {
        StorageReference photoRef = await FirebaseStorage().getReferenceFromUrl(this.scenario.fileURL);
        if(photoRef != null) {
          photoRef.delete();
        }
      } catch (Exception) {
        print(Exception);
      }
      this.scenario.fileURL = await uploadToFireStore();
    }
    return scenarioService.updateScenario(scenario);
  }

  Future<void> getFile() async {
    file = await FilePicker.getFile();
    if(file != null) {
       this.fileName = FileUtils.basename(file.path);
    }
    notifyListeners();
  }

  Future<String> uploadToFireStore() async {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd-MM-yyyy–HH-mm-ss').format(now);
    String filename= formattedDate+"-"+FileUtils.basename(file.path);
    StorageReference ref = FirebaseStorage.instance.ref().child(filename);
    StorageUploadTask uploadTask = ref.putFile(file);
    var url = await (await uploadTask.onComplete).ref.getDownloadURL();
    return url.toString();
  }

}