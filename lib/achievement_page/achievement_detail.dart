import 'package:flutter/material.dart';
import 'achievement.dart';
class AchievementDetailScreen extends StatelessWidget {
  // Declare a field that holds achievement
  final Achievement achievement;

  // In the constructor, require an achievement
  AchievementDetailScreen({Key key, @required this.achievement}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use the achievement to create UI
    return Scaffold(
      appBar: AppBar(
        title: Text(achievement.name),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(achievement.description),
      ),
    );
  }
}