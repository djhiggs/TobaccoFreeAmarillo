import 'package:flutter/material.dart';
import 'package:flame/game.dart' as game;
import 'package:flame/flame.dart' as flame;
class GenericGame extends game.BaseGame{
  static int count = 0;
  String title;
  BuildContext _context;
  GenericGame(this._context){
    title = "Game " + (count++).toString();
  }
  start(){

  }
  stop(){

  }
  open(){
    Navigator.push(_context, MaterialPageRoute(builder: (BuildContext context) {
      return this.widget;
    }));
  }
  close(){
    Navigator.of(_context).pop();
  }
}