import 'package:flutter/services.dart';
import '../settings/database.dart';
import 'package:flutter/material.dart';
import 'dart:async';


class Privacy {
  static List<String> _lines;
  
  static void show(BuildContext context) async{
    if(_lines ==null){
      _lines = List();
      var ln = await rootBundle.loadString('lib/tabs/settings/privacy/privacy.txt');
      _lines = ln.replaceAll('\r', "").replaceAll('\t', "").split('\n');
    }
    List<Text> texts = List();
    for(var line in _lines){
      texts.add(Text(line));
    }
    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext c) => Scaffold(
      appBar: 
        AppBar(title: Text("Privacy Policy"),
        ),
        body: ListView(children: texts,
          padding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 15
          ),
        )
    )));
  }
}