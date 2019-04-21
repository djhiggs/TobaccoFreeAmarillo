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
      Padding(child: Text(question,
          style: TextStyle(fontSize: 24)
        ),
        padding: EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 16
        ),
      )
    ];
    for(int i = 0; i < choices.length; i++){
      column.add(
        Expanded(
          child: SizedBox(
            child:Padding(
              child: RaisedButton(
                onPressed: (){
                  chosenAnswerIndex = i;
                  state.setState((){
                    state.currentQuestion++;
                  });
                },
                child: Text(choices[i])
              ),
              padding: EdgeInsets.all(8),
            ),
            width: double.infinity,
          )
        ),
      );
    }
    return Column(children: column,
      textDirection: TextDirection.ltr,
      crossAxisAlignment: CrossAxisAlignment.center,
      );

  }
}