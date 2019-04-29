import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flame/components/component.dart';
import 'package:flame/flame.dart';
import 'package:flame/position.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flame/flame.dart' as flame;
import '../genericGame.dart';

import 'dart:math' as math;
import 'dart:ui';

import 'package:flame/anchor.dart';
import 'package:flame/palette.dart';
//import 'package:box2d_flame/box2d.dart';
import '../vector2D.dart';
import 'golfBall.dart';
import 'cannon.dart';
import 'dart:async';

class GolfGame extends GenericGame {
  static final double pixelsPerMeter =
      GolfBall.diameter / 63E-3; //pixels / meters
  final int _floorHeight = 128;
  //Body golfBallBody;
  //World world;
  GolfBall golfBall;

  Sprite grass;
  BuildContext context;
  Cannon cannon;
  List<List<SpriteComponent>> ground;
  Size size;
  GolfGame(this.context) : super(context) {
    this.title = "Golf Game";
    Flame.images.load("GolfBall.png");
    size = MediaQuery.of(context).size;
    Flame.images.load("Grass.png").whenComplete(() {
      grass = Sprite.fromImage(Flame.images.loadedFiles["Grass.png"],
          x: 0, y: 0, width: 32, height: 32);
      var y = size.height - _floorHeight;
      var x = size.width ~/ 32 + 3;
      ground = List();
      for (int i = 0; i < x; i++) {
        ground.add(List());
        for (int j = 0; j < 10; j++) {
          var c = SpriteComponent.fromSprite(32, 32, grass);
          c.y = y + j * 32;
          c.x = i * 32.0;
          ground[i].add(c);
          components.add(c);
        }
      }
    });
    cannon = Cannon(context, _floorHeight);
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
  }
  bool stopped = false;
  @override
  void render(ui.Canvas canvas) {
    if (golfBall != null && golfBall.screenPosition != null) {
      camera = Position(
          golfBall.screenPosition.x - MediaQuery.of(context).size.width / 2,
          golfBall.screenPosition.y - MediaQuery.of(context).size.height / 2);
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
    return super.open();
  }
  @override
  void update(double dt) {
    if (ground[0][0].x < camera.x - 16) {
      double x_0 = (camera.x ~/ 32) * 32.0;

      for (int i = 0; i < ground.length; i++) {
        for (int j = 0; j < ground[i].length; j++) {
          ground[i][j].x = x_0 + i * 32.0;
        }
      }
    }
    super.update(dt);
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
