

import 'BaseModel.dart';

class ScenarioFormViewModel extends BaseModel {
  String name, description, location;
  int timeRecord;
  DateTime startDate, endDate;

  ScenarioFormViewModel() {
    this.timeRecord = 0;
    this.startDate = DateTime.now();
    this.endDate = DateTime.now();
  }


}



