import 'package:journeywest/model/Scenario.dart';
import 'package:journeywest/service/ScenarioService.dart';
import 'package:journeywest/service_locator.dart';
import 'package:journeywest/viewmodel/BaseModel.dart';



class ScenarioEditViewModel extends BaseModel {
  ScenarioService scenarioService = locator<ScenarioService>();
  Scenario scenario;

  Future<Scenario> fetchData(Scenario scenario) async {
   this.scenario = scenario;
  }

  Future<bool> update() async {
    return scenarioService.updateScenario(scenario);
  }

}