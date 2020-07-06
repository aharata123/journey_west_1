

import 'package:journeywest/enums/ViewState.dart';
import 'package:journeywest/model/Actor.dart';
import 'package:journeywest/service/ActorService.dart';
import 'package:journeywest/service_locator.dart';
import 'package:journeywest/viewmodel/BaseModel.dart';

class ActorViewModel extends BaseModel {
  ActorService actorService = locator<ActorService>();
  List<Actor> actors;
  List<Actor> listForSearch = List<Actor>();


  Future<void> load() async {
    setState(ViewState.Busy);
    actors = await actorService.loadActor();
    filterSearchResults("");
    setState(ViewState.Retrieved);
  }

  ActorViewModel() {
   load();
  }

  Future<bool> delete(int id) async {
    setState(ViewState.Busy);
    bool isDelete = await actorService.deleteActor(id);
    setState(ViewState.Retrieved);
    return isDelete;
  }

  void filterSearchResults(String search) {
    listForSearch.clear();
    if(search.isNotEmpty) {
      actors.forEach((actor) {
        if(actor.name.toLowerCase().contains(search.toLowerCase())) {
          listForSearch.add(actor);
        }
      });
    } else {
      actors.forEach((actor) {
        listForSearch.add(actor);
      });
    }
    notifyListeners();
  }

}