import 'dart:async';
import 'dart:math';

import 'package:flutter/widgets.dart';
import 'apple.dart';
import 'failure.dart';
import 'game_constants.dart';
import 'snake_piece.dart';
import 'point.dart';
import 'splash.dart';
import 'victory.dart';

class Board extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BoardState();
}

enum Direction { LEFT, RIGHT, UP, DOWN }
enum GameState { SPLASH, RUNNING, VICTORY, FAILURE }

class _BoardState extends State<Board> {
  var _snakePiecePositions;
  Point _applePosition;
  Timer _timer;
  Direction _direction = Direction.UP;
  var _gameState = GameState.SPLASH;

  @override
  Widget build(BuildContext context) {
    return new Container(
        color: const Color(0xFFFFFFFF),
        width: Globals.boardSize,
        height: Globals.boardSize,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTapUp: (tapUpDetails) {
            _handleTap(tapUpDetails);
          },
          child: _getBoardChildBasedOnGameState(),
        ));
  }

  Widget _getBoardChildBasedOnGameState() {
    var child;

    switch (_gameState) {
      case GameState.SPLASH:
        child = Splash();
        break;

      case GameState.RUNNING:
        List<Positioned> snakePiecesAndApple = List();
        _snakePiecePositions.forEach((i) {
          snakePiecesAndApple.add(Positioned(
            child: SnakePiece(),
            left: i.x * Globals.pieceSize,
            top: i.y * Globals.pieceSize,
          ));
        });

        final apple = Positioned(
          child: Apple(),
          left: _applePosition.x * Globals.pieceSize,
          top: _applePosition.y * Globals.pieceSize,
        );

        snakePiecesAndApple.add(apple);

        child = Stack(children: snakePiecesAndApple);
        break;

      case GameState.VICTORY:
        _timer.cancel();
        child = Victory();
        break;

      case GameState.FAILURE:
        _timer.cancel();
        child = Failure();
        break;
    }

    return child;
  }

  void _onTimerTick(Timer timer) {
    _move();

    if (_isWallCollision()) {
      _changeGameState(GameState.FAILURE);
      return;
    }

    if (_isAppleCollision()) {
      if (_isBoardFilled()) {
        _changeGameState(GameState.VICTORY);
      } else {
        _generateNewApple();
        _grow();
      }
      return;
    }
  }

  void _grow() {
    setState(() {
      _snakePiecePositions.insert(0, _getNewHeadPosition());
    });
  }

  void _move() {
    setState(() {
      _snakePiecePositions.insert(0, _getNewHeadPosition());
      _snakePiecePositions.removeLast();
    });
  }

  bool _isWallCollision() {
    var currentHeadPos = _snakePiecePositions.first;

    if (currentHeadPos.x < 0 ||
        currentHeadPos.y < 0 ||
        currentHeadPos.x > Globals.boardSize / Globals.pieceSize ||
        currentHeadPos.y > Globals.boardSize / Globals.pieceSize) {
      return true;
    }

    return false;
  }

  bool _isAppleCollision() {
    if (_snakePiecePositions.first.x == _applePosition.x &&
        _snakePiecePositions.first.y == _applePosition.y) {
      return true;
    }

    return false;
  }

  bool _isBoardFilled() {
    final totalPiecesThatBoardCanFit =
        (Globals.boardSize * Globals.boardSize) / (Globals.pieceSize * Globals.pieceSize);
    if (_snakePiecePositions.length == totalPiecesThatBoardCanFit) {
      return true;
    }

    return false;
  }

  Point _getNewHeadPosition() {
    var newHeadPos;

    switch (_direction) {
      case Direction.LEFT:
        var currentHeadPos = _snakePiecePositions.first;
        newHeadPos = Point(currentHeadPos.x - 1, currentHeadPos.y);
        break;

      case Direction.RIGHT:
        var currentHeadPos = _snakePiecePositions.first;
        newHeadPos = Point(currentHeadPos.x + 1, currentHeadPos.y);
        break;

      case Direction.UP:
        var currentHeadPos = _snakePiecePositions.first;
        newHeadPos = Point(currentHeadPos.x, currentHeadPos.y - 1);
        break;

      case Direction.DOWN:
        var currentHeadPos = _snakePiecePositions.first;
        newHeadPos = Point(currentHeadPos.x, currentHeadPos.y + 1);
        break;
    }

    return newHeadPos;
  }

  void _handleTap(TapUpDetails tapUpDetails) {
    switch (_gameState) {
      case GameState.SPLASH:
        _moveFromSplashToRunningState();
        break;
      case GameState.RUNNING:
        _changeDirectionBasedOnTap(tapUpDetails);
        break;
      case GameState.VICTORY:
      case GameState.FAILURE:
        _changeGameState(GameState.SPLASH);
        break;
    }
  }

  void _moveFromSplashToRunningState() {
    _generateFirstSnakePosition();
    _generateNewApple();
    _direction = Direction.UP;
    _changeGameState(GameState.RUNNING);
    _timer = new Timer.periodic(new Duration(milliseconds: 500), _onTimerTick);
  }

  void _changeDirectionBasedOnTap(TapUpDetails tapUpDetails) {
    RenderBox getBox = context.findRenderObject();
    var localPosition = getBox.globalToLocal(tapUpDetails.globalPosition);
    final x = (localPosition.dx / Globals.pieceSize).round();
    final y = (localPosition.dy / Globals.pieceSize).round();

    final currentHeadPos = _snakePiecePositions.first;

    switch (_direction) {
      case Direction.LEFT:
      case Direction.RIGHT:
        if (y < currentHeadPos.y)
          setState(() {
            _direction = Direction.UP;
          });
        else if (y > currentHeadPos.y)
          setState(() {
            _direction = Direction.DOWN;
          });
        break;

      case Direction.UP:
      case Direction.DOWN:
        if (x < currentHeadPos.x)
          setState(() {
            _direction = Direction.LEFT;
          });
        else if (x > currentHeadPos.x)
          setState(() {
            _direction = Direction.RIGHT;
          });
        break;
    }
  }

  void _changeGameState(GameState gameState) {
    setState(() {
      _gameState = gameState;
    });
  }

  void _generateFirstSnakePosition() {
    setState(() {
      final midPoint = (Globals.boardSize / Globals.pieceSize / 2);
      _snakePiecePositions = [
        Point(midPoint, midPoint - 2),
        Point(midPoint, midPoint - 1),
        Point(midPoint, midPoint),
        Point(midPoint, midPoint + 1),
        Point(midPoint, midPoint + 2),
      ];
    });
  }

  void _generateNewApple() {
    setState(() {
      Random rng = Random();
      var min = 0;
      var max = Globals.boardSize ~/ Globals.pieceSize;
      var nextX = min + rng.nextInt(max - min);
      var nextY = min + rng.nextInt(max - min);

      var newApple = Point(nextX.toDouble(), nextY.toDouble());

      if (_snakePiecePositions.contains(newApple)) {
        _generateNewApple();
      } else {
        _applePosition = newApple;
      }
    });
  }
}
