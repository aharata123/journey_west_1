import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_beautiful_popup/main.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:journeywest/enums/Status.dart';
import 'package:journeywest/enums/ViewState.dart';
import 'package:journeywest/view/admin/BaseView.dart';
import 'package:journeywest/view/admin/ScenarioDetailPage.dart';
import 'package:journeywest/view/admin/ScenarioEditPage.dart';
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
              body: Container(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextField(
                        decoration: InputDecoration(
                            labelText: "Search",
                            hintText: "Search",
                            prefixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(20)))),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: model.scenarios.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Slidable(
                              actionPane: SlidableBehindActionPane(),
                              secondaryActions: <Widget>[
                                IconSlideAction(
                                  caption: 'Edit',
                                  color: Colors.blue,
                                  icon: Icons.edit,
                                  onTap: () async {
                                   final updated = await Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => ScenarioEditPage(id: model.scenarios[index].id)),
                                    );
                                  if(updated == Status.isUpdated) {
                                    model.loadScenario();
                                  }
                                  },
                                ),
                                IconSlideAction(
                                  caption: 'Delete',
                                  color: Colors.red,
                                  icon: Icons.delete,
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>CupertinoAlertDialog(
                                          title: Text('Delete ' + model.scenarios[index].name + " ?"),
                                          content: Text('The item will be deleted permanently'),
                                          actions: <Widget>[
                                            CupertinoDialogAction(
                                              child: Text('No'),
                                              onPressed: Navigator.of(context).pop,
                                            ),
                                            CupertinoDialogAction(
                                              child: Text('Yes'),
                                              onPressed: () {
                                                print(model.scenarios[index].id);
                                                model.deleteScenario(model.scenarios[index].id-1);
                                                Navigator.pop(context, true);
                                              },
                                            )
                                          ],
                                        )
                                    );
                                  },
                                ),
                              ],
                              child: new GestureDetector(
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
                                  final popup = BeautifulPopup(
                                    context: context,
                                    template: TemplateBlueRocket,
                                  );
                                  popup.show(
                                    title: 'Scenario Info',
                                    content: ScenarioDetailPage(id: model.scenarios[index].id),
                                    actions: [
                                      popup.button(
                                        label: 'Close',
                                        onPressed: Navigator.of(context).pop,
                                      ),
                                    ],
                                    // bool barrierDismissible = false,
                                    // Widget close,
                                  );
                                },
                              ),
                            );
                          }
                      ),
                    ),
                  ],
                ),
              ),
              floatingActionButton: FloatingActionButton.extended(
                onPressed: () async {
                final created = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ScenarioForm()),
                  );
                  if(created == Status.isCreated) {
                    model.loadScenario();
                  }
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




