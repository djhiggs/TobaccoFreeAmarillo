import 'package:flutter/widgets.dart';
import 'game_constants.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      color: const Color(0xFFFFFFFF),
      width: Globals.boardSize,
      height: Globals.boardSize,
      padding: EdgeInsets.all(Globals.textPadding),
      child: Center(
        child: Text("Tap to start the Game!",
            textAlign: TextAlign.center,
            style: TextStyle(color: const Color(0xFF50C878))),
      ),
    );
  }
}
