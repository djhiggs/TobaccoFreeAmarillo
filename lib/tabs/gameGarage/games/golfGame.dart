import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flame/components/component.dart';
import 'package:flame/flame.dart';
import 'package:flame/position.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flame/flame.dart' as flame;
import 'genericGame.dart';


import 'dart:math' as math;
import 'dart:ui';

import 'package:flame/anchor.dart';
import 'package:flame/palette.dart';
import 'sidescroller.dart';
//import 'package:box2d_flame/box2d.dart';
import 'vector2D.dart';
import 'golfBall.dart';

class GolfGame extends SideScroller{

  final double _diameter = 128;
  final double _floorHeight = 128;
  //Body golfBallBody;
  //World world;
  GolfBall golfBall;
  ui.Image grass;
  GolfGame(BuildContext context) : super(context){
    this.title = "Golf Game";
    Flame.images.load("Grass.png");
    grass = Flame.images.loadedFiles["Grass.png"];
    golfBall =GolfBall(context,_floorHeight);
  }
  @override
  void update(double dt) {
    // TODO: implement update
    golfBall.update(dt);
    super.update(dt);

  }
  @override
  void render(ui.Canvas canvas) {
    golfBall.render(canvas);
    camera =Position(0, golfBall.golfBallLocation.y);
    //for(int i = 0; i < 4; i++){
    //      canvas.drawImage(grass, p, paint);
    //}
    //super.render(canvas);
  }
}