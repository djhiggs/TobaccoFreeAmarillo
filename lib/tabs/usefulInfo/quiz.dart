import 'package:flutter/material.dart';
import 'question.dart';
class Quiz extends StatefulWidget
{
  List<Question> questions;
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
    return currentQuestion == -1?
      null:
      questions[currentQuestion];
  }
}