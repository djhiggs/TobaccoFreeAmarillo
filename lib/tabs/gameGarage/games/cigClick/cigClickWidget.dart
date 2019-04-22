import 'dart:async';

import 'package:flutter/material.dart';
import 'upgrade.dart';
import 'cigClick.dart';

class CigClickWidget extends StatefulWidget{
  CigClick game;
  CigClickWidget(this.game);
  CigClickWidgetState state;
  refresh() {
    if(state !=null)
      state.setState((){});
  }
  @override
  CigClickWidgetState createState() {
    state = CigClickWidgetState(game);
    return state;
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
        trailing: Text('🚬' + upgrade.cost().round().toString()),
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
              color: Colors.lightGreen,
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