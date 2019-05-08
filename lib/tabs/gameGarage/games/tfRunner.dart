import 'dart:ui' as ui;
import 'package:flame/flame.dart';
import 'game/game.dart';
import 'game/tfrunner.dart';

import 'genericGame.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TFVan extends GenericGame
{
  TFRunner tfRunner;
  TFVan(BuildContext context) : super(context,200) {
    title = "TF Driver";
    description = "Drive awacky from the tobacky"; //TODO: fix the name
      Flame.audio.disableLog();
  //List<Image> image = await Flame.images.loadAll(["sprite.png"]);
  //TRexGame tRexGame = TRexGame(spriteImage: image[0]);
  Flame.images.load("sprite.png").then((ui.Image image){
    tfRunner = TFRunner(spriteImage: image);
    });
    Flame.audio.disableLog();

    Flame.util.addGestureRecognizer(TapGestureRecognizer()
      ..onTapDown = (TapDownDetails evt) => tfRunner.onTap());

    //be careful with this because it messes with the ui
    //SystemChrome.setEnabledSystemUIOverlays([]);
  }
  @override
  Widget get widget => Material(child: GameWrapper(tfRunner));
}