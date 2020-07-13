

import 'package:journeywest/model/Tool.dart';
import 'package:journeywest/viewmodel/BaseModel.dart';

class ToolDetailViewModel extends BaseModel {
  Tool tool;

  Future<Tool> fetchData(Tool tool) async {
    this.tool = tool;
  }


}