import 'package:flutter/material.dart';
import 'upgrade.dart';
import '../genericGame.dart';
import 'cigClickWidget.dart';
import 'dart:async';
import 'dart:math';

class CigClick extends GenericGame{
  CigClickWidget cigClickWidget;
  CigClick(BuildContext context) : super(context){
    this.title = "Cig Click";
    cigClickWidget = CigClickWidget(this);
  }

  @override
  Widget get widget => cigClickWidget;
  List<Upgrade> upgrades = <Upgrade>[
    Upgrade(5,log(2),false,1,0,"Hammer"),
    Upgrade(5,log(2),true,5,0,"Auto Hammer"),
  ];
  double cigsPerSecond = 0;
  double totalCigs = 0;
  double cigsOnClick = 1;
  bool running;
  @override
  open() {
    running = true;
  /*Timer.periodic(Duration(seconds: 1), 
      (Timer timer){
        const double dt = 1;
        totalCigs +=cigsPerSecond*dt;
        _cigClickWidget.refresh();
        if(!running)
          timer.cancel();
      }); */
    super.open();
  }
  @override
  close() {
    running = false;
    super.close();
  }
}