import 'dart:math';

import 'package:flame/position.dart';
class Vector2D {
  double x,y;
  Vector2D(this.x,this.y);
  Vector2D operator +(Vector2D b) => Vector2D(x+b.x,y+b.y);
  Vector2D operator -(Vector2D b) => Vector2D(x-b.x,y-b.y);
  Vector2D operator *(double b) => Vector2D(x*b,y*b);
  Vector2D operator /(double b) => Vector2D(x/b,y/b);
  Position toPosition() => Position(x,y);
  double dot(Vector2D b) => x*b.x+y*b.y;
  double cross(Vector2D b) => x*b.y-y*b.x;
  //angle is in radians
  Vector2D fromAngle(double angle) => Vector2D(cos(angle),sin(angle));
}