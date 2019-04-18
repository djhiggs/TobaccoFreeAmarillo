import 'quiz.dart';
import 'package:flutter/material.dart';
class Topic extends StatelessWidget{
  String header;
  //composed of "Paragraph: "'s
  List<String> passage;
  Quiz quiz = Quiz();

  @override
  Widget build(BuildContext context) {
    var children = <Widget>[];
    for(var paragraph in passage){
      children.add(Padding(child: Text(paragraph, 
      overflow: TextOverflow.ellipsis,
      maxLines: 3,), 
      padding: EdgeInsets.symmetric(
        vertical: 0,
        horizontal: 16,
      ),
      ));
      children.add(Text(""));//empty line
    }
    children.add(RaisedButton(
      child: Text('Take Quiz'), 
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
          return quiz;
        }));
      },
    ));
    //
    return ExpansionTile(
      title: Text(header),
      initiallyExpanded: false,
      children: children,
    );
  }
}