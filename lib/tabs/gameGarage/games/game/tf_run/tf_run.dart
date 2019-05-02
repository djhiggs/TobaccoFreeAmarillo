import 'dart:ui';

import 'package:flame/animation.dart';
import 'package:flame/components/animation_component.dart';
import 'package:flame/components/component.dart';
import 'package:flame/components/composed_component.dart';
import 'package:flame/components/resizable.dart';
import 'package:flame/sprite.dart';
import '../tf_run/config.dart';

enum TFVanStatus { crashed, ducking, jumping, running, waiting, intro }

class TFVan extends PositionComponent with ComposedComponent, Resizable {
  bool isIdle = true;

  TFVanStatus status = TFVanStatus.waiting;

  WaitingTFVan idleVan;
  RunningTFVan runningVan;
  JumpingTFVan jumpingVan;
  SurprisedTFVan surprisedVan;

  double jumpVelocity = 0.0;
  bool reachedMinHeight = false;
  int jumpCount = 0;
  bool hasPlayedIntro = false;

  TFVan(Image spriteImage)
      : runningVan = RunningTFVan(spriteImage),
        idleVan = WaitingTFVan(spriteImage),
        jumpingVan = JumpingTFVan(spriteImage),
        surprisedVan = SurprisedTFVan(spriteImage),
        super();

  PositionComponent get actualVan {
    switch (status) {
      case TFVanStatus.waiting:
        return idleVan;
      case TFVanStatus.jumping:
        return jumpingVan;

      case TFVanStatus.crashed:
        return surprisedVan;
      case TFVanStatus.intro:
      case TFVanStatus.running:
      default:
        return runningVan;
    }
  }

  void startJump(double speed) {
    if (status == TFVanStatus.jumping || status == TFVanStatus.ducking) return;

    status = TFVanStatus.jumping;
    this.jumpVelocity = TFVanConfig.initialJumpVelocity - (speed / 10);
    this.reachedMinHeight = false;
  }

  @override
  void render(Canvas canvas) {
    this.actualVan.render(canvas);
  }

  void reset() {
    y = groundYPos;
    jumpVelocity = 0.0;
    jumpCount = 0;
    status = TFVanStatus.running;
  }

  void update(double t) {
    if (status == TFVanStatus.jumping) {
      y += (jumpVelocity);
      this.jumpVelocity += TFVanConfig.gravity;
      if (this.y > this.groundYPos) {
        this.reset();
        this.jumpCount++;
      }
    } else {
      y = this.groundYPos;
    }

    // intro related
    if (jumpCount == 1 && !playingIntro && !hasPlayedIntro) {
      status = TFVanStatus.intro;
    }
    if (playingIntro && x < TFVanConfig.startXPos) {
      x += ((TFVanConfig.startXPos / TFVanConfig.introDuration) * t * 5000);
    }

    updateCoordinates(t);
  }

  void updateCoordinates(double t) {
    this.actualVan.x = x;
    this.actualVan.y = y;
    this.actualVan.update(t);
  }

  double get groundYPos {
    if (size == null) return 0.0;
    return (size.height / 2) - TFVanConfig.height / 2;
  }

  bool get playingIntro => status == TFVanStatus.intro;

  bool get ducking => status == TFVanStatus.ducking;
}

class RunningTFVan extends AnimationComponent {
  RunningTFVan(Image spriteImage)
      : super(
            88.0,
            90.0,
            Animation.spriteList([
              Sprite.fromImage(
                spriteImage,
                width: TFVanConfig.width,
                height: TFVanConfig.height,
                y: 4.0,
                x: 1514.0,
              ),
              Sprite.fromImage(
                spriteImage,
                width: TFVanConfig.width,
                height: TFVanConfig.height,
                y: 4.0,
                x: 1602.0,
              ),
            ], stepTime: 0.2, loop: true));
}

class WaitingTFVan extends SpriteComponent {
  WaitingTFVan(Image spriteImage)
      : super.fromSprite(
            TFVanConfig.width,
            TFVanConfig.height,
            Sprite.fromImage(spriteImage,
                width: TFVanConfig.width,
                height: TFVanConfig.height,
                x: 76.0,
                y: 6.0));
}

class JumpingTFVan extends SpriteComponent {
  JumpingTFVan(Image spriteImage)
      : super.fromSprite(
            TFVanConfig.width,
            TFVanConfig.height,
            Sprite.fromImage(spriteImage,
                width: TFVanConfig.width,
                height: TFVanConfig.height,
                x: 1339.0,
                y: 6.0));
}

class SurprisedTFVan extends SpriteComponent {
  SurprisedTFVan(Image spriteImage)
      : super.fromSprite(
            TFVanConfig.width,
            TFVanConfig.height,
            Sprite.fromImage(spriteImage,
                width: TFVanConfig.width,
                height: TFVanConfig.height,
                x: 1782.0,
                y: 6.0));
}
