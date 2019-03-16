import 'package:flutter/material.dart';
import 'package:tobaccoFreeAmarilloApp/gameGarage.dart';

class Dashboard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => DashboardState();
  
}
class DashboardState extends State<Dashboard> {
  bool _gameGarageClosed =true;
  @override
  Widget build(BuildContext context) { 
    if(_gameGarageClosed)
      return new Container(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new Icon(
              Icons.dashboard,
              size: 150.0,
              color: Colors.black12
            ),
            new Text('Dashboard tab content'),
            new FlatButton(onPressed: (){
              setState(() {
                _gameGarageClosed =false;
              });
            }, child: Text("Open Game Garage"),)
          ]
        ),
      );
    else{
      GameGarage garage =GameGarage();
      return garage.build(context);
    }
  }
}