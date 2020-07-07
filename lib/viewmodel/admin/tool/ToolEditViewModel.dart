

import 'dart:io';

import 'package:file_utils/file_utils.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:journeywest/enums/ViewState.dart';
import 'package:journeywest/model/Tool.dart';
import 'package:journeywest/service/ToolService.dart';
import 'package:journeywest/service_locator.dart';
import 'package:journeywest/viewmodel/BaseModel.dart';

class ToolEditViewModel extends BaseModel {
  ToolService toolService = locator<ToolService>();
  Tool tool;
  File image;

  Future<Tool> fetchData(Tool tool) async {
    this.tool = tool;
  }

  Future<bool> update() async {
    setState(ViewState.Busy);
    if(image != null) {
      try {
        StorageReference photoRef = await FirebaseStorage().getReferenceFromUrl(this.tool.image);
        if(photoRef != null) {
          photoRef.delete();
        }
      } catch (Exception) {
        print(Exception);
      }
      this.tool.image = await uploadToFireStore();
    }
    return toolService.updateTool(tool);
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