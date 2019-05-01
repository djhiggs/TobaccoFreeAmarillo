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
  }

  static Future<void> initialize() async{
    await Cannon.initialize();
    await Terrain.initialize();
    await Background.initialize();
  }

  bool stopped = false;
  @override
  void render(ui.Canvas canvas) {
    if (golfBall != null) {
      camera = Position(
          golfBall.golfBallLocation.x - size.width / 2,
          golfBall.golfBallLocation.y > size.height*2/5?
          size.height / 2 - golfBall.golfBallLocation.y:
          size.height/10);
    }
    super.render(canvas);
  }

  @override
  close() {
    stopped = true;
    return super.close();
  }
  @override
  open() {
    stopped = false;
    size = MediaQuery.of(context).size;

    background = Background(this, camera.x, size);
    components.add(background);

    terrain =Terrain(this, size);
    components.add(terrain);

    cannon = Cannon(context);
    components.add(cannon);

    Flame.util.addGestureRecognizer(PanGestureRecognizer()
      ..onUpdate = (DragUpdateDetails details) {
        var pressPos = Vector2D.fromOffset(details.globalPosition);
        //pressPos.y =cannon.screenHeight - pressPos.y;

        cannon.setAimState(pressPos);
      }
      ..onEnd = (DragEndDetails details) {
        cannon.fire(this);
      });
    return super.open();
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
        title: Counter(this),
      ),
      body: super.widget);
}

class Counter extends StatefulWidget {
  Counter(this.golfGame);
  final GolfGame golfGame;
  @override
  CounterState createState() => CounterState(golfGame);
}

class CounterState extends State<Counter> {
  void update() => setState(() {});
  CounterState(this.golfGame);
  GolfGame golfGame;
  @override
  Widget build(BuildContext context) {
    if (!golfGame.stopped)
      Timer(Duration(milliseconds: 100), () => setState(() {}));
    return Text(golfGame.golfBall == null
        ? "0 Meters"
        : (golfGame.golfBall.distanceTraveled().toInt().toString() +
            " Meters"));
  }
}
