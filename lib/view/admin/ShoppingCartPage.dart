import 'package:card_settings/card_settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:journeywest/viewmodel/ShoppingCartViewModel.dart';

import 'BaseView.dart';

class ShoppingCartPage extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final int id;
  final String name;
  ShoppingCartPage({Key key, @required this.id, @required this.name}) : super(key : key);

  @override
  Widget build(BuildContext context) {
    return BaseView<ShoppingCartViewModel>(
        builder: (context, child, model) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text('Shopping Cart'),
            ),
            body: Column(
              children: <Widget>[
                Flexible(
                  child: Form(
                    key: _formKey,
                    child: CardSettings(
                      children: <CardSettingsSection>[
                        CardSettingsSection(
                          header: CardSettingsHeader(
                            color: Colors.blue,
                            label: 'Role',
                          ),
                          children: <Widget>[
                            ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: model.roles.length,
                              itemBuilder: (context, index) {
                                return Dismissible(
                                  key: Key(index.toString()),
                                  child: Container(
                                    child: Column(
                                      children: [
                                        CardSettingsText(
                                          label: "Role",
                                          initialValue: "",
                                          hintText: "Name of Role",
                                          onChanged: (value) {
                                            model.roles[index].roleName = value;
                                          },
                                          validator: (value) {
                                            if (value == null || value.isEmpty) return 'Name is required.';
                                          },
                                        ),
                                        CardSettingsListPicker(
                                          options: model.nameActor,
                                          values: model.idActor,
                                          label: "Actor",
                                          onChanged: (value) {
                                            model.roles[index].idActor = int.parse(value);
                                          },
                                          validator: (value) {
                                            if (value == null || value.isEmpty) return 'Actor is required.';
                                          },
                                        ),
                                        SizedBox(height: 20),
                                    
                                      ],
                                    ),
                                  ),
                                  onDismissed: (direction) {
                                    model.deleteRole(index);
                                  },
                                );
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CardFieldLayout(<Widget>[
                                CardSettingsButton(
                                  label: 'Save',
                                  backgroundColor: Colors.green,
                                  onPressed: () async {
                                    if(_formKey.currentState.validate()) {
                                      model.addRoleToScenario(id);
//                                      bool isUpdated = await model.update();
//                                      if(isUpdated) {
//                                        Navigator.pop(context, Status.isUpdated);
//                                      } else {
//                                        final popup = BeautifulPopup(
//                                          context: context,
//                                          template: TemplateFail,
//                                        );
//                                        popup.show(
//                                            title: 'Action failed',
//                                            content: 'Something went wrong.',
//                                            actions: [
//                                              popup.button(
//                                                label: 'Close',
//                                                onPressed: Navigator.of(context).pop,
//                                              )]);
//                                      }
                                    }
                                  },
                                ),
                              ]),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            floatingActionButton: SpeedDial(
              // both default to 16
              marginRight: 18,
              marginBottom: 20,
              animatedIcon: AnimatedIcons.menu_close,
              animatedIconTheme: IconThemeData(size: 22.0),
              // this is ignored if animatedIcon is non null
              // child: Icon(Icons.add),
              visible: true,
              // If true user is forced to close dial manually
              // by tapping main button and overlay is not rendered.
              closeManually: false,
              curve: Curves.bounceIn,
              overlayColor: Colors.black,
              overlayOpacity: 0.5,
              onOpen: () => print('OPENING DIAL'),
              onClose: () => print('DIAL CLOSED'),
              tooltip: 'Speed Dial',
              heroTag: 'speed-dial-hero-tag',
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              elevation: 8.0,
              shape: CircleBorder(),
              children: [
                SpeedDialChild(
                    child: Icon(Icons.accessibility),
                    backgroundColor: Colors.blue,
                    label: 'Add Role',
                    labelStyle: TextStyle(fontSize: 18.0),
                    onTap: () => model.addRole()
                ),
                SpeedDialChild(
                  child: Icon(Icons.brush),
                  backgroundColor: Colors.blue,
                  label: 'Add Tool',
                  labelStyle: TextStyle(fontSize: 18.0),
                  onTap: () => print('SECOND CHILD'),
                ),
              ],
            ),
          );
        }
    );
  }
}
