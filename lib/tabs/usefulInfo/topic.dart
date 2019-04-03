import 'question.dart';
import 'package:flutter/material.dart';
class Topic extends StatelessWidget{
  String header;
  //composed of "Paragraph: "'s
  List<String> passage;
  List<Question> quiz = List();

  @override
  Widget build(BuildContext context) {
    var children = <Widget>[];
    for(var paragraph in passage){
      children.add(Padding(child: Text(paragraph), padding: EdgeInsets.symmetric(
        vertical: 0,
        horizontal: 16,
      )));
      children.add(Text(""));//empty line
    }
    //for the quiz
    var questions = <Widget>[];
    for(var question in quiz)
      questions.add(question.build(context));
    children.add(RaisedButton(
      color: Colors.blue,
      child: Text("Take Quiz"),
      onPressed: (){showDialog(context: context, builder: (BuildContext context){
          AlertDialog(title: Text("Quiz"),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: questions));
        }); 
      },
    ));
    //
    return ExpansionTile(
      title: Text(header),
      initiallyExpanded: false,
      children: children,
    );
  }
}