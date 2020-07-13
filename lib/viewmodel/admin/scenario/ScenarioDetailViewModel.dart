import 'package:firebase_storage/firebase_storage.dart';
import 'package:journeywest/model/Scenario.dart';
import 'package:journeywest/viewmodel/BaseModel.dart';


class ScenarioDetailViewModel extends BaseModel {
  Scenario scenario;
  String fileName;
  Future<Scenario> fetchData(Scenario scenario) async {
    this.scenario = scenario;
    StorageReference ref = await FirebaseStorage.instance.getReferenceFromUrl(this.scenario.fileURL);
    this.fileName = await ref.getName();
  }


}