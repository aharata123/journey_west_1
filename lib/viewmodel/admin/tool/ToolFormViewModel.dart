



import 'dart:io';

import 'package:file_utils/file_utils.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:journeywest/model/Tool.dart';
import 'package:journeywest/service/ToolService.dart';
import 'package:journeywest/service_locator.dart';
import 'package:journeywest/viewmodel/BaseModel.dart';

class ToolFormViewModel extends BaseModel {
  String urlDefault = 'https://thumbs.dreamstime.com/b/no-image-available-icon-photo-camera-flat-vector-illustration-132483141.jpg';
  File image;
  Tool tool;
  ToolService toolService = locator<ToolService>();

  ToolFormViewModel() {
    tool = Tool();
    reset();
  }

  void reset() {
    this.tool.name = '';
    this.tool.description = '';
    this.tool.quantity = 0;
    this.tool.image = urlDefault;
    image = null;
    notifyListeners();
  }

  Future<bool> create() async {
    if(image != null) {
      this.tool.image = await uploadToFireStore();
    }
    return toolService.createTool(tool);
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