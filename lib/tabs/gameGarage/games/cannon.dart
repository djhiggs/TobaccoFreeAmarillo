
import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:flame/flame.dart';
import 'package:flame/position.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'vector2D.dart';
import 'package:flame/flame.dart';
class Cannon extends Component {
  final _width = 128;
  final _height = 128;
  BuildContext _context;
  int _floorHeight;
  Cannon(this._context,this._floorHeight){
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
    _cannonBarrel.width = 100;
    _cannonBarrel.height = 40;
  }
  
  bool active = true;
  SpriteComponent _cannonStand;
  SpriteComponent _cannonBarrel;
  @override
  void render(Canvas c) {
    if(_cannonStand.y == 0){
      var screenHeight = MediaQuery.of(_context).size.height;
      _cannonStand.y = screenHeight - _height;
      _cannonBarrel.y = screenHeight - 60;
    }
  }
  Position screenPosition; 
  @override
  void update(double t) {
    screenPosition = Position(_cannonStand.x,MediaQuery.of(_context).size.height-_cannonStand.height-_cannonStand.y+128);
    // TODO: implement update
  }
  
}