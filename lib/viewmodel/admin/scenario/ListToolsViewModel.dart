
import 'package:journeywest/model/ToolInSenario.dart';
import 'package:journeywest/service/ShoppingCartService.dart';
import 'package:journeywest/service_locator.dart';
import 'package:journeywest/viewmodel/BaseModel.dart';

class ListToolsViewModel extends BaseModel {
  ShoppingCartService shoppingCartService = locator<ShoppingCartService>();
  List<ToolInScenario> tools;



  Future<List<ToolInScenario>> loadToolsInScenario(int idScenario) async {
    tools = await shoppingCartService.loadToolInScenario(idScenario);
    return tools;
  }

  void refresh() {
    notifyListeners();
  }

  Future<bool> deleteTool(int idScenario, int quantity ,int idTool) {
    return shoppingCartService.deleteToolInScene(idScenario, quantity, idTool);
  }

}