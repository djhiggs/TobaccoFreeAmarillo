import 'package:flutter/material.dart';
import 'achievement.dart';

class AchievementDetailScreen extends StatelessWidget {
  // Declare a field that holds achievement
  final Achievement achievement;

  // In the constructor, require an achievement
  AchievementDetailScreen({Key key, @required this.achievement})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use the achievement to create UI
    return Scaffold(
      body: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 10.0),
                height: MediaQuery.of(context).size.height * 0.5,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.5,
                padding: EdgeInsets.all(40.0),
                width: MediaQuery.of(context).size.width,
                decoration:
                    BoxDecoration(color: Colors.blueGrey),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 120.0),
                      Text(
                        this.achievement.name,
                        style: TextStyle(color: Colors.white, fontSize: 45.0),
                      ),
                      Container(
                        width: 90.0,
                        child: new Divider(color: Colors.white),
                      ),
                      Icon(
                        (this.achievement.status)?Icons.check_circle:Icons.cancel,
                        color: (this.achievement.status)?Colors.green:Colors.redAccent,
                        size: 40.0,
                      ),
                      SizedBox(height: 10.0),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 25.0,
                top: 60.0,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back, color: Colors.white),
                ),
              )
            ],
          ),
          Container(
            // height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            // color: Theme.of(context).primaryColor,
            padding: EdgeInsets.all(40.0),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  //Added Column and CrossAxis Alignment to try using a divider for a better look (didn't look good)
                  //Container(
                    //width: 90.0,
                    //child: new Divider(color: Colors.black),
                  //),
                  Text(
                    //this.achievement.description,
                    "This description is longer for testing purposes. Please excuse me as I try to see if this fontsize is a good fit.",
                    style: TextStyle(color: Colors.blueGrey[500], fontSize: 25.0),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}