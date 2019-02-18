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
    child: Padding( 
      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 50),
      child: new Column(
      
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new FlatButton(onPressed: (){
            setState(() {
             notificationsEnabled = !notificationsEnabled;
             notificationsTxt = notificationsEnabled?
              "Disable Notifications" : "Enable Notifications"; 
            });
          },
          color: Colors.black12,
          child: Text('$notificationsTxt',
            textScaleFactor: buttonTextScaleFactor,)),
        new Padding(
          child: new Text("Used for achievments and awards"
          ,maxLines: 3,
          textScaleFactor: descriptionScaleFactor,
        ),
        padding: EdgeInsets.fromLTRB(
          20,0,20,spacingFactor
        ),),
        new FlatButton(onPressed: (){
          
          },
          color: Colors.black12,
          child: Text("     Update Profile     ",
            textScaleFactor: buttonTextScaleFactor)
        ),
        new Padding(
          child: new Text("Edit user information"
          ,maxLines: 3,
          textScaleFactor: descriptionScaleFactor,
        ),
        padding: EdgeInsets.fromLTRB(
          20,0,20,spacingFactor
        ),),
        new FlatButton(onPressed: (){
          setState(() {
             soundEnabled = !soundEnabled;
             soundTxt = soundEnabled?
              "     Disable Sound      " : "     Enable Sound       ";
            });
          },
          color: Colors.black12,
          child: Text('$soundTxt',
            textScaleFactor: buttonTextScaleFactor)
        ),
        new Padding(
          child: new Text("Toggle sound"
          ,maxLines: 3,
          textScaleFactor: descriptionScaleFactor,
        ),
        padding: EdgeInsets.fromLTRB(
          20,0,20,spacingFactor
        ),),
        new FlatButton(onPressed: (){
          showDialog(context:context,
            builder: privacyPolicyBuilder);
          },
          color: Colors.black12,
          child: Text("View Privacy Policy",
            textScaleFactor: buttonTextScaleFactor)
        ),
        new Padding(
          child: new Text("Find out what information we are taking from you."
          ,maxLines: 3,
          textScaleFactor: descriptionScaleFactor,
        ),
        padding: EdgeInsets.fromLTRB(
          20,0,20,spacingFactor
        ),),
      ],
    ),
  ));
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