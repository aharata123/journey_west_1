

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:journeywest/model/Scenario.dart';
import 'package:journeywest/view/admin/BaseView.dart';
import 'package:journeywest/viewmodel/ScenarioDetailViewModel.dart';

class ScenarioDetailPage extends StatelessWidget {
  final Scenario scenario;
  ScenarioDetailPage({Key key, @required this.scenario}) : super(key : key);

  @override
  Widget build(BuildContext context) {
    return BaseView<ScenarioDetailViewModel>(
      builder: (context, child, model) {
        return Scaffold(
          body: FutureBuilder(
            future: model.fetchData(scenario),
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.done) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(30, 40, 30, 0),
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Container(
                                child: Icon(
                                    Icons.image
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  child: Text(
                                    'Name',
                                    style: TextStyle(
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Container(
                                  child: Text(
                                      model.scenario.name
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 15),
                          Row(
                            children: <Widget>[
                              Container(
                                child: Icon(
                                    Icons.location_on
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  child: Text(
                                    'Location',
                                    style: TextStyle(
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Container(
                                  child: Text(
                                      model.scenario.location
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 15),
                          Row(
                            children: <Widget>[
                              Container(
                                child: Icon(
                                    Icons.description
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  child: Text(
                                    'Description',
                                    style: TextStyle(
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Container(
                                  child: Text(
                                      model.scenario.description
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 15),
                          Row(
                            children: <Widget>[
                              Container(
                                child: Icon(
                                    Icons.date_range
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  child: Text(
                                    'Start',
                                    style: TextStyle(
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Container(
                                  child: Text(
                                      DateFormat('dd-MM-yyyy hh:mm:ss').format(model.scenario.startDate)
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 15),
                          Row(
                            children: <Widget>[
                              Container(
                                child: Icon(
                                    Icons.date_range
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  child: Text(
                                    'End',
                                    style: TextStyle(
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Container(
                                  child: Text(
                                      DateFormat('dd-MM-yyyy hh:mm:ss').format(model.scenario.endDate)
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 15),
                          Row(
                            children: <Widget>[
                              Container(
                                child: Icon(
                                    Icons.timer
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  child: Text(
                                    'Time Record',
                                    style: TextStyle(
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Container(
                                  child: Text(
                                      model.scenario.timeRecord.toString()
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        );
      },
    );
  }
}
