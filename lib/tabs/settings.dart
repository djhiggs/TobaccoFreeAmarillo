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
}