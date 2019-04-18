import 'package:flutter/material.dart';
import 'quiz.dart';
class Question extends StatelessWidget{
  String question;
  List<String> choices = List();
  QuizState state;
  int correctAnswerIndex;
  int chosenAnswerIndex;
  @override
  Widget build(BuildContext context) {
    List<Widget> column = <Widget>[
      Text(question,
        style: TextStyle(fontSize: 24)
      ),
    ];
    for(int i = 0; i < choices.length; i++){
      column.add(
        RaisedButton(
          onPressed: (){
            chosenAnswerIndex = i;
            state.setState((){
              state.currentQuestion++;
            });
          },
          child: Text(choices[i]),
        )
      );
    }
    return Column(children: column,
      textDirection: TextDirection.ltr,
      crossAxisAlignment: CrossAxisAlignment.center,
      );

  }
}