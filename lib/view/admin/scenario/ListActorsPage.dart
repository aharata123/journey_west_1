
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:journeywest/enums/Status.dart';
import 'package:journeywest/enums/ViewState.dart';
import 'package:journeywest/view/admin/BaseView.dart';
import 'package:journeywest/view/admin/ShoppingCartPage.dart';
import 'package:journeywest/viewmodel/admin/scenario/ListActorsViewModel.dart';


class ListActorsPage extends StatelessWidget {
  final int id;
  ListActorsPage({Key key, @required this.id}) : super(key : key);

  @override
  Widget build(BuildContext context) {
    return BaseView<ListActorsViewModel>(
      builder: (context, child, model) {
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text('List of Actor participated'),
              ),
              body: FutureBuilder(
                future: model.loadRolesInScenario(id),
                builder: (context, snapshot) {
                 if(snapshot.connectionState == ConnectionState.done) {
                   if(!snapshot.hasData) {
                     return Center(
                       child: Text("This scenario don't have any actor"),
                     );
                   } else
                   return Container(
                     child: Column(
                       children: <Widget>[
                         Expanded(
                           child: ListView.builder(
                               itemCount: model.rolesInScenario.length,
                               itemBuilder: (BuildContext context, int index) {

                                   return Slidable(
                                     actionPane: SlidableBehindActionPane(),
                                     secondaryActions: <Widget>[
                                       IconSlideAction(
                                         caption: 'Edit',
                                         color: Colors.blue,
                                         icon: Icons.edit,
                                         onTap: () async {
//                                    final updated = await Navigator.push(
//                                      context,
//                                      MaterialPageRoute(builder: (context) => ScenarioEditPage(scenario: model.listForSearch[index])),
//                                    );
//                                    if(updated == Status.isUpdated) {
//                                      model.loadScenario();
//                                    }
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
                                                 title: Text('Delete ' + model.rolesInScenario[index].nameActor + " ?"),
                                                 content: Text('The item will be deleted permanently'),
                                                 actions: <Widget>[
                                                   CupertinoDialogAction(
                                                     child: Text('No'),
                                                     onPressed: Navigator.of(context).pop,
                                                   ),
                                                   CupertinoDialogAction(
                                                     child: Text('Yes'),
                                                     onPressed: () async {
                                                bool isDelete = await   model.deleteRoles(model.rolesInScenario[index].idScenario, model.rolesInScenario[index].roleName, model.rolesInScenario[index].idActor);
                                                Navigator.pop(context);
                                                if(isDelete) {
                                                  model.loadRolesInScenario(id);
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
                                                       model.rolesInScenario[index].image , width: 50, height: 50,
                                                     ),
                                                     title: Text(model.rolesInScenario[index].roleName),
                                                     subtitle: Text("Actor : " + model.rolesInScenario[index].nameActor),
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
                    MaterialPageRoute(builder: (context) => ShoppingCartPage(id: id)),
                  );
                  if(created == Status.isCreated) {
                    model.loadRolesInScenario(id);
                    model.refresh();
                  }
                },
                label: Text('Add Actor'),
                icon: Icon(Icons.add),
                backgroundColor: Colors.blue,
              ),
            );

      },
    );
  }
}