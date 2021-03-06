import 'mySnake.dart';
import '../genericGame.dart';
import 'package:flutter/material.dart';
import 'game_constants.dart';

class SnakeInterface extends GenericGame{
  MyApp snakeApp = MyApp();
  SnakeInterface(BuildContext context) : super(context,200){
    title = "Snake";
    description = "We all gotta slither sometime...";
    Globals.initialize(context);
  }
  @override
  Widget get widget => Scaffold(
    appBar: AppBar(title: Text(title),),
    body: snakeApp,
  );
}