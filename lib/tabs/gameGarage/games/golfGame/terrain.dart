import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';

import 'golfBall.dart';
import 'golfGame.dart';
import 'package:flame/flame.dart';
import 'collidable.dart';

class Terrain extends Component{
  GolfGame golfGame;
  GolfBall get golfBall => golfGame.golfBall;
  Size _screenSize;
  List<Collidable> _collidables = List();
  List<SpriteComponent> _groundTiles = List();
  static Sprite _groundSprite; 
  static int _spriteWidth;
  int _renderWidth;

  Terrain(this.golfGame,this._screenSize){
    if(_groundSprite ==null)
      throw Exception("ERROR - Class has not been initialized!!");

    //ground
    int width = (_screenSize.width/_spriteWidth).ceil() + 2;
    int height = (_screenSize.height/(2*_spriteWidth)).ceil();

    _renderWidth =width*_spriteWidth;

    for(int i = 0; i < width; i++){
      for(int j = 0; j < height; j++){
        SpriteComponent spriteComponent = SpriteComponent.fromSprite(_spriteWidth.toDouble(), _spriteWidth.toDouble(), _groundSprite);
        spriteComponent.x = i*_spriteWidth.toDouble();
        spriteComponent.y = j*_spriteWidth.toDouble() + _screenSize.height;
        _groundTiles.add(spriteComponent);
      }
    }
    golfGame.components.addAll(_groundTiles);

    //collidables
    for(int i = 0; i < 50; i++){
      Collidable c =Collidable(golfGame,_screenSize.height);
      c.replace();
      c.spriteComponent.x = (i*100).toDouble();
      _collidables.add(c);
      golfGame.components.add(c);
    }
  }
  
  static Future<void> initialize() async{
    await Collidable.intitialize();
    if(_groundSprite ==null)
      _groundSprite = Sprite.fromImage(await Flame.images.load("Grass.png"));
    var img = Flame.images.loadedFiles["Grass.png"];
    _spriteWidth = img.width;
    _groundSprite = Sprite.fromImage(img);
  }

  @override
  void render(Canvas c) {
  }

  @override
  void update(double t) {
    //move over tiles
    for(var groundTile in _groundTiles)
      if(groundTile.x + _spriteWidth < golfGame.camera.x)
        groundTile.x += _renderWidth;
  }
  
}