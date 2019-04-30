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

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart' as material;
import 'game/game.dart';

class TRex extends GenericGame
{
  TRexGame tRexGame;
  TRex(BuildContext context) : super(context) {
    title = "Vape Runner";
    description = "We all gotta blow off some steam."; //TODO: fix the name
      Flame.audio.disableLog();
  //List<Image> image = await Flame.images.loadAll(["sprite.png"]);
  //TRexGame tRexGame = TRexGame(spriteImage: image[0]);
  Flame.images.load("sprite.png").then((Image image){
    tRexGame = TRexGame(spriteImage: image);
    });
    Flame.audio.disableLog();

    Flame.util.addGestureRecognizer(TapGestureRecognizer()
      ..onTapDown = (TapDownDetails evt) => tRexGame.onTap());

    //be careful with this because it messes with the ui
    //SystemChrome.setEnabledSystemUIOverlays([]);
  }
  @override
  Widget get widget => material.Material(child: GameWrapper(tRexGame));
}