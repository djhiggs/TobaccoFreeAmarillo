import 'package:flutter/material.dart';
import 'question.dart';
import '../settings/database.dart';
class Quiz extends StatefulWidget
{
  Quiz(this.db,this.quizID){
    //completed = db["QuizStatus$quizID"];
  }
  //int currentQuestion;
  int quizID;
  Database db;
  bool completed;
  List<Question> questions = List();
  @override
  QuizState createState() {
    return QuizState(0,questions,db,quizID);
    //return QuizState(completed? questions.length:0,questions,db,quizID);
  }
}
class QuizState extends State<Quiz>
{
  static int _quizPassedCount = 0;
  QuizState(this.currentQuestion,this.questions,this.db,this.quizID);
  int currentQuestion;
  int quizID;
  List<Question> questions;
  Database db;
  @override
  Widget build(BuildContext context) {
    if(currentQuestion >= questions.length){
    //  db["QuizStatus$quizID"] = true;
    //  _quizPassedCount++;
      return _buildResultPage();
    }
    else{
      questions[currentQuestion].state = this;
      return Scaffold(
        appBar: AppBar(
        leading: new IconButton(icon: Icon(Icons.close),
        onPressed: ()=>Navigator.of(context).pop(),),
      ),
        body: questions[currentQuestion]);
    }
  }
  Widget _buildResultPage(){
    double totalScore = 0;
    List<Widget> content = List();
    for(Question q in questions){
      if(q.chosenAnswerIndex == q.correctAnswerIndex)
        totalScore += 100.0/questions.length;
      List<Widget> answers = List();
      for(int i = 0; i < q.choices.length; i++)
        answers.add(Card(child: Row(
          children: <Widget>[Icon(i == q.correctAnswerIndex? Icons.check : 
            i == q.chosenAnswerIndex? Icons.close : Icons.do_not_disturb_on),
            Flexible(child: Text(q.choices[i])),
          ],)));
      content.add(
        ExpansionTile(title: 
          Container(
            child: Row(
              children: <Widget>[
                Icon(q.chosenAnswerIndex==q.correctAnswerIndex?Icons.check:Icons.close),
                  Flexible(child: Padding(child: 
                    Text(
                      q.question,
                      textAlign: TextAlign.justify,
                      overflow: TextOverflow.ellipsis,
                    ),
                  padding: EdgeInsets.fromLTRB(8, 8, 32, 8),
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(color: q.chosenAnswerIndex == q.correctAnswerIndex?
              Colors.green[200] : Colors.red[200]),
          ),
          children: answers,
        ),
      );
    }
    content.insert(0, Text(totalScore.toInt().toString() + "/100",textScaleFactor: 4));
    return Scaffold(
      appBar: AppBar(
        leading: new IconButton(icon: Icon(Icons.close),
          onPressed: ()=>Navigator.of(context).pop(),),
        title: Text("Results",textScaleFactor: 1.3,),
      ),
      body: Column(children: content),
    );
  }
}