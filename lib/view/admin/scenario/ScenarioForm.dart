import 'dart:io';

import 'package:card_settings/card_settings.dart';
import 'package:file_picker/file_picker.dart';
import 'package:file_picker_cross/file_picker_cross.dart';
import 'package:flutter/material.dart';
import 'package:flutter_beautiful_popup/main.dart';
import 'package:journeywest/enums/Status.dart';
import 'package:journeywest/view/admin/BaseView.dart';
import 'package:journeywest/viewmodel/admin/scenario/ScenarioFormViewModel.dart';

class ScenarioForm extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DateTime startDate, endDate;

  @override
  Widget build(BuildContext context) {
    return BaseView<ScenarioFormViewModel>(builder: (context, child, model) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Create Scenario'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: CardSettings(
              children: <CardSettingsSection>[
                CardSettingsSection(
                  header: CardSettingsHeader(
                    color: Colors.blue,
                    label: 'Scenario',
                  ),
                  children: <Widget>[
                    CardSettingsText(
                      label: 'Name',
                      hintText: 'Name of scene',
                      initialValue: model.scenario.name,
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return 'Name is required.';
                      },
                      onChanged: (value) {
                        model.scenario.name = value;
                      },
                    ),
                    CardSettingsText(
                      label: 'Location',
                      hintText: 'Take place in ?',
                      initialValue: model.scenario.location,
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return 'Location is required.';
                      },
                      onChanged: (value) {
                        model.scenario.location = value;
                      },
                    ),
                    CardSettingsParagraph(
                      label: 'Description',
                      hintText: 'Describe for scene',
                      initialValue: model.scenario.description,
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return 'Description is required.';
                      },
                      onChanged: (value) {
                        model.scenario.description = value;
                      },
                    ),
                    CardSettingsDateTimePicker(
                      firstDate: DateTime(2019),
                      initialValue: model.scenario.startDate,
                      label: 'Start',
                      validator: (value) {
                        startDate = value;
                        return null;
                      },
                      onChanged: (value) {
                        model.scenario.startDate = value;
                      },
                    ),
                    CardSettingsDateTimePicker(
                      label: 'End',
                      initialValue: model.scenario.endDate,
                      firstDate: DateTime(2019),
                      validator: (value) {
                        endDate = value;
                        if (startDate.isAfter(endDate)) return 'Invalid date';
                      },
                      onChanged: (value) {
                        model.scenario.endDate = value;
                      },
                    ),
                    CardSettingsInt(
                      label: 'Time Record',
                      initialValue: model.scenario.timeRecord,
                      onChanged: (value) {
                        model.scenario.timeRecord = value;
                      },
                      validator: (value) {
                        if (value == null || value < 0) return "Invalid value";
                      },
                    ),
                    ListTile(
                        leading:
                            const Icon(Icons.attach_file, color: Colors.black),
                        title: new InputDecorator(
                          decoration: InputDecoration(
                            labelText: 'File name',
                          ),
                          child: InkWell(
                            onTap: () async {
                              model.getFile();
                            },
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Expanded(child: new Text(model.scenario.fileURL)),
                              ],
                            ),
                          ),
                        )),
                    CardFieldLayout(<Widget>[
                      CardSettingsButton(
                        label: 'CREATE',
                        backgroundColor: Colors.green,
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            bool isCreated = await model.create();
                            if (isCreated) {
                              Navigator.pop(context, Status.isCreated);
                            } else {
                              final popup = BeautifulPopup(
                                context: context,
                                template: TemplateFail,
                              );
                              popup.show(
                                title: 'Failed',
                                content: 'Something went wrong. Check your file or internet connection',
                                actions: [
                                  popup.button(
                                    label: 'Close',
                                    onPressed: Navigator.of(context).pop,
                                  ),
                                ],
                                // bool barrierDismissible = false,
                                // Widget close,
                              );
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
      );
    });
  }
}
