


import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:journeywest/model/Tool.dart';
import 'package:journeywest/view/admin/BaseView.dart';
import 'package:journeywest/viewmodel/admin/tool/ToolDetailViewModel.dart';

class ToolDetailPage extends StatelessWidget {
  final Tool tool;
  ToolDetailPage({Key key, @required this.tool}) : super(key : key);

  @override
  Widget build(BuildContext context) {
    return BaseView<ToolDetailViewModel>(
      builder: (context, child, model) {
        return Scaffold(
          body: FutureBuilder(
            future: model.fetchData(tool),
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
                              Expanded(
                                child: Container(
                                    child: Image.network(model.tool.image)
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 15),
                          Row(
                            children: <Widget>[
                              Container(
                                child: Icon(
                                    Icons.message
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
                                      model.tool.name
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
                                      model.tool.description
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
                                    Icons.attach_money
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  child: Text(
                                    'Quantity',
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
                                      model.tool.quantity.toString()
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
                                    'Date Created',
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
                                      DateFormat('dd-MM-yyyy hh:mm:ss').format(model.tool.dateCreated)
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