import 'dart:async';

import 'package:flutter/material.dart';
import 'upgrade.dart';
import 'cigClick.dart';
import 'package:tobaccoFreeAmarilloApp/tabs/settings/database.dart';
import 'package:tobaccoFreeAmarilloApp/tabs/achievement_page/achievement.dart';
import 'package:tobaccoFreeAmarilloApp/tabs/achievement_page/achievement_page.dart';

class CigClickWidget extends StatefulWidget{
  final CigClick game;
  CigClickWidget(this.game);
  @override
  CigClickWidgetState createState() {
    return CigClickWidgetState(game);
  }

static List<Achievement> _achievements;
  ///this is called in main and loads in all of the achievements
  static void initialize(Database db){
    //initializes all of the achievements and gets their current stats from the database
    _achievements = <Achievement>[
      Achievement(db["click.achieve.1"] as bool,"One down...","Completed first crush!",500),
      Achievement(db["click.achieve.2"] as bool,"Keep Crushing!","Crush 100 cigarettes",300),
      Achievement(db["click.achieve.4"] as bool,"Unstoppable!","Crush 1,000 cigarettes",400),
      Achievement(db["click.achieve.3"] as bool,"Crushing Machine!","Crush 4,000 cigarettes",700),
      Achievement(db["click.achieve.6"] as bool,"More family more crushing!","Crush 12,000",1500),
      Achievement(db["click.achieve.7"] as bool,"Can't...stop...crushing!","Crush 50,000 cigarettes",3000),
      Achievement(db["click.achieve.8"] as bool,"Destory them all.","Crush 1,000,000 cigarettes",10000),
      Achievement(db["click.achieve.9"] as bool,"I CAN'T STOP","Crush 1,000,000,000 cigarettes",1),
    ];
    //checks for achievements that have not been instantiated in the database yet
    for(int i = 0; i < _achievements.length; i++)
      if(_achievements[i].status ==null){
        //assignes a default value
        _achievements[i].status =false;
        //sets the value to the LOCAL database
        //using a general definition so it doesn't
        //overide anything and distinguishes them
        //using the index
        db.setLocal("click.achieve." + (i+ 1).toString(), false);
      }
    //adds these achievements to the global achievement list
    //to be rendered later
    AchievementPage.achievements.addAll(_achievements);
    //saves the database instance for later use
    CigClickWidget._db = db;
  }

  static Database _db;

  void checkAchievementStatus(){
    if(_db["PointAmount"] == null)
      _db["PointAmount"] =0;
    //a switch that covers all of the possible achievements
    switch (game.totalCigs.toInt()) {
      case 1:
        //updates the status for the achievement
        _achievements[1].status =true;
        //updates the LOCAL database with the new
        //database value
        _db.setLocal("PointAmount", _db["PointAmount"] + _achievements[1].points);
        _db.setLocal("click.achieve.1", true);
        break;
      case 100:
        _achievements[2].status =true;
        _db.setLocal("PointAmount", _db["PointAmount"] + _achievements[2].points);
        _db.setLocal("click.achieve.2", true);
        break;
      case 1000:
        _achievements[3].status =true;
        _db.setLocal("PointAmount", _db["PointAmount"] + _achievements[3].points);
        _db.setLocal("click.achieve.3", true);
        break;
      case 4000:
        _achievements[4].status =true;
        _db.setLocal("PointAmount", _db["PointAmount"] + _achievements[4].points);
        _db.setLocal("click.achieve.4", true);
        break;
      case 12000:
        _achievements[5].status =true;
        _db.setLocal("PointAmount", _db["PointAmount"] + _achievements[5].points);
        _db.setLocal("click.achieve.5", true);
        break;
      case 50000:
        _achievements[6].status =true;
        _db.setLocal("PointAmount", _db["PointAmount"] + _achievements[6].points);
        _db.setLocal("click.achieve.6", true);
        break;
      case 1000000:
        _achievements[7].status =true;
        _db.setLocal("PointAmount", _db["PointAmount"] + _achievements[7].points);
        _db.setLocal("click.achieve.7", true);
        break;
      case 1000000000:
        _achievements[8].status =true;
        _db.setLocal("PointAmount", _db["PointAmount"] + _achievements[8].points);
        _db.setLocal("click.achieve.8", true);
        break;
      //default case for when no achievements have been earned.
      default:
        return;
    }
}
}
class CigClickWidgetState extends State<CigClickWidget> {
  CigClick game;
  CigClickWidgetState(this.game);
  @override
  Widget build(BuildContext context) => new Scaffold(
      appBar: AppBar(
        leading: new IconButton(icon: Icon(Icons.close),onPressed: (){game.close();},)
      ),
      body: new Column(
        textDirection: TextDirection.ltr,
        children: buildList()
      )
    );
  //builds an upgrade list and adds a button for the user to click
  //to destroy cig's
  List<Widget> buildList(){
    List<Widget> widgets = <Widget>[
      Text(
        "Total Cigarettes Crushed",
        style: TextStyle(fontSize: 24),
      ),
      Text(
        '🚬  ' + game.totalCigs.round().toString() + '  🚬',
        style: TextStyle(fontSize: 36),
      ),
      ListTile(title: Text("Upgrades"),)];
      Timer(Duration(milliseconds: 100),(){
        const double dt = 0.1;
        game.totalCigs +=game.cigsPerSecond*dt;
        setState(() {});
      });
    for(Upgrade upgrade in game.upgrades){
      widgets.add(ListTile(
        leading: Image.asset(upgrade.image),
        title: Text(upgrade.title),
        trailing: Text('Cost: 🚬' + upgrade.cost().round().toString()),
        subtitle: Text(upgrade.amountOwned.toString() + " owned"),
        onTap: (){
          if(game.totalCigs >= upgrade.cost()){
            game.totalCigs -=upgrade.cost();
            upgrade.amountOwned++;
            if(upgrade.isPassive)
              game.cigsPerSecond +=upgrade.incrementAmount;
            else
              game.cigsOnClick +=upgrade.incrementAmount;
              //setState(() {});
          }
        },
      ));
      
    }
    widgets.add(
    /*   IconButton(icon: Icon(Icons.smoking_rooms),
        iconSize: 100,
        onPressed: (){
          game.totalCigs +=game.cigsOnClick;
        },
      )*/
      Container(
      width: 300,
      height: 100,
      color: Colors.transparent,
      child: new Container(
            decoration: new BoxDecoration(
              color: Colors.green,
              borderRadius: new BorderRadius.all(
                Radius.circular(40)
              )
            ),
            child: 
              RaisedButton(
                child: Image.asset('assets/images/RealCigarette.png'),
                color: Colors.green,
                shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                onPressed: (){
                  game.totalCigs += game.cigsOnClick;
                },
              ),
            ),
          )
    );
    return widgets;
  }
}