



import 'package:journeywest/enums/ViewState.dart';
import 'package:journeywest/model/Tool.dart';
import 'package:journeywest/service/ToolService.dart';
import 'package:journeywest/service_locator.dart';
import 'package:journeywest/viewmodel/BaseModel.dart';

class ToolViewModel extends BaseModel {
  ToolService toolService = locator<ToolService>();
  List<Tool> tools;
  List<Tool> listForSearch = List<Tool>();


  Future<void> load() async {
    setState(ViewState.Busy);
    tools = await toolService.loadTool();
    filterSearchResults("");
    setState(ViewState.Retrieved);
  }

  ToolViewModel() {
   load();
  }

  Future<bool> delete(int id) async {
    setState(ViewState.Busy);
    bool isDelete = await toolService.deleteTool(id);
    setState(ViewState.Retrieved);
    return isDelete;
  }

  void filterSearchResults(String search) {
    listForSearch.clear();
    if(search.isNotEmpty) {
      tools.forEach((tool) {
        if(tool.name.toLowerCase().contains(search.toLowerCase())) {
          listForSearch.add(tool);
        }
      });
    } else {
      tools.forEach((tool) {
        listForSearch.add(tool);
      });
    }
    notifyListeners();
  }

}