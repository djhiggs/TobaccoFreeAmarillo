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
  //final List<> achievements;
  Widget build(BuildContext context) {
    ListTile makeListTile(index) => ListTile(
        //When tile is tapped navigate to details page
        onTap: () {
          _gamesList[index].open();
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
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        // Show the points you can get from completing this achievement
        subtitle: Row(
          children: <Widget>[
            Text(
                _gamesList[index].description,
                style: TextStyle(color: Colors.white))
          ],
        ),
        // Show the difficulty of the achievement
        //subtitle: Row(
        //children: <Widget>[
        //Icon(Icons.linear_scale, color: Colors.yellowAccent),
        //Text(" Intermediate", style: TextStyle(color: Colors.white))
        //],
        //),
        trailing:
            Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0));
    return Scaffold(
      body: ListView.builder(
        itemCount: _gamesList.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 8.0,
            margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
            child: Container(
                decoration:
                    BoxDecoration(
                      color: Colors.blueGrey,
                    ),
                child: makeListTile(index)),
          );
        },
      ),
    );
  }
    //child: _renderGameList()
  /* ListView _renderGameList(){
    List<Widget> games = <Widget>[];
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
    }
    return ListView(
      children: games,
    ); */
  
}