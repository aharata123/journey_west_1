

import 'package:card_settings/card_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_beautiful_popup/main.dart';
import 'package:journeywest/enums/Status.dart';
import 'package:journeywest/view/admin/BaseView.dart';
import 'package:journeywest/viewmodel/admin/tool/ToolFormViewModel.dart';


class ToolForm extends StatelessWidget {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BaseView<ToolFormViewModel>(
        builder: (context, child, model) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text('Create Tool'),
            ),
            body: Column(
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
                          "https://thumbs.dreamstime.com/b/no-image-available-icon-photo-camera-flat-vector-illustration-132483141.jpg",
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
                                hintText: 'Enter name of tool',
                                initialValue: model.tool.name,
                                validator: (value) {
                                  if (value == null || value.isEmpty) return 'Name is required.';
                                },
                                onChanged: (value) {
                                  model.tool.name = value.trim();
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
                              CardFieldLayout(<Widget>[
                                CardSettingsButton(
                                  label: 'CREATE',
                                  backgroundColor: Colors.green,
                                  onPressed: () async {
                                    if(_formKey.currentState.validate()) {
                                      bool isCreated = await model.create();
                                      if(isCreated) {
                                        Navigator.pop(context, Status.isCreated);
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
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CardSettingsButton(
                                    label: 'RESET',
                                    isDestructive: true,
                                    onPressed: () {
                                      _formKey.currentState.reset();
                                      model.reset();
                                    },
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                  ),
                                )
                              ])
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
    );
  }

}