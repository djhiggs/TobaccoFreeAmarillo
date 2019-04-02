import 'package:flutter/material.dart';
import 'cigClickUpgrade.dart';
import '../genericGame.dart';
import 'cigClickWidget.dart';

class CigClick extends GenericGame{
  CigClickWidget _cigClickWidget;
  CigClick(BuildContext context) : super(context){
    this.title = "Cig Click";
    _cigClickWidget =CigClickWidget(this);
  }

  @override
  Widget get widget => _cigClickWidget;
  List<Upgrade> upgrades = <Upgrade>[
    Upgrade(5,false,1,0,"Hammer"),
    Upgrade(5,true,5,0,"Auto Hammer"),
  ];
  double cigsPerSecond = 0;
  double totalCigs = 0;
  double cigsOnClick = 1;
  @override
  void update(double dt) {
    totalCigs +=cigsPerSecond*dt;
    super.update(dt);
  }
  @override
  void render(Canvas canvas) {
    _cigClickWidget.refresh();
    super.render(canvas);
  }
}