import 'package:flutter/material.dart';
import 'question.dart';
class Quiz extends StatefulWidget
{
  List<Question> questions = List();
  @override
  QuizState createState() {
    // TODO: implement createState
    
    return null;
  }
}
class QuizState extends State<Quiz>
{
  //-1 when done
  int currentQuestion;
  List<Question> questions;
  @override
  Widget build(BuildContext context) {
    return 
      Container(child: currentQuestion == -1?
        _buildResultPage():
        questions[currentQuestion]
      );
  }
  Widget _buildResultPage(){
    int totalScore = 0;
    for(Question q in questions){
      
    }
  }
}