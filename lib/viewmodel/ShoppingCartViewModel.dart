
import 'package:journeywest/model/Actor.dart';
import 'package:journeywest/model/RoleInScenario.dart';
import 'package:journeywest/service/ActorService.dart';
import 'package:journeywest/service_locator.dart';
import 'package:journeywest/viewmodel/BaseModel.dart';

class ShoppingCartViewModel extends BaseModel {
    List<RoleInScenario> roles = List<RoleInScenario>();

    List<String> nameActor = List<String>();
    List<String> idActor = List<String>();

    ActorService actorService = locator<ActorService>();

    ShoppingCartViewModel() {
      roles.add(RoleInScenario());
      load();
    }

    void addRole() {
      roles.add(RoleInScenario());
      notifyListeners();
    }

    void deleteRole(int index) {
        roles.removeAt(index);
    }

    Future<void> load() async {
      List<Actor> actors = await actorService.loadActor();
      actors.forEach((actor) {
        nameActor.add(actor.name);
        idActor.add(actor.id.toString());
      });
    }

    void addRoleToScenario(int idScenario) {
        roles.forEach((element) {
          element.idScenario = idScenario;
        });

        roles.forEach((element) {
          print(element.idScenario.toString() +"--"+ element.roleName +"--" + element.idActor.toString());
        });
    }

}