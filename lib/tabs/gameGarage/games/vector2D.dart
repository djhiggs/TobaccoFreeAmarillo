import 'dart:math';
import 'dart:ui';

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
  double length() => sqrt(x*x+y*y);
  double lengthSqrd() => x*x+y*y;
  static Vector2D fromOffset(Offset offset) => Vector2D(offset.dx,offset.dy);
  static Vector2D fromPosition(Position pos) => Vector2D(pos.x,pos.y);

  ///angle is in radians
  static Vector2D fromAngle(double angle) => Vector2D(cos(angle),sin(angle));
  Vector2D rotate(double addAngle) {
    return fromAngle(addAngle + angle())*length();
  }
  double angle() => atan2(y, x);
}