



import 'package:journeywest/enums/ViewState.dart';
import 'package:journeywest/model/RoleInScenario.dart';
import 'package:journeywest/service/ShoppingCartService.dart';
import 'package:journeywest/service_locator.dart';
import 'package:journeywest/viewmodel/BaseModel.dart';

class ListActorsViewModel extends BaseModel {
  ShoppingCartService shoppingCartService = locator<ShoppingCartService>();
  List<RoleInScenario> rolesInScenario;



  Future<List<RoleInScenario>> loadRolesInScenario(int idScenario) async {
      rolesInScenario = await shoppingCartService.loadRoleInScenario(idScenario);
      return rolesInScenario;
    }

}