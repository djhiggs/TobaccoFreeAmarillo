import 'package:flutter/material.dart';
import 'games/tfRunner.dart';
import 'games/genericGame.dart';
import 'games/golfGame/golfGame.dart';
import 'games/cigClick/cigClick.dart';
import 'games/snake/snakeInterface.dart';
import '../settings/database.dart';

//class GameGarage extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) => new Container();
//}
class GameGarage extends StatelessWidget {
  static GameGarage _instance;
  static List<GenericGame> _gamesList;
  Database db;
  void setPointCount(int n) => db.setLocal("PointAmount", n);
  int getPointCount() {
    int amnt = db["PointAmount"];
    if(amnt == null){
      setPointCount(0);
      return 0;
    }
    return amnt;
  }
  static getInstance(BuildContext context){
    if(_instance ==null)
      _instance =GameGarage(context);
    return _instance;
  }
  GameGarage(BuildContext context){
    _gamesList = <GenericGame>[
      GolfGame(context,),
      TFVan(context),
      CigClick(context),
      SnakeInterface(context),
      //GenericGame(context,200),
    ];
    db = Database.getLoadedInstance();
  }
  //StatelessWidget _parent;
  //BuildContext _context;  
  //GameGarage(this._parent,this._context){
  //}
  final double spacingFactor = 25;
  final double buttonTextScaleFactor = 1.75;
  final double descriptionScaleFactor = 0.9;
  //final List<> achievements;
  Widget build(BuildContext context) {

    return Scaffold(
      body: ListView.builder(
        itemCount: _gamesList.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 8.0,
            margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
            child: Container(
                decoration:
                    BoxDecoration(
                      color: Theme.of(context).primaryColor,
                    ),
                child: makeListTile(index,context)),
          );
        },
      ),
    );
  }
    Widget makeListTile(index,BuildContext context){ 
      if(_gamesList[index].purchased)
        return ListTile(
          //When tile is tapped navigate to details page
          onTap: () {
            if(_gamesList[index].purchased)
              _gamesList[index].open();
            else if(getPointCount() > _gamesList[index].price){
              showDialog(
                context: context,
                builder: (BuildContext c) => AlertDialog(title: 
                  Text("Are you wish you would like to purchase " + _gamesList[index].title + "?"),
                    actions: <Widget>[
                      RaisedButton(
                        child: Text("Purchase"),
                        onPressed: (){
                          setPointCount(getPointCount() - _gamesList[index].price);
                          _gamesList[index].purchase();
                          Navigator.of(context).pop();
                        },
                      ),
                      RaisedButton(
                        child: Text("Cancel"),
                        onPressed: () =>
                          Navigator.of(context).pop(),
                      )
                    ],
                  ),
                );
            }
            else{
              showDialog(
                context: context,
                builder: (BuildContext c) => AlertDialog(title: 
                  Text("Insufficient Funds"),
                    actions: <Widget>[
                      RaisedButton(
                        child: Text("Continue"),
                        onPressed: (){
                          Navigator.of(context).pop();
                        },
                        textColor: Colors.white,
                      )
                    ],
                  ),
              );
            }
          },
          contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Container(
            padding: EdgeInsets.only(right: 12.0),
            decoration: new BoxDecoration(
                border: new Border(
                    right: new BorderSide(width: 1.0, color: Colors.white24))),
            child: Icon(Icons.gamepad, color: Colors.white),
          ),
          title: Text(
            _gamesList[index].title,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          // Show the points you can get from completing this achievement
          subtitle: Row(
            children: <Widget>[
              Text(
                  _gamesList[index].description,
                  style: TextStyle(color: Colors.white))
            ],
          ),
          trailing:
              Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0));
          else
            return Container(
              decoration: BoxDecoration(color: Colors.black38),
              child: ListTile(
          //When tile is tapped navigate to details page
          onTap: () {
            if(_gamesList[index].purchased)
              _gamesList[index].open();
            else if(getPointCount() > _gamesList[index].price){
              showDialog(
                context: context,
                builder: (BuildContext c) => AlertDialog(title: 
                  Text("Are you wish you would like to purchase " + _gamesList[index].title + "?"),
                    actions: <Widget>[
                      RaisedButton(
                        child: Text("Purchase"),
                        onPressed: (){
                          setPointCount(getPointCount() - _gamesList[index].price);
                          _gamesList[index].purchase();
                          Navigator.of(context).pop();
                        },
                      ),
                      RaisedButton(
                        child: Text("Cancel"),
                        onPressed: () =>
                          Navigator.of(context).pop(),
                      )
                    ],
                  ),
                );
            }
            else{
              showDialog(
                context: context,
                builder: (BuildContext c) => AlertDialog(title: 
                  Text("Insufficient Funds"),
                    actions: <Widget>[
                      RaisedButton(
                        child: Text("Continue"),
                        onPressed: (){
                          Navigator.of(context).pop();
                        },
                        textColor: Colors.white,
                      )
                    ],
                  ),
              );
            }
          },
          contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Container(
            padding: EdgeInsets.only(right: 12.0),
            decoration: new BoxDecoration(
                border: new Border(
                    right: new BorderSide(width: 1.0, color: Colors.white24))),
            child: Icon(Icons.gamepad, color: Colors.white),
          ),
          title: Row(children: <Widget>[
            Text(
              _gamesList[index].title,
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            Text(
              "Price: " + _gamesList[index].price.toString(),
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          ),
          // Show the points you can get from completing this achievement
          subtitle: Text(
            _gamesList[index].description,
            style: TextStyle(color: Colors.white)),
          trailing: 
              Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0)),
            );
    }
}