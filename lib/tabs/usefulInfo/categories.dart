import 'package:flutter/services.dart';
import 'package:tobaccoFreeAmarilloApp/tabs/usefulInfo/quiz.dart';
import 'category.dart';
import 'question.dart';
import 'topic.dart';


class Categories{
  // Parses out all the raw text from category1.txt into usable lists for display in Useful Info tab.
  List<Category> categories;
  static const int _categoryCount = 1; 
  Future import() async{
    categories = List();
    Question question;
    Topic topic;
    Category category;
    for(int i = 1; i<= _categoryCount;i++){
      var ln = await rootBundle.loadString('lib/tabs/usefulInfo/categories/category$i.txt');
      var lines = ln.replaceAll('\r', "").replaceAll('\t', "").split('\n');
      for(var line in lines){
        int contentStartLine = line.indexOf(' ');
        String header, content;
        if(contentStartLine != -1)
          {
            contentStartLine++;
            header = line.substring(0,contentStartLine - 2);
            content = line.substring(contentStartLine);
          }
        else
          header = line.trim();

        switch (header) {
          case "Choice":
            question.choices.add(content);
            break;
          case "Answer":
            question.answerIndex =question.choices.length;
            question.choices.add(content);
            break;
          case "Question":
            question =Question();
            question.question =content;
            topic.quiz.questions.add(question);
            break;
          case "Quiz:":
            topic.quiz = Quiz();
            break;
          case "Paragraph":
            topic.passage.add(content);
            break;
          case "Passage":
            topic.passage = List();
            break;
          case "Topic":
            topic = Topic();
            topic.header = content;
            category.topics.add(topic);
            break;
          case "Category":
            category =Category();
            category.header =content;
            categories.add(category);
            break;
          default:
        }
      }
    }
    return;
  }
}