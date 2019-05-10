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
import '../../../settings/database.dart';
import '../../../achievement_page/achievement.dart';
import '../../../achievement_page/achievement_page.dart';





class Board extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BoardState();
  Board()
  {

  }
}

enum Direction { LEFT, RIGHT, UP, DOWN }
enum GameState { SPLASH, RUNNING, VICTORY, FAILURE }

class BoardState extends State<Board> {
  static List<Achievement> _achievements;
  static Database _db;
  static DateTime startTime;
  ///this is called in main and loads in all of the achievements
  static void initialize(Database db){
    //initializes all of the achievements and gets their current stats from the database
    _achievements = <Achievement>[
      Achievement(db["snake.achieve.1"] as bool,"You're Hissstory!","Grabbed the apple for the first time",100),
      Achievement(db["snake.achieve.2"] as bool,"π - thon!","Your snake is 15 blocks long",500),
      Achievement(db["snake.achieve.3"] as bool,"Ouroboros","You got a game over",1001),
      Achievement(db["snake.achieve.4"] as bool,"New boots","Your snake is 10 blocks long",500),
      Achievement(db["snake.achieve.5"] as bool,"Jormungand","Your snake is 20 blocks long",1000),
      Achievement(db["snake.achieve.6"] as bool,"Snake in the grass!","Your snake is 5 blocks long",400),
      Achievement(db["snake.achieve.7"] as bool,"Sunning yourself","Played Snake for 10 minutes",3000),
      
    ];
    //checks for achievements that have not been instantiated in the database yet
    for(int i = 0; i < _achievements.length; i++)
      if(_achievements[i].status ==null){
        //assignes a default value
        _achievements[i].status =false;
        //sets the value to the LOCAL database
        //using a general definition so it doesn't
        //overide anything and distinguishes them
        //using the index
        db.setLocal("snake.achieve." + (i+ 1).toString(), false);
      }
    //adds these achievements to the global achievement list
    //to be rendered later
    AchievementPage.achievements.addAll(_achievements);
    //saves the database instance for later use
    BoardState._db = db;
  }

  ///checks if any new achievements have been earned
  ///(assesses eligibility)
  void checkAchievementStatus(){
    int gameTime = (DateTime.now().millisecondsSinceEpoch - startTime.millisecondsSinceEpoch)~/Duration.millisecondsPerMinute;
    if(_db["PointAmount"] == null)
      _db["PointAmount"] =0;
      //logic for achievements
      if(_isAppleCollision())
      {
        _achievements[1].status =true;
        //updates the LOCAL database with the new
        //database value
        _db.setLocal("PointAmount", _db["PointAmount"] + _achievements[1].points);
        _db.setLocal("snake.achieve.1", true);
      }else if(_snakePiecePositions.length == 15)
      {
        _achievements[2].status =true;
        //updates the LOCAL database with the new
        //database value
        _db.setLocal("PointAmount", _db["PointAmount"] + _achievements[2].points);
        _db.setLocal("quiz.achieve.2", true);
      }
      else if(_isWallCollision())
      {
        _achievements[3].status =true;
        //updates the LOCAL database with the new
        //database value
        _db.setLocal("PointAmount", _db["PointAmount"] + _achievements[3].points);
        _db.setLocal("quiz.achieve.3", true);
      }else if(_snakePiecePositions.length == 10)
      {
        _achievements[4].status =true;
        //updates the LOCAL database with the new
        //database value
        _db.setLocal("PointAmount", _db["PointAmount"] + _achievements[4].points);
        _db.setLocal("quiz.achieve.4", true);
      }else if(_snakePiecePositions.length == 20)
      {
        _achievements[5].status =true;
        //updates the LOCAL database with the new
        //database value
        _db.setLocal("PointAmount", _db["PointAmount"] + _achievements[5].points);
        _db.setLocal("quiz.achieve.5", true);
      }else if(_snakePiecePositions.length == 5)
      {
        _achievements[6].status =true;
        //updates the LOCAL database with the new
        //database value
        _db.setLocal("PointAmount", _db["PointAmount"] + _achievements[6].points);
        _db.setLocal("quiz.achieve.6", true);
      }else if(gameTime == 10)
      {
        _achievements[7].status =true;
        //updates the LOCAL database with the new
        //database value
        _db.setLocal("PointAmount", _db["PointAmount"] + _achievements[7].points);
        _db.setLocal("quiz.achieve.7", true);
      }
  }


  List<Point> _snakePiecePositions;
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
    startTime=DateTime.now();

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
