class Quiz{
  String question;
  List<String> answer = List();
  int answerIndex;
  int buildTopic(List<String> lines,int startingLine){
    question = lines[startingLine].substring(lines[startingLine].indexOf(':') + 1);
    startingLine++;
    while(true){
      startingLine++;
      if(lines[startingLine].contains("Choice: "))
        answer.add(lines[startingLine].substring(lines[startingLine].indexOf(':') + 1));
      else if(lines[startingLine].contains("Answer: ")){
        answerIndex = answer.length;
        answer.add(lines[startingLine].substring(lines[startingLine].indexOf(':') + 1));
      }
      else break;
    }
  }
}