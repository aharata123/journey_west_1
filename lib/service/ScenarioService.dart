import 'package:journeywest/model/Scenario.dart';

class ScenarioService {
  Future<List<Scenario>> loadScenario() async {
    await Future.delayed(Duration(seconds: 0));
    List<Scenario> list = new List<Scenario>();
    list.add(Scenario(id: 1, name: 'Cảnh 1', description: 'Wukong ra đời'));
    list.add(Scenario(id: 2, name: 'Cảnh 2', description: 'Wukong tạch'));
    return list;
  }
}