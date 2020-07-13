


import 'package:flutter/material.dart';
import 'package:journeywest/model/Actor.dart';
import 'package:journeywest/view/admin/BaseView.dart';
import 'package:journeywest/viewmodel/admin/actor/ActorDetailViewModel.dart';

class ActorDetailPage extends StatelessWidget {
  final Actor actor;
  ActorDetailPage({Key key, @required this.actor}) : super(key : key);

  @override
  Widget build(BuildContext context) {
    return BaseView<ActorDetailViewModel>(
      builder: (context, child, model) {
        return Scaffold(
          body: FutureBuilder(
            future: model.fetchData(actor),
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
                                  child: Image.network(model.actor.image)
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 15),
                          Row(
                            children: <Widget>[
                              Container(
                                child: Icon(
                                    Icons.person
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
                                      model.actor.name
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
                                    Icons.verified_user
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  child: Text(
                                    'Username',
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
                                      model.actor.username
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
                                    Icons.email
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  child: Text(
                                    'Email',
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
                                      model.actor.email
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
                                      model.actor.description
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
                                    Icons.phone
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  child: Text(
                                    'Phone',
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
                                      model.actor.phone
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