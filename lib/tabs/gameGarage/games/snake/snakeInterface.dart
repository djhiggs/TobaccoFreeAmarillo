import 'package:flutter/src/widgets/framework.dart';

import 'mySnake.dart';
import '../genericGame.dart';
import 'package:flutter/material.dart';
import 'game_constants.dart';

class SnakeInterface extends GenericGame{
  MyApp snakeApp = MyApp();
  SnakeInterface(BuildContext context) : super(context){
    title = "Snake";
    Globals.initialize(context);
  }
  @override
  Widget get widget => Scaffold(
    appBar: AppBar(title: Text(title),),
    body: snakeApp,
  );
}