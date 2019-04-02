import 'package:flutter/material.dart';
import 'package:tobaccoFreeAmarilloApp/tabs/gameGarage/games/tRex.dart';
import 'games/genericGame.dart';
import 'games/sidescroller.dart';
import 'games/golfGame.dart';
import 'games/game/trexgame.dart';
import 'games/clickerWrapper.dart';

//class GameGarage extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) => new Container();
//}
class GameGarage extends StatelessWidget {
  static List<GenericGame> _gamesList;
  GameGarage(BuildContext context){
    _gamesList = <GenericGame>[
    GolfGame(context,),
    TRex(context),
    ClickerWrapper(context),
    GenericGame(context),
    GenericGame(context),
  ];
  }
  //StatelessWidget _parent;
  //BuildContext _context;  
  //GameGarage(this._parent,this._context){
  //}
  final double spacingFactor = 25;
  final double buttonTextScaleFactor = 1.75;
  final double descriptionScaleFactor = 0.9;
  Widget build(BuildContext context) => new Container(
    child: _renderGameList()
  );
  ListView _renderGameList(){
    List<Widget> games = <Widget>[
      Center(child: Text("Game Garage!!",
      textScaleFactor: buttonTextScaleFactor,)),
      Divider(color: Colors.black26,)
    ];
    for(GenericGame game in _gamesList){
      games.add(
        ButtonTheme(
          padding:EdgeInsets.fromLTRB(20, 10, 20, 10),
          height: 125,
          child:
          RaisedButton(
            elevation: 25,
            splashColor: Colors.red,
            padding: const EdgeInsets.all(1.0),
            color: const Color.fromARGB(150, 0, 0, 250),
            child: Text(game.title),
            onPressed: (){
              game.open();
          },)
        )
      );
      /* (RaisedButton(
        child: RoundedRectangleBorder(
          child:
        Text(game.title,textScaleFactor: buttonTextScaleFactor,)),
        onPressed: (){
          //game.open();
        },
      )); */
    }
    return ListView(
      children: games,
    );
  }
  /*
  @override
  State<StatefulWidget> createState() {
    return GameGarageState();
  }
  */
  //non graphical methods
  //_exitWindow(){
  //  _parent.build(_context);
  //  this.;
  //}
}

class TicTac extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(primaryColor: Colors.black),
      home: new TicTac(),
    );
  }
/*
enum RunningModes
{
  Nothing,
  BouncyGame,
}

class GameGarageState extends State<GameGarage> {
  RunningModes mode;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container();
    
  }
  buildGameTemplate(){
  }

}*/}