



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:journeywest/enums/Status.dart';
import 'package:journeywest/view/admin/BaseView.dart';
import 'package:journeywest/view/admin/scenario/ShoppingCartForToolPage.dart';
import 'package:journeywest/viewmodel/admin/scenario/ListToolsViewModel.dart';

class ListToolsPage extends StatelessWidget {
  final int id;
  ListToolsPage({Key key, @required this.id}) : super(key : key);

  @override
  Widget build(BuildContext context) {
    return BaseView<ListToolsViewModel>(
      builder: (context, child, model) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('List of Tools in Scenario'),
          ),
          body: FutureBuilder(
              future: model.loadToolsInScenario(id),
              builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.done) {
                  if(!snapshot.hasData) {
                    return Center(
                      child: Text("This scenario don't have any tool"),
                    );
                  } else
                    return Container(
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            child: ListView.builder(
                                itemCount: model.tools.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Slidable(
                                    actionPane: SlidableBehindActionPane(),
                                    secondaryActions: <Widget>[
//                                      IconSlideAction(
//                                        caption: 'Edit',
//                                        color: Colors.blue,
//                                        icon: Icons.edit,
//                                        onTap: () async {
////                                    final updated = await Navigator.push(
////                                      context,
////                                      MaterialPageRoute(builder: (context) => ScenarioEditPage(scenario: model.listForSearch[index])),
////                                    );
////                                    if(updated == Status.isUpdated) {
////                                      model.loadScenario();
////                                    }
//                                        },
//                                      ),
                                      IconSlideAction(
                                        caption: 'Delete',
                                        color: Colors.red,
                                        icon: Icons.delete,
                                        onTap: () {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) =>CupertinoAlertDialog(
                                                title: Text('Delete ' + model.tools[index].toolName + " ?"),
                                                content: Text('The item will be deleted permanently'),
                                                actions: <Widget>[
                                                  CupertinoDialogAction(
                                                    child: Text('No'),
                                                    onPressed: Navigator.of(context).pop,
                                                  ),
                                                  CupertinoDialogAction(
                                                    child: Text('Yes'),
                                                    onPressed: () async {
                                                      bool isDelete = await   model.deleteTool(model.tools[index].idScenario, model.tools[index].quantity, model.tools[index].idTool);
                                                      Navigator.pop(context);
                                                      if(isDelete) {
                                                        model.loadToolsInScenario(id);
                                                        model.refresh();
                                                      }
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
                                                    leading: Image.network(
                                                      model.tools[index].image , width: 50, height: 50,
                                                    ),
                                                    title: Text(model.tools[index].toolName),
                                                    subtitle: Text("Quantity : " + model.tools[index].quantity.toString()),
                                                  ),
                                                ],
                                              )
                                          )
                                      ),

                                    ),
                                  );

                                }
                            ),
                          ),
                        ],
                      ),
                    );
                } else return Center(child: CircularProgressIndicator());
              }
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () async {
              final created = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ShoppingCartForToolPage(id: id)),
              );
              if(created == Status.isCreated) {
                model.loadToolsInScenario(id);
                model.refresh();
              }
            },
            label: Text('Add Tool'),
            icon: Icon(Icons.add),
            backgroundColor: Colors.blue,
          ),
        );

      },
    );
  }
}