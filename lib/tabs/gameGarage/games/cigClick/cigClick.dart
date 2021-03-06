import 'package:flutter/material.dart';
import 'upgrade.dart';
import '../genericGame.dart';
import 'cigClickWidget.dart';
import 'dart:math';
import '../../../achievement_page/achievement.dart';

class CigClick extends GenericGame{
  CigClickWidget cigClickWidget;
  List<Achievement> achievements;
  CigClick(BuildContext context) : super(context,200){
    this.title = "Cigarette Crush";
    this.description = "Trash those cigs!"; // TODO Pending better catch phrase
    cigClickWidget = CigClickWidget(this);
    //AchievementPage.achievements.addAll(achievements);
  }

  @override
  Widget get widget => cigClickWidget;
  List<Upgrade> upgrades = <Upgrade>[
    Upgrade(25,log(2),false,1,0,"Hammer",'assets/images/Hammer.png'),
    Upgrade(60,log(2),false,3,0,'Boot','assets/images/Boot.png'),
    Upgrade(500,log(2),false,15,0,'Wrecking ball','assets/images/WreckingBall.png'),
    Upgrade(425,log(2),true,4,0,'Trash Compactor','assets/images/TrashCompactor.png'),
    Upgrade(900,log(3),true,12,0,'Grandma with a shoe','assets/images/Grandma.png'),

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