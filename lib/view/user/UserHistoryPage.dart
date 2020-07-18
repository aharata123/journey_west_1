import 'package:flutter/material.dart';
import 'package:flutter_beautiful_popup/main.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:journeywest/enums/ViewState.dart';
import 'package:journeywest/view/admin/BaseView.dart';
import 'package:journeywest/view/admin/scenario/ScenarioDetailPage.dart';
import 'package:journeywest/viewmodel/user/UserHistoryViewModel.dart';

class UserHistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<UserHistoryViewModel>(
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
                                  caption: 'View file',
                                  color: Colors.blue,
                                  icon: Icons.attach_file,
                                  onTap: () async {
                                   await model.readFromURL(model.listForSearch[index].fileURL);
                                    final popup = BeautifulPopup(
                                      context: context,
                                      template: TemplateBlueRocket,
                                    );
                                    popup.show(
                                      title: "File content",
                                      content: SingleChildScrollView(
                                        child: Text(model.content),
                                      ),
                                      actions: [
                                        popup.button(
                                          label: 'Close',
                                          onPressed: Navigator.of(context).pop,
                                        ),
                                        popup.button(
                                          label: 'Download',
                                          onPressed: () async {
                                            var data = await model.downloadFile(model.content, model.listForSearch[index].fileURL);
                                            Navigator.of(context).pop();
                                            if(data == null) {
                                              Scaffold.of(context).showSnackBar(SnackBar(
                                                content: Text("Download Failed."),
                                                duration: Duration(seconds: 4),
                                              ));
                                            } else {
                                              Scaffold.of(context).showSnackBar(SnackBar(
                                                content: Text("Download Complete."),
                                                duration: Duration(seconds: 4),
                                              ));
                                            }
                                          },
                                        ),
                                      ],
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
                                    content: ScenarioDetailPage(scenario: model.listForSearch[index]),
                                    actions: [
                                      popup.button(
                                        label: 'Close',
                                        onPressed: Navigator.of(context).pop,
                                      ),
                                    ],
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
//              floatingActionButton: FloatingActionButton.extended(
//                onPressed: () async {
//                  final created = await Navigator.push(
//                    context,
//                    MaterialPageRoute(builder: (context) => ScenarioForm()),
//                  );
//                  if(created == Status.isCreated) {
//                    model.loadScenario();
//                  }
//                },
//                label: Text('Add Scenario'),
//                icon: Icon(Icons.add),
//                backgroundColor: Colors.blue,
//              ),
            );
        }
      },
    );
  }

}