import 'package:flutter/widgets.dart';
import 'game_constants.dart';

class Failure extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      color: const Color(0xFFFFFFFF),
      width: Globals.boardSize,
      height: Globals.boardSize,
      padding: EdgeInsets.all(Globals.textPadding),
      child: Center(
        child: Text("Game over! Tap to play again!",
            textAlign: TextAlign.center,
            style: TextStyle(color: const Color(0xFFFF0C0C))),
      ),
    );
  }
}
