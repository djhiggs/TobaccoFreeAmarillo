import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) => new Container(
    child: new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    ),
  );
}
class StatefulSettings extends StatefulWidget {
  bool notificationsEnabled = false;
  bool soundEnabled = false; 
  StatefulSettings({Key key, this.notificationsEnabled,this.soundEnabled}) : super(key: key);

  @override
  _Settings createState() => _Settings();
}
class _Settings extends State<StatefulSettings>{
  final double spacingFactor = 25;
  final double buttonTextScaleFactor = 1.75;
  final double descriptionScaleFactor = 0.9;
  //placeholder variables
  String notificationsTxt = "Enable Notifications";
  String soundTxt = "     Enable Sound       ";
  //
  bool notificationsEnabled = false;
  bool soundEnabled = false;
  @override
  Widget build(BuildContext context) => new Container(
      child: ListView(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(" Notifications",textScaleFactor: buttonTextScaleFactor),
              new Switch(onChanged: (bool state){
                notificationsEnabled = state;
              },
              value: notificationsEnabled)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(" Sound",textScaleFactor: buttonTextScaleFactor,),
              new Switch(onChanged: (bool state){
                soundEnabled = state;
              },
              value: soundEnabled)
            ],
          ),
          FlatButton(
            onPressed: (){
              //edit profile
            },
            child: 
            Text(
              "Edit Profile",
              textScaleFactor: buttonTextScaleFactor,
              textAlign: TextAlign.left,
              ),
              
          ),
          Text(
            "Edit user information",
            textScaleFactor: 0.7,
            style: TextStyle(color: Colors.grey),
            textAlign: TextAlign.center,
            ),
          FlatButton(
            onPressed: (){
              showDialog(
                builder: privacyPolicyBuilder, 
                context: context
              );
            },
            child: 
            Text(
              "View Privacy Policy",
              textScaleFactor: buttonTextScaleFactor
              ),
          ),
        ], ));
  Widget privacyPolicyBuilder(BuildContext context) => AlertDialog(
              title: Text("Privacy Policy"),
              content: Column(children: <Widget>[Text("    You get no data, we get all of the data, you get no data.  We want the data. " + 
              "Oh yeah, and we are also planning to take all of your data, we like to say that: \"Nothing is sacred, we get it all\" " + 
              "So just keep that in mind, you get nothing, we get everything."),
              Text(" -- Team")
              ]),
              actions: <Widget>[
                FlatButton(
                  color: Colors.black26,
                  textColor: Colors.black,
                  child: Text("Accept"),
                onPressed: () {
                  Navigator.of(context).pop();
                },)
              ],
          );
}