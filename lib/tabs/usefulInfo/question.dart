import 'package:flutter/material.dart';
class Question extends StatelessWidget{
  String question;
  List<String> choices = List();
  int answerIndex;
  @override
  Widget build(BuildContext context) {
    List<Widget> column = <Widget>[
      Text(question),
    ];
    for(int i = 0; i < column.length; i++){
      column.add(
        RaisedButton(
          onPressed: (){
            
          }
        )
      );
    }

  }
}