import 'dart:ui';
import 'package:flame/components/component.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'golfGame.dart';
import 'package:flame/position.dart';
import 'package:flutter/material.dart';
import '../vector2D.dart';


class Background extends Component{
  static const int _HORIZONTAL_TILE_COUNT =2;
  GolfGame game;
  Position get camera => game.camera;
  double lastCameraPosX;
  Size screenSize;
  List<SpriteComponent> _slides =List();
  List<double> scales =List();
  List<Vector2D> position = List();
  static List<String> _names;
  static const double VIRTICAL_SHIFT = 260;

  Background(this.game,this.lastCameraPosX,this.screenSize){
    double n = 0.1;
    for(int i = 1; i <= _names.length; i++){
      n *= 1.21;
      scales.add(n);
    }
    for(var name in _names){
      for(int i = 0; i < _HORIZONTAL_TILE_COUNT; i++){
        var image = Flame.images.loadedFiles[name];
        var sprite = Sprite.fromImage(image);
        var spriteComponent = SpriteComponent.fromSprite(
          image.width.toDouble(), 
          image.height.toDouble(),sprite);
        position.add(Vector2D(i*spriteComponent.width,screenSize.height-spriteComponent.height));
        _slides.add(spriteComponent);
        game.components.add(spriteComponent);
      }
    }

    position.last.x += _slides.last.width*3;
    _slides.last.width *=4;
    _slides.last.height *=4;

    _slides[_slides.length-2].width *=4;
    _slides[_slides.length-2].height *=4;

    for(int i = _slides.length - 1; i >= 0; i--)
      game.components.add(_slides[i]);


  }
  static Future<void> initialize() async{
    _names = List();
    for(int i = 1; i <= 11; i++)
      _names.add("golfGame/background/back($i).png");

    for(var name in _names)
      if(!Flame.images.loadedFiles.containsKey(name))
        await Flame.images.load(name);
  }

  @override
  void render(Canvas c) {
    //slides[0].setByPosition(camera);
    for(int i = _slides.length - 1; i >= 0; i--){
      //position[i] =Vector2D(0, floorHeight);
      _slides[i].setByPosition((position[i]+Vector2D(0, camera.y*0)).toPosition());
      //slides[i].render(c);
    }
  }

  @override
  void update(double t) {
    double newCameraPosX = camera.x;
    double dx = newCameraPosX - lastCameraPosX;
    
    for(int i = 0; i < _slides.length; i++){
      //relativePos[i].x -= dS.x*scales[i~/_HORIZONTAL_TILE_COUNT];
      position[i].x += dx*scales[i~/_HORIZONTAL_TILE_COUNT];
      position[i].y = screenSize.height-_slides[i].height + VIRTICAL_SHIFT + camera.y*scales[i~/_HORIZONTAL_TILE_COUNT];
      if(position[i].x + _slides[i].width <= camera.x){
        position[i].x += _slides[i].width*_HORIZONTAL_TILE_COUNT;
      }
    }
    lastCameraPosX = newCameraPosX;
  }

}