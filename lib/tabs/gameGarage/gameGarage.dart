import 'package:flutter/material.dart';
import 'games/genericGame.dart';
import 'games/sidescroller.dart';

//class GameGarage extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) => new Container();
//}
class GameGarage extends StatelessWidget {
  static List<GenericGame> _gamesList;
  GameGarage(BuildContext context){
    _gamesList = <GenericGame>[
    SideScroller(context),
    GenericGame(context),
    GenericGame(context),
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
      games.add(RaisedButton(
        child: Center(child: Text(game.title,textScaleFactor: buttonTextScaleFactor,)),
        onPressed: (){
          //game.open();
        },
      ));
    }
    return ListView(
      children: games,
    );
  }
  /*
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return GameGarageState();
  }*/
    //non graphical methods
  //_exitWindow(){
  //  _parent.build(_context);
  //  this.;
  //}
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

}*/
