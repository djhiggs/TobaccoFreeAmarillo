import 'package:flutter/material.dart';
import 'question.dart';
import '../settings/database.dart';
import '../achievement_page/achievement.dart';
import '../achievement_page/achievement_page.dart';
class Quiz extends StatefulWidget
{
  static List<Achievement> _achievements;
  ///this is called in main and loads in all of the achievements
  static void initialize(Database db){
    //initializes all of the achievements and gets their current stats from the database
    _achievements = <Achievement>[
      Achievement(db["quiz.achieve.1"] as bool,"Fresh Start","Completed first quiz",100),
      Achievement(db["quiz.achieve.2"] as bool,"Ultra Dedication","Finished five quizes",500),
      Achievement(db["quiz.achieve.4"] as bool,"3!","Completed 3! 3 X 2 X 1 quizes",720),
      Achievement(db["quiz.achieve.3"] as bool,"Popular Prime","Completed seven quizes",777),
      Achievement(db["quiz.achieve.6"] as bool,"Miner Cube","Completed finished 8 quizes (2 X 2 X 2)",1024),
      Achievement(db["quiz.achieve.7"] as bool,"Square of □s","Passed 16 or 4 X 4 or 2 X 2 X 2 X 2 quizes",2048),
      Achievement(db["quiz.achieve.8"] as bool,"Ω Teen Prime","Passed 19 quizes (greatest prime that is a teen)",2190),
      Achievement(db["quiz.achieve.9"] as bool,"4!","Finished 24 or 4 X 3 X 2 X 1 quizes",1200),
    ];
    //checks for achievements that have not been instantiated in the database yet
    for(int i = 0; i < _achievements.length; i++)
      if(_achievements[i].status ==null){
        //assignes a default value
        _achievements[i].status =false;
        //sets the value to the LOCAL database
        //using a general definition so it doesn't
        //overide anything and distinguishes them
        //using the index
        db.setLocal("quiz.achieve." + (i+ 1).toString(), false);
      }
    //adds these achievements to the global achievement list
    //to be rendered later
    AchievementPage.achievements.addAll(_achievements);
    //saves the database instance for later use
    Quiz._db = db;
  }
  //a counter for the total amount of quizes passed.
  static int _quizPassedCount = 0;
  ///checks if any new achievements have been earned
  ///(assesses eligibility)
  static void checkAchievementStatus(){
    if(_db["PointAmount"] == null)
      _db["PointAmount"] =0;
    //a switch that covers all of the possible achievements
    switch (_quizPassedCount) {
      case 1:
        //updates the status for the achievement
        _achievements[1].status =true;
        //updates the LOCAL database with the new
        //database value
        _db.setLocal("PointAmount", _db["PointAmount"] + _achievements[1].points);
        _db.setLocal("quiz.achieve.1", true);
        break;
      case 5:
        _achievements[2].status =true;
        _db.setLocal("PointAmount", _db["PointAmount"] + _achievements[2].points);
        _db.setLocal("quiz.achieve.2", true);
        break;
      case 6:
        _achievements[3].status =true;
        _db.setLocal("PointAmount", _db["PointAmount"] + _achievements[3].points);
        _db.setLocal("quiz.achieve.3", true);
        break;
      case 7:
        _achievements[4].status =true;
        _db.setLocal("PointAmount", _db["PointAmount"] + _achievements[4].points);
        _db.setLocal("quiz.achieve.4", true);
        break;
      case 8:
        _achievements[5].status =true;
        _db.setLocal("PointAmount", _db["PointAmount"] + _achievements[5].points);
        _db.setLocal("quiz.achieve.5", true);
        break;
      case 16:
        _achievements[6].status =true;
        _db.setLocal("PointAmount", _db["PointAmount"] + _achievements[6].points);
        _db.setLocal("quiz.achieve.6", true);
        break;
      case 19:
        _achievements[7].status =true;
        _db.setLocal("PointAmount", _db["PointAmount"] + _achievements[7].points);
        _db.setLocal("quiz.achieve.7", true);
        break;
      case 24:
        _achievements[8].status =true;
        _db.setLocal("PointAmount", _db["PointAmount"] + _achievements[8].points);
        _db.setLocal("quiz.achieve.8", true);
        break;
      //default case for when no achievements have been earned.
      default:
        return;
    }
  }
  //a constructor the the quiz
  Quiz(this.quizID){
    //checks if the quiz has been passed
    passed = _db["QuizStatus$quizID"];
    //assignes a default value
    if(passed ==null)
      passed =false;
      //increments the counter if the quiz has been passed
      //NOTE: this eliviates the need to store '_quizPassedCount' in the DB
    else if(passed)
      _quizPassedCount++;
  }
  ///this quizes ID
  int quizID;
  ///static reference to the database
  static Database _db;
  ///whether or not this quiz has been passed
  bool passed;
  ///the questions for this quiz
  List<Question> questions = List();
  @override
  QuizState createState() =>QuizState(0,this);
  ///checkes if the quiz has been passed the last
  ///time it was taken
  void tryComplete(){
    if(passed)
      return;//returns because merits have already been awareded

    //gets the total score
    double totalScore = 0;
    for(Question q in questions)
      if(q.chosenAnswerIndex == q.correctAnswerIndex)
        totalScore += 100.0/questions.length;

    if(totalScore >= 70){//passed
      _quizPassedCount++;
      passed = true;
      //updates the local value for this quizes status in the database
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
      //checks if the userhas finished taking the quiz
    if(currentQuestion >= quiz.questions.length){
      //checks if the user passed
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