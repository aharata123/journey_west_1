import 'package:journeywest/model/Scenario.dart';

class ScenarioService {
  Future<List<Scenario>> loadScenario() async {
    await Future.delayed(Duration(seconds: 1));
    List<Scenario> list = new List<Scenario>();
    list.add(Scenario(id: 1, name: 'Scene 1', description: 'Wukong is coming'));
    list.add(Scenario(id: 2, name: 'Scene 2', description: 'Wukong has been slain'));
    return list;
  }
}