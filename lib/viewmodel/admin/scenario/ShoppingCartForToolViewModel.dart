

import 'package:journeywest/model/Tool.dart';
import 'package:journeywest/model/ToolInScenarioForm.dart';
import 'package:journeywest/service/ShoppingCartService.dart';
import 'package:journeywest/service/ToolService.dart';
import 'package:journeywest/service_locator.dart';
import 'package:journeywest/viewmodel/BaseModel.dart';

class ShoppingCartForToolViewModel extends BaseModel {
  List<ToolInScenarioForm> tools = List<ToolInScenarioForm>();

  List<Tool> allTool = List<Tool>();

  ToolService toolService = locator<ToolService>();

  ShoppingCartService shoppingCartService = locator<ShoppingCartService>();


  void addToolToCart(int toolId, int quantity, int scenarioId) {

      if(quantity == 0) {
        tools.forEach((tool) {
          if(tool.idTool == toolId) {
            tools.remove(tool);
          }
        });
      } else {
        bool newTool = true;
        tools.forEach((tool) {
          if(tool.idTool == toolId) {
            tool.quantity = quantity;
            newTool = false;
          }
        });
        if(newTool) {
          tools.add(ToolInScenarioForm(idTool: toolId, quantity: quantity, idScenario: scenarioId));
        }
      }

      print(tools.length);
  }

  Future<void> load() async {
    allTool = await toolService.loadTool();
  }

  Future<bool> addToolToScenario() {
    return shoppingCartService.createToolInScenario(tools);
  }

}