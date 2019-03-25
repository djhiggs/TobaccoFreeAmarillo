import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flame/components/component.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flame/flame.dart' as flame;
import 'genericGame.dart';


import 'dart:math' as math;
import 'dart:ui';

import 'package:flame/anchor.dart';
import 'package:flame/palette.dart';

class SideScroller extends GenericGame{
  SideScroller(BuildContext context) : super(context){
    this.title = "Side Scroller";
    Flame.images.load("GenericTexture1.bmp").whenComplete(()=>addc());
    addc();
  }
  SpriteComponent c;
  void addc(){
    c =SpriteComponent();
    c.sprite = Sprite.fromImage( 
      Flame.images.loadedFiles["GenericTexture1.bmp"],
      x: 0,
      y: 0,
      width: 128,
      height: 128);
    c.width = 128;
    c.height = 128;
    
    //components.add(c);
    //this.add(c);
    
  }
  @override
  start() {

  }
  @override
  stop() {

  }
  
  @override
  void render(Canvas canvas) {
    if(c !=null)
      c.render(canvas);
    
    //var p = Paint();
    //p.color = Colors.red;
    //super.render(canvas);
    //canvas.drawImage(Flame.images.loadedFiles["GenericTexture1.png"], Offset(0*size.width/2,0*size.height/2), p);
    //canvas.drawCircle(Offset(size.width/4,size.height/2), 32, p);
  }
  double h0 = -1;
  double t = 0;
  @override
  void update(double dt) {
    t += dt;
    if(h0 == -1)
      h0 = c.height;
    c.height = h0 * 0.5*(1 + math.cos(t));
  }
} 