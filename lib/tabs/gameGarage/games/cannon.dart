
import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:flame/flame.dart';
import 'package:flame/position.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'vector2D.dart';
import 'package:flame/flame.dart';
class Cannon extends Component {
  Cannon(){
    if(!Flame.images.loadedFiles.containsKey("CannonStand.png"))
      Flame.images.load("CannonStand.png");
    if(!Flame.images.loadedFiles.containsKey("CannonBarrel.png"))
      Flame.images.load("CannonBarrel.png");

    _cannonStand = SpriteComponent.fromSprite(64, 64, 
      Sprite.fromImage(Flame.images.loadedFiles["CannonStand.png"],
        x: 0,
        y: 0,
        width: 64,
        height: 64));
    _cannonStand.width = 64;
    _cannonStand.height = 64;

    _cannonBarrel = SpriteComponent.fromSprite(64, 64, 
      Sprite.fromImage(Flame.images.loadedFiles["CannonBarrel.png"],
        x: 0,
        y: 0,
        width: 64,
        height: 64));
    _cannonBarrel.width = 64;
    _cannonBarrel.height = 64;
  }
  
  bool active = true;
  SpriteComponent _cannonStand;
  SpriteComponent _cannonBarrel;
  @override
  void render(Canvas c) {
    // TODO: implement render
  }

  @override
  void update(double t) {
    // TODO: implement update
  }
  
}