import 'dart:ui';
import 'package:flame/components/component.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import '../genericGame.dart';
import 'package:flame/position.dart';
import 'package:flutter/material.dart';
import '../vector2D.dart';


class Background extends Component{
  static const int _HORIZONTAL_TILE_COUNT = 2;
  GenericGame game;
  Position get camera => game.camera;
  Vector2D lastCameraPos;
  Size screenSize;
  List<SpriteComponent> slides;
  List<double> scales;

  Background(this.game,this.lastCameraPos,this.screenSize){
    
  }
  void _load() async{
    List<String> names = <String>[

    ];
    scales = <double>[

    ];
    for(var name in names){
      if(!Flame.images.loadedFiles.containsKey(name))
        await Flame.images.load(name);
      var image = Flame.images.loadedFiles[name];
      slides.add(
        SpriteComponent.fromSprite(
          image.width.toDouble(), 
          image.height.toDouble(), 
          Sprite.fromImage(image))
      );
    }

    
  }

  @override
  void render(Canvas c) {
    for(var slide in slides)
      slide.render(c);
  }

  @override
  void update(double t) {
    Vector2D newCameraPos = Vector2D(camera.x,camera.y);
    Vector2D dS = newCameraPos - lastCameraPos;
    
    for(int i = 0; i < slides.length; i++){
      slides[i].x += dS.x*scales[i];
      if(slides[i].x + slides[i].width <= camera.x){
        slides[i].x += slides[i].width*_HORIZONTAL_TILE_COUNT;
      }
    }
    lastCameraPos = newCameraPos;
  }

}