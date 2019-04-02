import 'package:flutter/src/widgets/framework.dart';

import 'genericGame.dart';
import 'clicker.dart';
class ClickerWrapper extends GenericGame{
  CigClick _child = CigClick();

  ClickerWrapper(BuildContext context) : super(context){
    this.title = "Cig Clicker";
  }
  @override
  Widget get widget => _child;
  @override
  void update(double dt) {
    //super.update(dt);
    _child.homePage.crushedCounter += dt*_child.homePage.passiveIncreaseRate;
    _child.homePage.currentState.setState((){});
  }

}