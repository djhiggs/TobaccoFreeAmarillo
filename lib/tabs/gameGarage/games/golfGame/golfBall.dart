
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
  static final double radius =diameter/2;
  double screenHeight;
  Vector2D initialLocation;
  Vector2D golfBallLocation;
  Vector2D velocity;
  final Vector2D g = Vector2D(0, -9.81E-1)*GolfGame.pixelsPerMeter;
  bool stopped = false;
  static Future<void> initialize() async => 
    await Flame.images.load("GolfBall.png");
  //returns the distance traveled in meters
  double distanceTraveled() => 
  (golfBallLocation - initialLocation).length()/GolfGame.pixelsPerMeter;

  GolfBall(this.screenHeight, this.golfBallLocation){
        initialLocation =golfBallLocation;
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
    if(golfBallLocation.y - diameter/2 < 4){
      if(velocity.length() < 7){
        stopped = true;
        return;
      }
    }
    velocity += g*dt;
    golfBallLocation +=velocity*dt;
    
  }
  void render(Canvas canvas) {
    _component.x =golfBallLocation.x - radius;
    _component.y =screenHeight - golfBallLocation.y - diameter;
    _component.render(canvas);
  }
}