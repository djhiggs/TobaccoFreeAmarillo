import 'dart:io';

class Question
{
  String question;
  String choice;

  quizBox(int index) async
  {
    var lines = await new File('quizBox/quizbox$index.txt').readAsLines();
    question = lines[0];
    for(int i = 1; i < lines.length; i++)
      choice += lines[i];
  }


}