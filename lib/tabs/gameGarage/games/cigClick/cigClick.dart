import 'package:flutter/material.dart';
import 'cigClickUpgrade.dart';
import '../genericGame.dart';
import 'cigClickWidget.dart';
import 'dart:async';

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
  open() {
    Timer.periodic(Duration(seconds: 1), 
      (Timer timer){
        const double dt = 1;
        totalCigs +=cigsPerSecond*dt;
        _cigClickWidget.refresh();
      });
    return super.open();
  }
}