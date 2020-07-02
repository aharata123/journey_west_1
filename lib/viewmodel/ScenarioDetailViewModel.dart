import 'package:journeywest/model/Scenario.dart';

import 'BaseModel.dart';

class ScenarioDetailViewModel extends BaseModel {
  Scenario scenario;

  Future<Scenario> fetchData(int id) async {

    await Future.delayed(Duration(seconds: 2));
    if(id == 1) {
      return this.scenario = new Scenario(name: 'Scene 1', description: 'Wukong', location: 'Campuchia',
          timeRecord: 1, startDate: DateTime.now(), endDate: DateTime.now());
    } else if (id == 2) {
      return this.scenario = new Scenario(name: 'Scene 2', description: 'Sugar Increase', location: 'China',
          timeRecord: 1, startDate: DateTime.now(), endDate: DateTime.now());
    }
  }


}