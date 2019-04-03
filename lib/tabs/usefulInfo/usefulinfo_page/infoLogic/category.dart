/* import 'topic.dart';
import 'dart:io';

class Category{
  String header;
  List<Topic> topics;
  import(int index) async{
    var lines = await new File('infoBox/infobox$index.txt').readAsLines();
    int startLine = lines[0].indexOf(':');
    header = lines[0].substring(startLine);
    for(int i = 1; i < lines.length; i++){
      var last = Topic();
      topics.add(last);
      i = last.buildTopic(lines, i);
    }
  }
} */