import 'dart:ui' as ui;
import 'package:flame/components/component.dart';
import 'package:flame/flame.dart';
import 'package:flame/position.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../genericGame.dart';
import '../vector2D.dart';
import 'golfBall.dart';
import 'cannon.dart';
import 'dart:async';
import 'background.dart';
import 'terrain.dart';
import '../../../settings/database.dart';

enum GameStates {
  Aiming,
  Fired,
  Paused,
  Stopped,
}
class GolfGame extends GenericGame {
  static final double pixelsPerMeter =
      GolfBall.diameter / 63E-3; //pixels / meters
  GolfBall golfBall;

  Sprite grass;
  BuildContext context;
  Cannon cannon;
  Background background;
  Terrain terrain;

  Size size;
  GolfGame(this.context) : super(context) {
    this.title = "Snuff Shot";
    this.description = "Toss that wacky tobacky away!";
    Flame.util.addGestureRecognizer(PanGestureRecognizer()
      ..onUpdate = (DragUpdateDetails details) {
        if(gameState ==GameStates.Aiming){
          var pressPos = Vector2D.fromOffset(details.globalPosition);
          
          cannon.setAimState(pressPos);
        }
      }
      ..onEnd = (DragEndDetails details) {
        if(gameState == GameStates.Aiming){
          cannon.fire(this);
          gameState = GameStates.Fired;
        }
      });
  }

  static Future<void> initialize() async{
    await Cannon.initialize();
    await Terrain.initialize();
    await Background.initialize();
  }

  GameStates gameState;
  @override
  void render(ui.Canvas canvas) {
    switch (gameState) {
      case GameStates.Aiming:
        camera = Position(
          cannon.cannonHingePosition.x - size.width / 2,
          cannon.cannonHingePosition.y > size.height*2/5?
          size.height / 2 - cannon.cannonHingePosition.y:
          size.height/10);
        break;
      case GameStates.Fired:
      case GameStates.Paused:
        camera = Position(
          golfBall.golfBallLocation.x - size.width / 2,
          golfBall.golfBallLocation.y > size.height*2/5?
          size.height / 2 - golfBall.golfBallLocation.y:
          size.height/10);
        break;
      default:
    }
    super.render(canvas);
  }

  @override
  close() {
    _unload();
    return super.close();
  }
  @override
  open() {
    _load();

    return super.open();
  }
  void restart(){
    _unload();
    _load();
  }
  void _load(){
    size = MediaQuery.of(context).size;

    background = Background(this, camera.x, size);
    components.add(background);

    terrain =Terrain(this, size);
    components.add(terrain);

    cannon = Cannon(context,size);
    components.add(cannon);
    gameState =GameStates.Aiming;
  }
  void _unload(){
    gameState = GameStates.Stopped;
    components.clear();
    golfBall =null;
  }
  @override
  Widget get widget => Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            close();
          },
        ),
        title: GolfGameUi(this),
      ),
      body: gameState ==GameStates.Paused? _buildFinished():super.widget);
  Widget _buildFinished(){
    var db =Database.getLoadedInstance();
    var lastBest = db["GolfGamePreviousBest"] as int;
    var current = golfBall.distanceTraveled().toInt();
    Navigator.of(context);
    if(lastBest < current)
      db.setLocal("GolfGamePreviousBest", current);
    return Column(
      children: <Widget>[
        Text("Distance Traveled"),
        Text(current.toInt().toString() + " Meters"),

        Text("Previous Best"),
        Text(lastBest.toInt().toString() + " Meters"),

        RaisedButton(
          child: Text("Retry"),
          onPressed: () => restart(),
        ),
      ],
    );
  }
}

class GolfGameUi extends StatefulWidget {
  GolfGameUi(this.golfGame);
  final GolfGame golfGame;
  @override
  GolfGameUiState createState() => GolfGameUiState(golfGame);
}

class GolfGameUiState extends State<GolfGameUi> {
  void update() => setState(() {});
  GolfGameUiState(this.golfGame);
  GolfGame golfGame;
  @override
  Widget build(BuildContext context) {
    if (golfGame.gameState !=GameStates.Stopped && golfGame.gameState !=GameStates.Paused)
      Timer(Duration(milliseconds: 100), () => setState(() {}));
    if(golfGame.gameState ==GameStates.Aiming)
      return Text("F = " + ((golfGame.cannon.power*GolfBall.MASS/GolfGame.pixelsPerMeter*100).round()/100.0).toString() + " Newtons");
    else if(golfGame.gameState ==GameStates.Fired){
      if(golfGame.golfBall.stopped){
        golfGame.gameState =GameStates.Paused;
        Navigator.of(context).setState((){});
      }
      else
        return Text(golfGame.golfBall.distanceTraveled().toInt().toString() + " Meters");
    }
    if(golfGame.gameState ==GameStates.Paused)
      return Text("Results",textScaleFactor: 1.4);

  }
}
