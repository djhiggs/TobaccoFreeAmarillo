import 'package:flutter/material.dart';
import 'package:spritewidget/spritewidget.dart';
import 'package:spritewidget/spritewidget.dart' as spriteWidget;
import 'gameTemplate.dart';

//class GameGarage extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) => new Container();
//}
class GameGarage extends StatefulWidget {
  static List<Game> _gamesList = <Game>[
    Game(null,"First Game"),
    Game(null,"Second Game"),
    Game(null,"Third Game"),
    Game(null,"Fourth Game"),
    Game(null,"Fifth Game"),
  ];
  //StatelessWidget _parent;
  //BuildContext _context;  
  //GameGarage(this._parent,this._context){
  //}
  final double spacingFactor = 25;
  final double buttonTextScaleFactor = 1.75;
  final double descriptionScaleFactor = 0.9;
  @override
  Widget build(BuildContext context) => new Container(
    child: _renderGameList()
  );
  ListView _renderGameList(){
    List<Widget> games = <Widget>[
      Center(child: Text("Game Garage!!",
      textScaleFactor: buttonTextScaleFactor,)),
      Divider(color: Colors.black26,)
    ];
    
    for(Game game in _gamesList){
      games.add(ListTile(
        title: Center(child: Text(game.title,textScaleFactor: buttonTextScaleFactor,)),
        onTap: (){

        },
      ));
    }
    return ListView(
      children: games,
    );
  }
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return null;
  }
    //non graphical methods
  //_exitWindow(){
  //  _parent.build(_context);
  //  this.;
  //}
}
enum RunningModes
{
  Nothing,
  BouncyGame,
}
class GameGarageState extends State<GameGarage> {
  RunningModes mode;
  @override
  Widget build(BuildContext context){
    switch (mode) {
      case RunningModes.Nothing:
        
        break;
      case RunningModes.BouncyGame:

        break;
      default:
    }
  }
  buildGameTemplate(){
  }

}