import 'package:card_settings/card_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_beautiful_popup/main.dart';
import 'package:journeywest/enums/Status.dart';
import 'package:journeywest/view/admin/BaseView.dart';
import 'package:journeywest/viewmodel/admin/scenario/ShoppingCartForToolViewModel.dart';

class ShoppingCartForToolPage extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final int id;
  final String name;
  ShoppingCartForToolPage({Key key, @required this.id, @required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<ShoppingCartForToolViewModel>(
        builder: (context, child, model) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Shopping Cart For Tool'),
        ),
        body: FutureBuilder(
          future: model.load(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Flexible(
                        child: Form(
                          key: _formKey,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: CardSettings(
                              children: <CardSettingsSection>[
                                CardSettingsSection(
                                  header: CardSettingsHeader(
                                    color: Colors.blue,
                                    label: 'Tool',
                                  ),
                                  children: <Widget>[
                                    SizedBox(height: 20),
                                    Padding(
                                      padding: const EdgeInsets.all(50.0),
                                      child: ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        itemCount: model.allTool.length,
                                        itemBuilder: (context, index) {
                                          return Container(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                child: Column(
                                                  children: [
                                                    Image.network(
                                                        model.allTool[index]
                                                            .image,
                                                        height: 200,
                                                        width: 200),
                                                    Text(model
                                                        .allTool[index].name),
                                                    CardSettingsInt(
                                                      label: "Quantity",
                                                      initialValue: 0,
                                                      onChanged: (value) {
                                                        if(value < 0 || value.isNaN || value > model.allTool[index].quantity) {

                                                        } else {
                                                          model.addToolToCart(
                                                              model.allTool[index]
                                                                  .id,
                                                              value,
                                                              id);
                                                        }
                                                      },
                                                      validator: (value) {
                                             if(value < 0 || value.isNaN || value > model.allTool[index].quantity)
                                                    return "Invalid number";
                                                      }
                                                    ),
                                                    SizedBox(height: 20),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CardFieldLayout(<Widget>[
                                        CardSettingsButton(
                                          label: 'Save',
                                          backgroundColor: Colors.green,
                                          onPressed: () async {
                                    if(_formKey.currentState.validate()) {
                                        if(model.tools.length == 0) {
                                          print("rỗng");
                                          final popup = BeautifulPopup(
                                            context: context,
                                            template: TemplateFail,
                                          );
                                          popup.show(
                                              title: 'Action failed',
                                              content: 'Something went wrong.',
                                              actions: [
                                                popup.button(
                                                  label: 'Close',
                                                  onPressed: Navigator.of(context).pop,
                                                )]);
                                        } else {
                                      bool isCreated = await model.addToolToScenario();
                                      if(isCreated) {
                                        Navigator.pop(context, Status.isCreated);
                                      } else {
                                        final popup = BeautifulPopup(
                                          context: context,
                                          template: TemplateFail,
                                        );
                                        popup.show(
                                            title: 'Action failed',
                                            content: 'Something went wrong.',
                                            actions: [
                                              popup.button(
                                                label: 'Close',
                                                onPressed: Navigator.of(context).pop,
                                              )]);
                                      }
                                        }
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
                      ),
                    ],
                  ),
                ),
              );
            } else
              return Center(child: CircularProgressIndicator());
          },
        ),
      );
    });
  }
}
