import 'package:flutter/services.dart';
import '../settings/database.dart';
import 'package:flutter/material.dart';
import 'dart:async';


class Privacy extends StatelessWidget {
  static List<String> _lines;
  @override
  Widget build(BuildContext context) {
    var s = Completer.sync();
    s.complete(import());
    List<Text> texts = List();
    for(var line in _lines){
      texts.add(Text(line));
    }
    return AlertDialog(
      title: Text("Privacy Policy"),
      content: ListView(
        children: texts,
      ),
    );
  }
  Future<void> import() async{
    var ln = await rootBundle.loadString('lib/tabs/settings/privacy/privacy.txt');
    _lines = ln.replaceAll('\r', "").replaceAll('\t', "").split('\n');
  }
}