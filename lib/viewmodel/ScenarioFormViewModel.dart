

import 'package:journeywest/enums/ViewState.dart';
import 'package:journeywest/model/Scenario.dart';
import 'package:journeywest/service/ScenarioService.dart';

import '../service_locator.dart';
import 'BaseModel.dart';

class ScenarioFormViewModel extends BaseModel {
  ScenarioService scenarioService = locator<ScenarioService>();
  Scenario scenario;

  ScenarioFormViewModel() {
    scenario = Scenario();
    reset();
  }

  void reset() {
    this.scenario.name = '';
    this.scenario.description = '';
    this.scenario.location = '';
    this.scenario.timeRecord = 0;
    this.scenario.startDate = DateTime.now();
    this.scenario.endDate = DateTime.now();
    notifyListeners();
  }

  Future<bool> create() {
   return scenarioService.createScenario(scenario);
  }

}



