import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flame/flame.dart' as flame;
import 'genericGame.dart';

class SideScroller extends GenericGame{
  SideScroller(BuildContext context) : super(context){
    this.title = "Side Scroller";
    //this.add(SpriteComponent.square(64, "lib\games\sprites\GenericTexture1.png"));
  }
  @override
  start() {

  }
  @override
  stop() {

  }
  @override
  void render(Canvas canvas) {
    // TODO: implement render
    //super.render(canvas);
  }
} 