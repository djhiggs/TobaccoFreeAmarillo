import 'dart:ui';

import 'package:flame/components/component.dart';
//import 'package:flame/flame.dart' as ui;
import 'package:flame/flame.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tobaccoFreeAmarilloApp/game/game.dart';
import 'package:tobaccoFreeAmarilloApp/game/trexgame.dart';

import 'genericGame.dart';
import 'package:tobaccoFreeAmarilloApp/game/trexgame.dart';
class TRex extends GenericGame
{
  TRexGame tRexGame;
  TRex(BuildContext context) : super(context) {
    title = "T Rex Game";
      Flame.audio.disableLog();
  //List<Image> image = await Flame.images.loadAll(["sprite.png"]);
  //TRexGame tRexGame = TRexGame(spriteImage: image[0]);
  Flame.images.loadAll(["sprite.png"]).then((List<Image> image){
    tRexGame = TRexGame(spriteImage: image[0]);
  });
  }
  @override
  // TODO: implement widget
  Widget get widget => GameWrapper(tRexGame);
}