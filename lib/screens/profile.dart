
import 'package:flutter/material.dart';

class MyTextInput extends StatefulWidget {
  @override
  MyTextInputState createState() => new MyTextInputState();
}

class MyTextInputState extends State<MyTextInput> {
  
  String nickname = "";
  void onPressed() {
    print('Button Pressed');
  }

  void onChanged(String value) {}

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
        title: new Text("Profile"), backgroundColor: Colors.blueGrey),
        body: new Container(
          padding: new EdgeInsets.all(32.0),
          child: new Center(
            child: new Column(
              children: <Widget>[
                new TextField(
                  decoration: new InputDecoration(
                    icon: new Icon(Icons.account_circle),
                    labelText: 'Enter your nickname'
                  ),
                  onChanged: (String value) {
                    onChanged(value);
                    setState(() {
                      nickname = value;
                    });
                  },
                ),
                // new CheckboxListTile(),
                new RaisedButton(
                  child: new Text('Submit'),
                  onPressed: () {
                    onPressed();
                  },
                ),
                new Text(nickname)
              ],
            ),
          ),
        ));
  }
}
