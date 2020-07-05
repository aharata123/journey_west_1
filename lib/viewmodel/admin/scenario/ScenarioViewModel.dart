import 'package:journeywest/enums/ViewState.dart';
import 'package:journeywest/model/Scenario.dart';
import 'package:journeywest/service/ScenarioService.dart';
import 'package:journeywest/service_locator.dart';
import 'package:journeywest/viewmodel/BaseModel.dart';

class ScenarioViewModel extends BaseModel {
  ScenarioService scenarioService = locator<ScenarioService>();
  List<Scenario> scenarios;
  List<Scenario> listForSearch = List<Scenario>();


  Future<void> loadScenario() async {
    setState(ViewState.Busy);
    scenarios = await scenarioService.loadScenario();
    filterSearchResults("");
    setState(ViewState.Retrieved);
  }

  ScenarioViewModel() {
    loadScenario();
  }

  Future<bool> deleteScenario(int id) async {
    setState(ViewState.Busy);
    bool isDelete = await scenarioService.deleteScenario(id);
    setState(ViewState.Retrieved);
    return isDelete;
  }

  void filterSearchResults(String search) {
    listForSearch.clear();
    if(search.isNotEmpty) {
      scenarios.forEach((scenario) {
        if(scenario.name.toLowerCase().contains(search.toLowerCase())) {
          listForSearch.add(scenario);
        }
      });
    } else {
      scenarios.forEach((scenario) {
        listForSearch.add(scenario);
      });
    }
    notifyListeners();
  }

}