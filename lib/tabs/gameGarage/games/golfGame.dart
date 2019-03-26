import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flame/components/component.dart';
import 'package:flame/flame.dart';
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
import 'package:box2d_flame/box2d.dart';
import 'vector2D.dart';

class GolfGame extends SideScroller{
  final double g = -9.81;
  Vector2D golfBallLocation;
  Vector2D golfBallVelocity;
  GolfGame(BuildContext context) : super(context){
    this.title = "Golf Game";
    Flame.images.load("Grass.png");
  }
  @override
  start() {
    
  }
  @override
  stop() {

  }
  @override
  void render(ui.Canvas canvas) {
    camera =golfBallLocation.tpPosition();
    super.render(canvas);
  }
} 