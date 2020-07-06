import 'dart:io';

import 'package:file_utils/file_utils.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:journeywest/enums/ViewState.dart';
import 'package:journeywest/model/Actor.dart';
import 'package:journeywest/service/ActorService.dart';

import 'package:journeywest/service_locator.dart';
import 'package:journeywest/viewmodel/BaseModel.dart';

class ActorEditViewModel extends BaseModel {
  ActorService actorService = locator<ActorService>();
  Actor actor;
  File image;

  Future<Actor> fetchData(Actor actor) async {
    this.actor = actor;
  }

  Future<bool> update() async {
    if(image != null) {
      this.actor.image = await uploadToFireStore();
    }
    return actorService.updateActor(actor);
  }

  Future getImage() async {
    final pickedImg = await ImagePicker().getImage(source: ImageSource.gallery);
    if(pickedImg != null) {
      image = File(pickedImg.path);
    }
    notifyListeners();
  }

  Future<String> uploadToFireStore() async {
    String filename= FileUtils.basename(image.path);
    StorageReference ref = FirebaseStorage.instance.ref().child(filename);
    StorageUploadTask uploadTask = ref.putFile(image);
    var url = await (await uploadTask.onComplete).ref.getDownloadURL();
    return url.toString();
  }

}