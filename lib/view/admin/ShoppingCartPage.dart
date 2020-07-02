import 'package:card_settings/card_settings.dart';
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
                            label: 'Scenario',
                          ),
                          children: <Widget>[
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
                    onTap: () => print('FIRST CHILD')
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
