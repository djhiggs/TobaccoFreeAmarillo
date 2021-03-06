
import 'dart:ui';
import 'package:flame/components/component.dart';
import 'package:flame/flame.dart';
import 'package:flame/position.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import '../vector2D.dart';
import 'golfGame.dart';
import 'golfBall.dart';
import 'dart:math';
class Cannon extends Component {
  BuildContext context;
  static Future<void> initialize() async{
    if(!Flame.images.loadedFiles.containsKey("CannonStand.png"))
      await Flame.images.load("CannonStand.png");
    if(!Flame.images.loadedFiles.containsKey("CannonBarrel.png"))
      await Flame.images.load("CannonBarrel.png");
    await GolfBall.initialize();
  }
  Cannon(this.context,this.screenSize){
    _cannonStand = SpriteComponent.fromSprite(64, 64, 
      Sprite.fromImage(Flame.images.loadedFiles["CannonStand.png"],
        x: 0,
        y: 0,
        width: 16,
        height: 16));
    _cannonStand.width = 64;
    _cannonStand.height = 64;

    _cannonBarrel = SpriteComponent.fromSprite(150, 30, 
      Sprite.fromImage(Flame.images.loadedFiles["CannonBarrel.png"],
        x: 0,
        y: 0,
        width: 10,
        height: 10));
    _cannonBarrel.width = 150;
    _cannonBarrel.height = 30;

    cannonPosition =Vector2D(0, 0);
    cannonHingePosition =Vector2D(screenSize.width/2,screenSize.height/2);
  }
  //DragUpdateDetails dragUpdateDetails = DragUpdateDetails();
  bool active = true;
  SpriteComponent _cannonStand;
  SpriteComponent _cannonBarrel;
  //relative to bottom left of cannon
  final Vector2D _cannonStandPos =Vector2D(64, 0); 
  final Vector2D cannonBarrelPos =Vector2D(64, 64);
  
  //
  //Anchor position;
  Vector2D cannonPosition; 
  Vector2D cannonHingePosition;
  double get screenHeight => screenSize.height;
  Size screenSize;
  @override
  void render(Canvas c) {

    _cannonStand.setByPosition(Position(cannonPosition.x + _cannonStandPos.x,
      screenHeight - _cannonStand.height - cannonPosition.y - _cannonStandPos.y));

    //_cannonBarrel.setByPosition(Position(cannonPosition.x + cannonBarrelPos.x,
    //  screenHeight - _cannonBarrel.height - cannonPosition.y - cannonBarrelPos.y));
    //_cannonBarrel.setByPosition(Position(-16,8));
    _cannonBarrel.setByPosition((cannonHingePosition + Vector2D(-_cannonBarrel.width/3, -_cannonBarrel.height/2).rotate(_cannonBarrel.angle)).toPosition());
    //_cannonBarrel.angle = 0;
    //_cannonStand.render(c);
    _cannonBarrel.render(c);
  }
  //Position screenPosition; 
  void setAimState(Vector2D pressPos){
    pressPos -= cannonHingePosition;
    if(pressPos.x < 0){
      setAngle(pressPos.angle() + pi);
      power =pressPos.length()*50;
    }
  }
  void setAngle(double angle) => _cannonBarrel.angle =angle;
  ///fire power (acceleration) in pixels per second^2
  double power = 0;//user's desired firing power
  void fire(GolfGame game){
    var direction = Vector2D.fromAngle(-_cannonBarrel.angle);
    var velocity =direction*power;
    if(game.golfBall ==null){
      game.golfBall =GolfBall(screenHeight,cannonHingePosition);
      game.golfBall.velocity =velocity;
      game.components.add(game.golfBall);
      
    }
    else{
      game.golfBall.golfBallLocation =cannonHingePosition;
      game.golfBall.velocity =velocity;
    }

  }

  @override
  void update(double t) {
  } 
}