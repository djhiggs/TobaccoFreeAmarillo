
import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:flame/flame.dart';
import 'package:flame/position.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import '../vector2D.dart';

class GolfBall extends Component{
  SpriteComponent _component;
  final double _diameter = 32;
  Vector2D golfBallLocation = Vector2D(0, 0);
  Vector2D golfBallVelocity =Vector2D(40, 400);
  final Vector2D g = Vector2D(0, -128);
  double _floorHeight;
  BuildContext _context;
  GolfBall(this._context, this._floorHeight){
    if(!Flame.images.loadedFiles.containsKey("GolfBall.png"))
      Flame.images.load("GolfBall.png");
    _component = SpriteComponent.fromSprite(_diameter, _diameter, 
      Sprite.fromImage(
        Flame.images.loadedFiles["GolfBall.png"],
        x: 0,
        y: 0,
        width: _diameter,
        height: _diameter,
      )
    );
    golfBallLocation.y = this._floorHeight;
    _component.width = _diameter;
    _component.height = _diameter;
  }
  void update(double dt){
    if(golfBallLocation.y < _floorHeight)
      golfBallLocation += (golfBallVelocity + g*0.5*dt)*dt;
    else
      golfBallLocation += golfBallVelocity*dt;
    golfBallVelocity += g*dt;
    if(golfBallLocation.y < _floorHeight && golfBallVelocity.y < 0){
      golfBallVelocity.y *= -0.8;
      golfBallVelocity.x *= 0.8;
    }
  }
  Position screenPosition;
  void render(Canvas canvas) {
    screenPosition = Position(golfBallLocation.x,MediaQuery.of(_context).size.height-_diameter-golfBallLocation.y);
    _component.setByPosition(screenPosition);
    //_component.setByPosition(Position(0,0));
    _component.render(canvas);
  }
}