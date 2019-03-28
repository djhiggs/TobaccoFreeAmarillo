import 'package:flame/components/component.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'genericGame.dart';
class TRex extends GenericGame
{
  TRex(BuildContext context) : super(context){
    title = "T Rex Game";
    Component c =null;
    components.add(c);
  }
  @override
  // TODO: implement widget
  Widget get widget => super.widget;
}