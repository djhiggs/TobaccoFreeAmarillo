import 'package:flutter/material.dart';
import 'package:flame/game.dart' as game;
import 'package:flame/flame.dart' as flame;
class Game {
  static int count = 0;
  String title;
  Game(){
    title = "Game " + (count++).toString();
  }
}