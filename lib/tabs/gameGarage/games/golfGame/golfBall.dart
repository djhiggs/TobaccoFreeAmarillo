
import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:flame/flame.dart';
import 'package:flame/position.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import '../vector2D.dart';
import 'golfGame.dart';

class GolfBall extends Component{
  SpriteComponent _component;
  static final double diameter = 32;
  Vector2D initialLocation;
  Vector2D golfBallLocation;
  Vector2D velocity;
  final Vector2D g = Vector2D(0, -9.81E-1)*GolfGame.pixelsPerMeter;
  int _floorHeight;
  bool stopped = false;
  BuildContext _context;
  //returns the distance traveled in meters
  double distanceTraveled() => 
  (golfBallLocation - initialLocation).length()/GolfGame.pixelsPerMeter;

  GolfBall(this._context, this._floorHeight,this.golfBallLocation){
        initialLocation =golfBallLocation;
    if(!Flame.images.loadedFiles.containsKey("GolfBall.png"))
      throw Exception("Item not found!!!!");
      //await Flame.images.load("GolfBall.png");
    _component = SpriteComponent.fromSprite(diameter, diameter, 
      Sprite.fromImage(
        Flame.images.loadedFiles["GolfBall.png"],
        x: 0,
        y: 0,
        width: diameter,
        height: diameter,
      )
    );
    _component.width = diameter;
    _component.height = diameter;
  }
  void update(double dt){
    if(golfBallLocation.y - _floorHeight - diameter/2 < 4){
      if(velocity.length() < 7){
        stopped = true;
        return;
      }
    }
    velocity += g*dt;
    golfBallLocation += velocity*dt;
    velocity += g*dt;
    if(golfBallLocation.y - diameter/2 <= _floorHeight && velocity.y < 0){
      velocity.y *= -0.8;
      velocity.x *= 0.8;
      golfBallLocation.y = _floorHeight.toDouble() + diameter/2;
    }
    screenPosition = Position(golfBallLocation.x - diameter/2,MediaQuery.of(_context).size.height-diameter/2-golfBallLocation.y);
    _component.setByPosition(screenPosition);
  }
  Position screenPosition;
  void render(Canvas canvas) {
    _component.render(canvas);
  }
}