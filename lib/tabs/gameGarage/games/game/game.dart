import 'dart:ui';

import 'package:flame/game.dart';
import 'horizon/horizon.dart';
import 'collision/collision_utils.dart';
import 'game_config.dart';
import 'game_over/game_over.dart';
import 'tf_run/config.dart';
import 'tf_run/tf_run.dart';

enum TFRunnerGameStatus { playing, waiting, gameOver }

class TFRunner extends BaseGame {
  TFVan tfVan;
  Horizon horizon;
  GameOverPanel gameOverPanel;
  TFRunnerGameStatus status = TFRunnerGameStatus.waiting;

  double currentSpeed = GameConfig.speed;
  double timePlaying = 0.0;

  TFRunner({Image spriteImage}) {
    tfVan = new TFVan(spriteImage);
    horizon = new Horizon(spriteImage);
    gameOverPanel = new GameOverPanel(spriteImage);

    this..add(horizon)..add(tfVan)..add(gameOverPanel);
  }

  void onTap() {
    if (gameOver) {
      restart();
      return;
    }
    tfVan.startJump(this.currentSpeed);
  }

  @override
  void update(double t) {
    tfVan.update(t);
    horizon.updateWithSpeed(0.0, this.currentSpeed);

    if (gameOver) return;

    if (tfVan.playingIntro && tfVan.x >= TFVanConfig.startXPos) {
      startGame();
    } else if (tfVan.playingIntro) {
      horizon.updateWithSpeed(0.0, this.currentSpeed);
    }

    if (this.playing) {
      timePlaying += t;
      horizon.updateWithSpeed(t, this.currentSpeed);

      var obstacles = horizon.horizonLine.obstacleManager.components;
      bool collision =
          obstacles.length > 0 && checkForCollision(obstacles.first, tfVan);
      if (!collision) {
        if (this.currentSpeed < GameConfig.maxSpeed) {
          this.currentSpeed += GameConfig.acceleration;
        }
      } else {
        doGameOver();
      }
    }
  }

  void startGame() {
    tfVan.status = TFVanStatus.running;
    status = TFRunnerGameStatus.playing;
    tfVan.hasPlayedIntro = true;
  }

  bool get playing => status == TFRunnerGameStatus.playing;
  bool get gameOver => status == TFRunnerGameStatus.gameOver;

  void doGameOver() {
    this.gameOverPanel.visible = true;
    stop();
    tfVan.status = TFVanStatus.crashed;
  }

  void stop() {
    this.status = TFRunnerGameStatus.gameOver;
  }

  void restart() {
    status = TFRunnerGameStatus.playing;
    tfVan.reset();
    horizon.reset();
    currentSpeed = GameConfig.speed;
    gameOverPanel.visible = false;
    timePlaying = 0.0;
  }
}
