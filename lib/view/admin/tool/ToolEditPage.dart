

import 'package:card_settings/card_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_beautiful_popup/main.dart';
import 'package:intl/intl.dart';
import 'package:journeywest/enums/Status.dart';
import 'package:journeywest/enums/ViewState.dart';
import 'package:journeywest/model/Tool.dart';
import 'package:journeywest/view/admin/BaseView.dart';
import 'package:journeywest/viewmodel/admin/tool/ToolEditViewModel.dart';



class ToolEditPage extends StatelessWidget {

  final Tool tool;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  ToolEditPage({Key key, @required this.tool}) : super(key : key);

  @override
  Widget build(BuildContext context) {
    return BaseView<ToolEditViewModel>(
        builder: (context, child, model) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text('Update Tool'),
            ),
            body: Stack(
                children: <Widget> [
                  FutureBuilder(
                    future: model.fetchData(tool),
                    builder: (context, snapshot) {
                      if(snapshot.connectionState == ConnectionState.done) {
                        return Column(
                          children: [
                            SizedBox(
                              height: 20.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.center,
                                  child: CircleAvatar(
                                    radius: 100,
                                    backgroundColor: Color(Colors.blue.value),
                                    child: ClipOval(
                                      child: new SizedBox(
                                        width: 180.0,
                                        height: 180.0,
                                        child: (model.image!=null)?Image.file(model.image, fit: BoxFit.fill) : Image.network(
                                          model.tool.image,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 60.0),
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.camera,
                                      size: 30.0,
                                    ),
                                    onPressed: () {
                                      model.getImage();
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Form(
                                  key: _formKey,
                                  child: CardSettings(
                                    children: <CardSettingsSection>[
                                      CardSettingsSection(
                                        header: CardSettingsHeader(
                                          color: Colors.blue,
                                          label: 'Tool',
                                        ),
                                        children: <Widget>[
                                          CardSettingsText(
                                            label: 'Name',
                                            hintText: 'Name of tool',
                                            initialValue: model.tool.name,
                                            validator: (value) {
                                              if (value == null || value.isEmpty) return 'Name is required.';
                                            },
                                            onChanged: (value) {
                                              model.tool.name = value;
                                            },
                                          ),
                                          CardSettingsParagraph(
                                            label: 'Description',
                                            hintText: 'Describe for tool',
                                            initialValue: model.tool.description,
                                            validator: (value) {
                                              if (value == null || value.isEmpty) return 'Description is required.';
                                            },
                                            onChanged: (value) {
                                              model.tool.description = value;
                                            },
                                          ),
                                          CardSettingsInt(
                                            label: 'Quantity',
                                            initialValue: model.tool.quantity,
                                            onChanged: (value) {
                                              model.tool.quantity = value;
                                            },
                                            validator: (value) {
                                              if(value == null || value < 0) return "Invalid value";
                                            },
                                          ),
                                          CardSettingsInstructions(
                                            text: 'Created at ' + DateFormat('dd-MM-yyyy hh:mm').format(model.tool.dateCreated),
                                            textColor: Colors.black,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: CardFieldLayout(<Widget>[
                                              CardSettingsButton(
                                                label: 'Save',
                                                backgroundColor: Colors.green,
                                                onPressed: () async {
                                                  if(_formKey.currentState.validate()) {
                                                    bool isUpdated = await model.update();
                                                    if(isUpdated) {
                                                      Navigator.pop(context, Status.isUpdated);
                                                    } else {
                                                      final popup = BeautifulPopup(
                                                        context: context,
                                                        template: TemplateFail,
                                                      );
                                                      popup.show(
                                                          title: 'Action failed',
                                                          content: 'Something went wrong.',
                                                          actions: [
                                                            popup.button(
                                                              label: 'Close',
                                                              onPressed: Navigator.of(context).pop,
                                                            )]);
                                                    }
                                                  }
                                                },
                                              ),
                                            ]),
                                          ),

                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                  Center(
                    child: model.state == ViewState.Busy? CircularProgressIndicator() : null,
                  ),
                ],
            ),
          );
        }
    );
  }

}