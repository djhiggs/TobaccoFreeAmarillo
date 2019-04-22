import 'package:flutter/material.dart';
class Globals{
  static initialize(BuildContext context){
    boardSize = MediaQuery.of(context).size.width;
    pieceSize = 0.0625*boardSize;
    textPadding = 0.1*boardSize;
  }
  static double boardSize = 200;
  static double pieceSize = 20.0;
  static double textPadding = 32.0;
}


