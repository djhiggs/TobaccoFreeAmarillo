import 'package:flutter/material.dart';
import 'question.dart';
import '../settings/database.dart';
import '../achievement_page/achievement.dart';
import '../achievement_page/achievement_page.dart';
class Quiz extends StatefulWidget
{
  static List<Achievement> _achievements;
  static void initialize(Database db){
    _achievements = <Achievement>[
      Achievement(db["quiz.achieve.1"] as bool,"Fresh Start","Completed first quiz",100),
      Achievement(db["quiz.achieve.2"] as bool,"Ultra Dedication","Finished five quizes",500),
      Achievement(db["quiz.achieve.4"] as bool,"3!","Completed 3! 3 X 2 X 1 quizes",720),
      Achievement(db["quiz.achieve.3"] as bool,"Popular Prime","Completed seven quizes",777),
      Achievement(db["quiz.achieve.6"] as bool,"Miner Cube","Completed finished 8 quizes (2 X 2 X 2)",1024),
      Achievement(db["quiz.achieve.7"] as bool,"Square of squares","Passed 16 or 4 X 4 or 2 X 2 X 2 X 2 quizes",2048),
      Achievement(db["quiz.achieve.8"] as bool,"Ω Teen Prime","Passed 19 quizes (greatest prime that is a teen)",2190),
      Achievement(db["quiz.achieve.9"] as bool,"4!","Finished 24 or 4 X 3 X 2 X 1 quizes",1200),
    ];
    for(int i = 0; i < _achievements.length; i++)
      if(_achievements[i].status ==null){
        _achievements[i].status =false;
        db.setLocal("quiz.achieve." + (i+ 1).toString(), false);
      }
    AchievementPage.achievements.addAll(_achievements);
    Quiz._db = db;
  }
  static int _quizPassedCount = 0;
  static void checkAchievementStatus(){
    switch (_quizPassedCount) {
      case 1:
        _achievements[1].status =true;
        _db.setLocal("quiz.achieve.1", true);
        break;
      case 5:
        _achievements[2].status =true;
        _db.setLocal("quiz.achieve.2", true);
        break;
      case 6:
        _achievements[3].status =true;
        _db.setLocal("quiz.achieve.3", true);
        break;
      case 7:
        _achievements[4].status =true;
        _db.setLocal("quiz.achieve.4", true);
        break;
      case 8:
        _achievements[5].status =true;
        _db.setLocal("quiz.achieve.5", true);
        break;
      case 16:
        _achievements[6].status =true;
        _db.setLocal("quiz.achieve.6", true);
        break;
      case 19:
        _achievements[7].status =true;
        _db.setLocal("quiz.achieve.7", true);
        break;
      case 24:
        _achievements[8].status =true;
        _db.setLocal("quiz.achieve.8", true);
        break;
      default:
    }
  }
  Quiz(this.quizID){
    passed = _db["QuizStatus$quizID"];
    if(passed ==null)
      passed =false;
    else if(passed)
      _quizPassedCount++;
  }
  //int currentQuestion;
  int quizID;
  static Database _db;
  bool passed;
  List<Question> questions = List();
  @override
  QuizState createState() {
    //if(!passed)
    return QuizState(0,this);

    //return QuizState(passed? questions.length:0,this);
  }
  tryComplete(){
    if(passed)
      return;
    double totalScore = 0;
    for(Question q in questions)
      if(q.chosenAnswerIndex == q.correctAnswerIndex)
        totalScore += 100.0/questions.length;
    if(totalScore >= 70){//passed
      _quizPassedCount++;
      passed = true;
      _db.setLocal("QuizStatus$quizID", true);
      checkAchievementStatus();
    }
  }
}
class QuizState extends State<Quiz>
{
  QuizState(this.currentQuestion,this.quiz);
  int currentQuestion;
  Quiz quiz;
  @override
  Widget build(BuildContext context) {
    if(quiz.passed)
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(icon: Icon(Icons.close),
            onPressed: ()=>Navigator.of(context).pop(),
          ),
        ),
        body: Column(children: <Widget>[
          Text("Status",textScaleFactor: 1.4),
          Text("Passed",textScaleFactor: 1.2),
          RaisedButton(
            child: Text("Continue"),
            onPressed: ()=>Navigator.of(context).pop()
          )
        ],),
      );
    if(currentQuestion >= quiz.questions.length){
      quiz.tryComplete();
      return _buildResultPage();
    }
    else{
      quiz.questions[currentQuestion].state = this;
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(icon: Icon(Icons.close),
            onPressed: ()=>Navigator.of(context).pop(),
          ),
        ),
        body: quiz.questions[currentQuestion],
      );
    }
  }
  Widget _buildResultPage(){
    double totalScore = 0;
    List<Widget> content = List();
    for(Question q in quiz.questions){
      if(q.chosenAnswerIndex == q.correctAnswerIndex)
        totalScore += 100.0/quiz.questions.length;
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
                      maxLines: 10,
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
    if(totalScore < 70)
      content.add(RaisedButton(
        child: Text("Retry"),
        onPressed: (){
          currentQuestion = 0;
          setState(() { });
        },
      ));
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: ()=>Navigator.of(context).pop()),
        title: Text("Results",textScaleFactor: 1.3),
      ),
      body: Column(children: content),
    );
  }
}