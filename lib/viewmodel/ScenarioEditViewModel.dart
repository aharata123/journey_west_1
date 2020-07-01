import 'package:journeywest/model/Scenario.dart';

import 'BaseModel.dart';

class ScenarioEditViewModel extends BaseModel {
  Scenario scenario;

  Future<Scenario> fetchData(int id) async {

    await Future.delayed(Duration(seconds: 2));
    if(id == 1) {
     return this.scenario = new Scenario(name: 'Cảnh 1', description: 'Ngộ Không', location: 'Campuchia',
          timeRecord: 1, startDate: DateTime.now(), endDate: DateTime.now());
    } else if (id == 2) {
     return this.scenario = new Scenario(name: 'Cảnh 2', description: 'Đường Tăng', location: 'China',
          timeRecord: 1, startDate: DateTime.now(), endDate: DateTime.now());
    }
  }

}