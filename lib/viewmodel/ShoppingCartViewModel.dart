
import 'package:journeywest/model/Actor.dart';
import 'package:journeywest/model/RoleInScenarioForm.dart';
import 'package:journeywest/service/ActorService.dart';
import 'package:journeywest/service/ShoppingCartService.dart';
import 'package:journeywest/service_locator.dart';
import 'package:journeywest/viewmodel/BaseModel.dart';

class ShoppingCartViewModel extends BaseModel {
    List<RoleInScenarioForm> roles = List<RoleInScenarioForm>();

    List<String> nameActor = List<String>();
    List<String> idActor = List<String>();

    ActorService actorService = locator<ActorService>();

    ShoppingCartService shoppingCartService = locator<ShoppingCartService>();

    ShoppingCartViewModel() {
      roles.add(RoleInScenarioForm());
      load();
    }

    void addRole() {
      roles.add(RoleInScenarioForm());
      notifyListeners();
    }

    void deleteRole(int index) {
        if(roles.length != 1) {
          roles.removeAt(index);
          notifyListeners();
        }
    }

    Future<void> load() async {
      List<Actor> actors = await actorService.loadActor();
      actors.forEach((actor) {
        nameActor.add(actor.name);
        idActor.add(actor.id.toString());
      });
    }

    Future<bool> addRoleToScenario(int idScenario) {
        roles.forEach((element) {
          element.idScenario = idScenario;
        });
       return shoppingCartService.createRoleInScenario(roles);
    }

}