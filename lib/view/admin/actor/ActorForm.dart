

import 'package:card_settings/card_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_beautiful_popup/main.dart';
import 'package:journeywest/enums/Status.dart';
import 'package:journeywest/view/admin/BaseView.dart';
import 'package:journeywest/viewmodel/admin/actor/ActorFormViewModel.dart';

class ActorForm extends StatelessWidget {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BaseView<ActorFormViewModel>(
        builder: (context, child, model) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text('Create Actor'),
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
                              label: 'Actor',
                            ),
                            children: <Widget>[
                              CardSettingsText(
                                label: 'Username',
                                hintText: 'Enter username',
                                initialValue: model.actor.username,
                                validator: (value) {
                                  if (value == null || value.isEmpty) return 'Username is required.';
                                },
                                onChanged: (value) {
                                  model.actor.username = value.trim();
                                },
                              ),
                              CardSettingsPassword(
                                label: 'Password',
                                hintText: 'Enter your password',
                                initialValue: model.actor.password,
                                validator: (value) {
                                  if (value == null || value.isEmpty) return 'Password is required.';
                                },
                                onChanged: (value) {
                                  model.actor.password = value;
                                },
                              ),
                              CardSettingsText(
                                label: 'Name',
                                hintText: 'Name of actor',
                                initialValue: model.actor.name,
                                validator: (value) {
                                  if (value == null || value.isEmpty) return 'Name is required.';
                                },
                                onChanged: (value) {
                                  model.actor.name = value;
                                },
                              ),
                              CardSettingsText(
                                label: 'Email',
                                hintText: 'Email of actor',
                                initialValue: model.actor.email,
                                validator: (value) {
                                  if (value == null || value.isEmpty) return 'Email is required.';
                                },
                                onChanged: (value) {
                                  model.actor.email = value;
                                },
                              ),
                              CardSettingsText(
                                label: 'Phone Number',
                                hintText: 'Phone number of actor',
                                initialValue: model.actor.phone,
                                validator: (value) {
                                  Pattern pattern = r'[0-9]{10}';
                                  RegExp regex = RegExp(pattern);
                                  if(!regex.hasMatch(value)) return 'Invalid';
                                },
                                onChanged: (value) {
                                  model.actor.phone = value;
                                },
                              ),
                              CardSettingsParagraph(
                                label: 'Description',
                                hintText: 'Describe for actor',
                                initialValue: model.actor.description,
                                validator: (value) {
                                  if (value == null || value.isEmpty) return 'Description is required.';
                                },
                                onChanged: (value) {
                                  model.actor.description = value;

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
                                            content: 'Something went wrong. Check your username',
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