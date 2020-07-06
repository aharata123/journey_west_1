

import 'dart:io';

import 'package:file_utils/file_utils.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:journeywest/model/Actor.dart';
import 'package:journeywest/service/ActorService.dart';
import 'package:journeywest/service_locator.dart';
import 'package:journeywest/viewmodel/BaseModel.dart';

class ActorFormViewModel extends BaseModel {
  String urlDefault = 'https://thumbs.dreamstime.com/b/no-image-available-icon-photo-camera-flat-vector-illustration-132483141.jpg';
  File image;
  Actor actor;
  ActorService actorService = locator<ActorService>();

  ActorFormViewModel() {
    actor = Actor();
    reset();
  }

  void reset() {
    this.actor.name = '';
    this.actor.description = '';
    this.actor.username = '';
    this.actor.phone = "000";
    this.actor.email = '';
    this.actor.image = '';
    this.actor.image = urlDefault;
    image = null;
    notifyListeners();
  }

  Future<bool> create() async {
    if(image != null) {
      this.actor.image = await uploadToFireStore();
    }
    return actorService.createActor(actor);
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