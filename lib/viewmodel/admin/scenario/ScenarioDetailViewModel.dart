import 'package:journeywest/model/Scenario.dart';
import 'package:journeywest/viewmodel/BaseModel.dart';


class ScenarioDetailViewModel extends BaseModel {
  Scenario scenario;

  Future<Scenario> fetchData(Scenario scenario) async {
    this.scenario = scenario;
  }


}