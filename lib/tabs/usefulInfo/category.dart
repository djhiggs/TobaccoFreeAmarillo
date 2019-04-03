import 'topic.dart';
import 'dart:io';
import 'package:flutter/material.dart';

class Category extends StatelessWidget{
  String header;
  List<Topic> topics = List();

  @override
  Widget build(BuildContext context) {
    var children = <Widget>[];
    for(var topic in topics)
      children.add(topic.build(context));
    return ExpansionTile(
      title: Text(header,textScaleFactor: 1.4,),
      initiallyExpanded: false,
      children: children,
    );
  }
}