import 'package:flutter/material.dart';
import 'achievement_detail.dart';
import 'achievement.dart';

class AchievementPage extends StatelessWidget {
  static List<Achievement> achievements= <Achievement>[
    //Achievement(true, "Achievement 1", "description", 5),
    //Achievement(false, "Achievement 2", "description", 10),
  ];

  AchievementPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    achievements.sort((Achievement a, Achievement b){
      if (a.status == false) {
        return 0;
      }
      else{
        return 1;
      }
    });
    ListTile makeListTile(index) => ListTile(
        //When tile is tapped navigate to details page
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  AchievementDetailScreen(achievement: achievements[index]),
            ),
          );
        },
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        leading: Container(
          padding: EdgeInsets.only(right: 12.0),
          decoration: new BoxDecoration(
              border: new Border(
                  right: new BorderSide(width: 1.0, color: Colors.white))),
          child: Icon((achievements[index].status)?Icons.check_circle:Icons.cancel, color: (achievements[index].status)?Colors.greenAccent:Colors.redAccent),
        ),
        title: Text(
          achievements[index].name,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        // Show the points you can get from completing this achievement
        subtitle: Row(
          children: <Widget>[
            Text("Points: " + achievements[index].points.toString(),
                style: TextStyle(color: Colors.white))
          ],
        ),
        // Show the difficulty of the achievement
        //subtitle: Row(
        //children: <Widget>[
        //Icon(Icons.linear_scale, color: Colors.yellowAccent),
        //Text(" Intermediate", style: TextStyle(color: Colors.white))
        //],
        //),
        trailing:
            Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0));
    return Scaffold(
      //appBar: AppBar(
        //title: Text('Achievements'),
      //),
      body: ListView.builder(
        itemCount: achievements.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 8.0,
            margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
            color: Theme.of(context).primaryColor,
            child: Container(
                //decoration:
                    //BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
                child: makeListTile(index)),
          );
        },
      ),
    );
  }
}