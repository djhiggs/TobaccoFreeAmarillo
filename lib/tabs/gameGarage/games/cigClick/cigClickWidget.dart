import 'package:flutter/material.dart';
import 'cigClickUpgrade.dart';
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
      appBar: AppBar(actions: <Widget>[
        new IconButton(icon: Icon(Icons.close),onPressed: (){game.close();},)
      ],),
      body: new Column(
        textDirection: TextDirection.ltr,
        children: buildList()
      )
    );
  List<Widget> buildList(){
    List<Widget> widgets = <Widget>[
      IconButton(icon: Icon(Icons.smoking_rooms),
        iconSize: 64,
        onPressed: (){
          game.totalCigs +=game.cigsOnClick;
          setState(() {});
        },
      ),
      Text("Total Cigs: " + game.totalCigs.toString()),
      ListTile(title: Text("Upgrades"),)];
    for(Upgrade upgrade in game.upgrades){
      widgets.add(ListTile(
        leading: Icon(Icons.arrow_upward),
        title: Text(upgrade.title),
        subtitle: Text(upgrade.amountOwned.toString() + " owned"),
        onTap: (){
          if(game.totalCigs >= upgrade.cost){
            game.totalCigs -=upgrade.cost;
            upgrade.amountOwned++;
            if(upgrade.isPassive)
              game.cigsPerSecond +=upgrade.incrementAmount;
            else
              game.cigsOnClick +=upgrade.incrementAmount;
              setState(() {});
          }
        },
      ));
    }
    return widgets;
  }
  
}