

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_beautiful_popup/main.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:journeywest/enums/Status.dart';
import 'package:journeywest/enums/ViewState.dart';
import 'package:journeywest/view/admin/BaseView.dart';
import 'package:journeywest/view/admin/actor/ActorDetailPage.dart';
import 'package:journeywest/view/admin/actor/ActorEditPage.dart';
import 'package:journeywest/view/admin/actor/ActorForm.dart';
import 'package:journeywest/viewmodel/admin/actor/ActorViewModel.dart';

class ActorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<ActorViewModel>(
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
                        onChanged: (value) {
                          model.filterSearchResults(value);
                        },
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: model.listForSearch.length,
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
                                      MaterialPageRoute(builder: (context) => ActorEditPage(actor: model.listForSearch[index])),
                                    );
                                    if(updated == Status.isUpdated) {
                                      model.load();
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
                                          title: Text('Delete ' + model.listForSearch[index].name + " ?"),
                                          content: Text('The item will be deleted permanently'),
                                          actions: <Widget>[
                                            CupertinoDialogAction(
                                              child: Text('No'),
                                              onPressed: Navigator.of(context).pop,
                                            ),
                                            CupertinoDialogAction(
                                              child: Text('Yes'),
                                              onPressed: () async {
                                                print(model.listForSearch[index].id);
                                                bool isDelete = await model.delete(model.listForSearch[index].id);
                                                Navigator.pop(context);
                                                if(isDelete) {
                                                  model.load();
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
                                           model.listForSearch[index].image , width: 50, height: 50,
                                        ),
                                              title: Text(model.listForSearch[index].name),
                                              subtitle: Text(model.listForSearch[index].description),
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
                                    content: ActorDetailPage(actor: model.listForSearch[index]),
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
                    MaterialPageRoute(builder: (context) => ActorForm()),
                  );
                  if(created == Status.isCreated) {
                    model.load();
                  }
                },
                label: Text('Add Actor'),
                icon: Icon(Icons.add),
                backgroundColor: Colors.blue,
              ),
            );
        }
      },
    );
  }

}