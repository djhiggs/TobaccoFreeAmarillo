import 'dart:ui';
import 'package:flame/components/component.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import '../genericGame.dart';
import 'package:flame/position.dart';
import 'package:flutter/material.dart';
import '../vector2D.dart';


class Background extends Component{
  static const int _HORIZONTAL_TILE_COUNT =2;
  GenericGame game;
  Position get camera => game.camera;
  double lastCameraPos_x;
  Size screenSize;
  List<SpriteComponent> slides =List();
  List<double> scales =List();
  List<Vector2D> position = List();
  double floorHeight;

  Background(this.game,this.lastCameraPos_x,this.screenSize,this.floorHeight);
  Future<void> load() async{
    List<String> names = <String>[
      
    ];
    double n = 0.5;
    for(int i = 1; i <= 11; i++){
      names.add("golfGame/background/back($i).png");
      n *= 0.5;
      scales.add(n);
    }
    for(var name in names){
      if(!Flame.images.loadedFiles.containsKey(name))
        await Flame.images.load(name);
      for(int i = 0; i < _HORIZONTAL_TILE_COUNT; i++){
        var image = Flame.images.loadedFiles[name];
        var sprite = Sprite.fromImage(image);
        var spriteComponent = SpriteComponent.fromSprite(
          image.width.toDouble(), 
          image.height.toDouble(),sprite);
        position.add(Vector2D(i*spriteComponent.width,screenSize.height-spriteComponent.height));
        slides.add(spriteComponent);
        game.components.add(spriteComponent);
      }
    }
    for(int i = slides.length - 1; i >= 0; i--)
      game.components.add(slides[i]);
  }

  @override
  void render(Canvas c) {
    //slides[0].setByPosition(camera);
    for(int i = slides.length - 1; i >= 0; i--){
      //position[i] =Vector2D(0, floorHeight);
      slides[i].setByPosition(position[i].toPosition());
      //slides[i].render(c);
    }
  }

  @override
  void update(double t) {
    double newCameraPos_x = camera.x;
    double dx = newCameraPos_x - lastCameraPos_x;
    
    for(int i = 0; i < slides.length; i++){
      //relativePos[i].x -= dS.x*scales[i~/_HORIZONTAL_TILE_COUNT];
      position[i].x -= dx*scales[i~/_HORIZONTAL_TILE_COUNT];
      position[i].y = screenSize.height-slides[i].height + camera.y*scales[i~/_HORIZONTAL_TILE_COUNT];
      if(position[i].x + slides[i].width <= camera.x){
        position[i].x += slides[i].width*_HORIZONTAL_TILE_COUNT;
      }
    }
    lastCameraPos_x = newCameraPos_x;
  }

}