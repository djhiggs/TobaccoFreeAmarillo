import 'package:flutter/material.dart';

class MyTextInput extends StatefulWidget {
  @override
  MyTextInputState createState() => new MyTextInputState();
}

class MyTextInputState extends State<MyTextInput> {
  String nickname = "";
  String dropdownValue;
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
                      labelText: 'Enter your nickname'),
                  onChanged: (String value) {
                    onChanged(value);
                    setState(() {
                      nickname = value;
                    });
                  },
                ),
                new RaisedButton(
                  child: new Text('Submit'),
                  onPressed: () {
                    onPressed();
                  },
                ),
                DropdownButton<String>(
                    value: dropdownValue,
                    onChanged: (String newValue) {
                      setState(() {
                        if (newValue != null) dropdownValue = newValue;
                      });
                    },
                    hint: Text("Please select your age range"),
                    items: <String>['13-15', '15-17', '17-19', '19-21']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                          value: value, child: Text(value));
                    }).toList())
              ],
            ),
          ),
        ));
  }
}
