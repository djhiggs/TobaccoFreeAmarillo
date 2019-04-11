import 'package:flutter/src/widgets/framework.dart';

import 'mySnake.dart';
import '../genericGame.dart';

class SnakeInterface extends GenericGame{
  MyApp snakeApp = MyApp();
  SnakeInterface(BuildContext context) : super(context){
    title = "Snake";
  }
  @override
  Widget get widget => snakeApp;
}