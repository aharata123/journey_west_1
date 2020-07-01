
import 'package:card_settings/card_settings.dart';
import 'package:flutter/material.dart';
import 'package:journeywest/view/admin/BaseView.dart';
import 'package:journeywest/viewmodel/ScenarioFormViewModel.dart';

class ScenarioForm extends StatelessWidget {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DateTime startDate, endDate;

  @override
  Widget build(BuildContext context) {
    return BaseView<ScenarioFormViewModel>(
      builder: (context, child, model) {
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
                        hintText: 'Tên kiếp nạn',
                        initialValue: model.name,
                        validator: (value) {
                          if (value == null || value.isEmpty) return 'Name is required.';
                        },
                        onChanged: (value) {
                          model.name = value;
                        },
                      ),
                      CardSettingsText(
                        label: 'Location',
                        hintText: 'Địa điểm quay',
                        initialValue: model.location,
                        validator: (value) {
                          if (value == null || value.isEmpty) return 'Location is required.';
                        },
                        onChanged: (value) {
                          model.location = value;
                        },
                      ),
                      CardSettingsParagraph(
                        label: 'Description',
                        hintText: 'Mô tả',
                        initialValue: model.description,
                        validator: (value) {
                          if (value == null || value.isEmpty) return 'Description is required.';
                        },
                        onChanged: (value) {
                          model.description = value;
                        },
                      ),
                      CardSettingsDateTimePicker(
                        firstDate: DateTime(2019),
                        initialValue: model.startDate,
                        label: 'Start',
                        validator: (value) {
                          startDate = value;
                          return null;
                        },
                        onChanged: (value) {
                          model.startDate = value;
                        },
                      ),
                      CardSettingsDateTimePicker(
                        label: 'End',
                        initialValue: model.endDate,
                        firstDate: DateTime(2019),
                        validator: (value) {
                          endDate = value;
                          if(startDate.isAfter(endDate)) return 'Invalid date';
                        },
                        onChanged: (value) {
                          model.endDate = value;
                        },
                      ),
                      CardSettingsInt(
                        label: 'Time Record',
                        initialValue: model.timeRecord,
                        onChanged: (value) {
                          model.timeRecord = value;
                        },
                      ),
                      CardFieldLayout(<Widget>[
                        CardSettingsButton(
                          label: 'CREATE',
                          backgroundColor: Colors.green,
                          onPressed: () {
                            if(_formKey.currentState.validate()) {
                              print(model.name);
                              print(model.description);
                              print(model.startDate);
                              print(model.endDate);
                              print(model.timeRecord);
                              Navigator.pop(context);
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
      }
    );
  }
}
