import 'package:flutter/material.dart';
import 'achievement_detail.dart';
import 'achievement.dart';
class AchievementPage extends StatelessWidget {
  final List<Achievement> achievements;

  AchievementPage({Key key, @required this.achievements}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Achievements'),
      ),
      body: ListView.builder(
        itemCount: achievements.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(achievements[index].name),
            // When a user taps on the ListTile, navigate to the DetailScreen.
            // Notice that we're not only creating a DetailScreen, we're
            // also passing the current todo through to it!
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AchievementDetailScreen(achievement: achievements[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}