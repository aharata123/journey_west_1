


import 'package:card_settings/card_settings.dart';
import 'package:flutter/material.dart';
import 'package:journeywest/enums/Status.dart';
import 'package:journeywest/model/Scenario.dart';
import 'package:journeywest/view/admin/BaseView.dart';
import 'package:journeywest/viewmodel/admin/scenario/ScenarioEditViewModel.dart';

class ScenarioEditPage extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DateTime startDate, endDate;
  final Scenario scenario;

  ScenarioEditPage({Key key, @required this.scenario}) : super(key : key);

  @override
  Widget build(BuildContext context) {
    return BaseView<ScenarioEditViewModel>(
        builder: (context, child, model) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text('Scenario'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder(
                future: model.fetchData(scenario),
                builder: (context, snapshot){
                  if(snapshot.connectionState == ConnectionState.done) {
                    return Form(
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
                                  if (value == null || value.isEmpty) return 'Name is required.';
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
                                  if (value == null || value.isEmpty) return 'Location is required.';
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
                                  if (value == null || value.isEmpty) return 'Description is required.';
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
                                  if(startDate.isAfter(endDate)) return 'Invalid date';
                                },
                                onChanged: (value) {
                                  model.scenario.endDate = value;
                                },
                              ),
                              CardSettingsInt(
                                label: 'Time Record',
                                initialValue: model.scenario.timeRecord,
                                validator: (value) {
                                  if(value == null || value < 0) return "Invalid value";
                                },
                                onChanged: (value) {
                                  model.scenario.timeRecord = value;
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CardFieldLayout(<Widget>[
                                  CardSettingsButton(
                                    label: 'SAVE',
                                    backgroundColor: Colors.green,
                                    onPressed: () async {
                                      if(_formKey.currentState.validate()) {
                                        bool isUpdated = await model.update();
                                        if(isUpdated) {
                                          Navigator.pop(context, Status.isUpdated);
                                        }
                                      }
                                    },
                                  ),
                                ]),
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  }
                  else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          );
        }
    );
  }
}
