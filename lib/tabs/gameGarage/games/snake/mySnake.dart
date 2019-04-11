import 'package:flutter/material.dart';
import 'game.dart';

//void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Snake',
      home: new Home()
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    return new Scaffold(
        backgroundColor: const Color(0xFF000000),
        body: new Center(
          child: new Game(),
        ) 
        );
  }
}
