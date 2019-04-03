import 'quiz.dart';
class Topic{
  String header;
  List<String> passage;
  List<Quiz> questions;
  //returns line after the last one add to this object
  int buildTopic(List<String> lines,int startingLine){
    header = lines[startingLine++];   
  }
}