import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final _nickNameController = TextEditingController();
  final _zipCodeController = TextEditingController();
  int _tabaccoTypesIndex = 0;

  final firestore = Firestore.instance;

  

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              color: theme.primaryColor,
              height: size.height / 3,
              child: Center(
                  child: FlutterLogo(
                size: 80,
              )),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 300,
              child: TextFormField(
                controller: _nickNameController,
                decoration: InputDecoration(
                  labelText: "Nickname",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: theme.primaryColor),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 300,
              child: TextFormField(
                controller: _zipCodeController,
                decoration: InputDecoration(
                  labelText: "Zip Code",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: theme.primaryColor),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            InputDecorator(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12.0)),
              child: DropdownButton(
                  isExpanded: true,
                  value: _tabaccoTypesIndex,
                  items: List.generate(3, (index) {
                    return DropdownMenuItem(
                      value: index,
                      child: Text(tabaccoTypes[index]),
                    );
                  }),
                  onChanged: (value) async {
                    setState(() {
                      _tabaccoTypesIndex = value;
                    });
                  }),
            ),
            SizedBox(height: 10),
            RaisedButton(
              onPressed: () {
                firestore.collection("clients").add({
                  "nickname": _nickNameController.text,
                  "zipcode": _zipCodeController.text,
                  "type": tabaccoTypes[_tabaccoTypesIndex]
                });
                Navigator.of(context).pop();
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 42),
                child: Text(
                  "Next",
                  style: theme.textTheme.headline.copyWith(
                      color: theme.primaryColor, fontWeight: FontWeight.bold),
                ),
              ),
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
            ),
          ],
        ),
      ),
    );
  }
}

const tabaccoTypes = ["Smoking", "Vaping", "Smokeless Tabacco"];
