import 'dart:ui';

import 'package:flame/components/component.dart';
//import 'package:flame/flame.dart' as ui;
import 'package:flame/flame.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'game/game.dart';
import 'game/trexgame.dart';

import 'genericGame.dart';
import 'game/trexgame.dart';

import 'dart:ui' as ui;

import 'package:flame/flame.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter/services.dart';
import 'game/game.dart';

class TRex extends GenericGame
{
  TRexGame tRexGame;
  TRex(BuildContext context) : super(context) {
    title = "T Rex Game";
      Flame.audio.disableLog();
  //List<Image> image = await Flame.images.loadAll(["sprite.png"]);
  //TRexGame tRexGame = TRexGame(spriteImage: image[0]);
  Flame.images.load("sprite.png").then((Image image){
    tRexGame = TRexGame(spriteImage: image);
    });
    Flame.audio.disableLog();

    Flame.util.addGestureRecognizer(new TapGestureRecognizer()
      ..onTapDown = (TapDownDetails evt) => tRexGame.onTap());

    //be careful with this because it messes with the ui
    //SystemChrome.setEnabledSystemUIOverlays([]);
  }
  @override
  // TODO: implement widget
  Widget get widget => material.Material(child: GameWrapper(tRexGame));
}