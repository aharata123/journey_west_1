

import 'package:journeywest/enums/ViewState.dart';
import 'package:journeywest/model/Scenario.dart';
import 'package:journeywest/service/ScenarioService.dart';
import 'package:journeywest/service_locator.dart';
import 'BaseModel.dart';

class ScenarioViewModel extends BaseModel {
  ScenarioService scenarioService = locator<ScenarioService>();
  List<Scenario>_scenarios;
  List<Scenario> get scenarios => _scenarios;


  set scenarios(List<Scenario> value) {
    _scenarios = value;
  }

  Future<void> loadScenario() async {
    setState(ViewState.Busy);
    scenarios = await scenarioService.loadScenario();
    setState(ViewState.Retrieved);
    notifyListeners();
  }

  ScenarioViewModel() {
    loadScenario();
  }

  Future<bool> deleteScenario(int id) async {
    setState(ViewState.Busy);
    await Future.delayed(Duration(seconds: 2));
    scenarios.removeAt(id);
    setState(ViewState.Retrieved);
    notifyListeners();
    return true;
  }

}