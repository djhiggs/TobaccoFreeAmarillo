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
  Sprite grass;
  BuildContext context;
  GolfGame(this.context) : super(context){
    this.title = "Golf Game";
    Flame.images.load("Grass.png");
    grass = Sprite.fromImage(Flame.images.loadedFiles["Grass.png"],
      x: 0,
      y: 0,
      width: 32,
      height: 32);
    var y = MediaQuery.of(context).size.height - _floorHeight;
    for(int i = 0; i < 100; i++){
      for(int j = 0; j < 10; j++){
        var c = SpriteComponent.fromSprite(32, 32, grass);
        c.y = y + j*32;
        c.x = i*32.0;
        components.add(c);
      }

    }

    golfBall =GolfBall(context,_floorHeight);
    components.add(golfBall);
  }
  @override
  void update(double dt) {

    //golfBall.update(dt);
    super.update(dt);

  }
  @override
  void render(ui.Canvas canvas) {
    //camera =golfBall.screenPosition;
    //golfBall.render(canvas);
    //for(int i = 0; i < 4; i++){
    //      canvas.drawImage(grass, p, paint);
    //}
    if(golfBall !=null && golfBall.screenPosition !=null)
      camera =Position(golfBall.screenPosition.x - MediaQuery.of(context).size.width/2,golfBall.screenPosition.y - MediaQuery.of(context).size.height/2);
    super.render(canvas);
  }
}