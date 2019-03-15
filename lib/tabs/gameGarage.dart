import 'package:flutter/material.dart';
import 'package:spritewidget/spritewidget.dart';
import 'package:spritewidget/spritewidget.dart' as spriteWidget;
//class GameGarage extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) => new Container();
//}
class GameGarage extends StatefulWidget {
  @override
  Widget build(BuildContext context) => new Container();

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return null;
  }
}
enum RunningModes
{
  Nothing,
  BouncyGame,
}
class _GameGarage extends State<GameGarage> {
  RunningModes mode;
  @override
  Widget build(BuildContext context){
    switch (mode) {
      case RunningModes.Nothing:
        
        break;
      case RunningModes.BouncyGame:
        
        break;
      default:
    }
  }
  buildGameTemplate(){
  }
}