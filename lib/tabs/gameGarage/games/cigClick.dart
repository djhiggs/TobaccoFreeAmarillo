import 'package:flutter/material.dart';
import 'item.dart';
import 'genericGame.dart';

class CigClick extends GenericGame{
  CigClick(BuildContext context) : super(context);

  @override
  // TODO: implement widget
  Widget get widget => new Scaffold(
    appBar: AppBar(actions: <Widget>[
      new IconButton(icon: Icon(Icons.close),onPressed: (){close();},)
    ],),
    body: new Column(
      children: <Widget>[

      ],
    )
  );

}