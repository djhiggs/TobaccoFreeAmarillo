import 'package:flutter/services.dart';
import '../settings/database.dart';
import 'package:flutter/material.dart';
import 'dart:async';


class Privacy extends StatefulWidget {
  @override
  PrivacyState createState() => PrivacyState();
}
class PrivacyState extends State<Privacy> {
  static List<String> _lines;
  @override
  Widget build(BuildContext context) {
    //var s = Completer.sync();
    //s.complete(import());
    if(_lines ==null){
      _lines = List();
      import().whenComplete(() => setState((){}));
    }
    List<Text> texts = List();
    for(var line in _lines){
      texts.add(Text(line));
    }
    return AlertDialog(
      title: Text("Privacy Policy"),
      content: ListView(
        children: texts,
      ),
      actions: <Widget>[
      FlatButton(
            color: Colors.black26,
            textColor: Colors.black,
            child: Text("Accept"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
      ]
    );
  }
  static Future<void> import() async{
    var ln = await rootBundle.loadString('lib/tabs/settings/privacy/privacy.txt');
    _lines = ln.replaceAll('\r', "").replaceAll('\t', "").split('\n');
  }
}