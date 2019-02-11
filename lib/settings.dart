import 'package:flutter/material.dart';
import 'profile.dart';

class Settings extends StatefulWidget {
  Settings({Key key, this.title, this.profileData}) : super(key: key);

  final String title;
  final Profile profileData;
// yeah for changes!
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the Settings object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.profileData.firstName),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[Text("Here is my Setting page.")],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.ac_unit), title: Text("Button")),
              BottomNavigationBarItem(
              icon: Icon(Icons.account_box), title: Text("Thing")),
        ],
      ),
    );
  }
}
