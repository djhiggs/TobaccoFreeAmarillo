import 'dart:ui';
import 'package:flame/components/component.dart';
import 'package:vector_math/vector_math_64.dart';
import '../genericGame.dart';
import 'package:flame/position.dart';
import 'package:flutter/material.dart';


class Background extends Component{
  static const int _HORIZONTAL_TILE_COUNT = 2;
  GenericGame game;
  Position get camera => game.camera;
  Size screenSize;
  List<SpriteComponent> slides;
  List<Vector3> slidePositions;//z axis is depth
  @override
  void render(Canvas c) {
    // TODO: implement render
    for(var slide in slides)
      slide.render(c);
  }

  @override
  void update(double t) {
    // TODO: implement update
    for(int i = 0; i < slidePositions.length; i++){
      if(slidePositions[i].x + slides[i].width <= camera.x){
        slidePositions[i].x += slides[i].width*_HORIZONTAL_TILE_COUNT;
      }
    }
  }

}