import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:journeywest/enums/ViewState.dart';
import 'package:journeywest/view/admin/BaseView.dart';
import 'package:journeywest/view/admin/ScenarioForm.dart';
import 'package:journeywest/viewmodel/ScenarioViewModel.dart';

class ScenarioPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<ScenarioViewModel>(
        builder: (context, child, model) {
          switch(model.state) {
            case ViewState.Busy:
              return CircularProgressIndicator();
            case ViewState.Retrieved:
            default:
            return Scaffold(
              body: new ListView.builder(
                  itemCount: model.scenarios.length,
                  itemBuilder: (BuildContext context, int index) {
                    return new GestureDetector(
                      child: new ListTile(
                          title: new Card(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  new ListTile(
                                    leading: Icon(Icons.image, size: 50),
                                    title: Text(model.scenarios[index].name),
                                    subtitle: Text(model.scenarios[index].description),
                                  ),
                                ],
                              )
                          )
                      ),
                      onTap: () {
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            child: new CupertinoAlertDialog(
                              title: new Column(
                                children: <Widget>[
                                  new Text("Listview"),
                                  new Icon(
                                    Icons.favorite,
                                    color: Colors.green,
                                  )
                                ],
                              ),
                              content: new Text("Selected Item $index"),
                              actions: <Widget>[
                                new FlatButton(onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                    child: new Text("OK")
                                )
                              ],
                            )
                        );
                      },
                    );
                  }
              ),
              floatingActionButton: FloatingActionButton.extended(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ScenarioForm()),
                  );
                },
                label: Text('Add Scenario'),
                icon: Icon(Icons.add),
                backgroundColor: Colors.blue,
              ),
            );
          }
        },
    );
  }

}




