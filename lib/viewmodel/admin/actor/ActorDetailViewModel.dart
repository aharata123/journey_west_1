

import 'package:journeywest/model/Actor.dart';
import 'package:journeywest/viewmodel/BaseModel.dart';

class ActorDetailViewModel extends BaseModel {
  Actor actor;

  Future<Actor> fetchData(Actor actor) async {
    this.actor = actor;
  }


}