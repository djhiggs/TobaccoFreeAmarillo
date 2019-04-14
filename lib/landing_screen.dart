import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tobaccoFreeAmarilloApp/tabs/settings/smokeChart.dart';
import 'tabs/settings/person.dart';
import 'tabs/settings/settings.dart';

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final _nickNameController = TextEditingController();
  final _zipCodeController = TextEditingController();
  int _tabaccoTypesIndex = 0;

  Person _person = Person();

  @override
  Widget build(BuildContext context) {
    tobaccoTypes =getTobaccoProductNames();
    Person.getInstance().then(
      (Person p){
        _person = p;
      });
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
                  child: new Image.asset('images/tfa.png', fit: BoxFit.fill)),
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
                      child: Text(tobaccoTypes[index]),
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
                _person.nickname =_nickNameController.text;
                _person.zipCode =int.parse(_zipCodeController.text);  
                _person.smokeChart.product = 
                  TobaccoProducts.values[_tabaccoTypesIndex];
                _person.export();
                Navigator.of(context).pop();
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 42),
                child: Text(
                  "Next",
                  style: theme.textTheme.headline.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              color: theme.primaryColor,
               shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(50)),
            ),
          ],
        ),
      ),
    );
  }
  List<String> tobaccoTypes;
  List<String> getTobaccoProductNames() {
    List<String> names = List();
    int startingIndex = TobaccoProducts.values[0].toString().indexOf('.') + 1;
    for (var raw in TobaccoProducts.values) {
      String name = raw.toString().substring(startingIndex);
      String upperName = name.toUpperCase();
      for (int i = 1; i < name.length; i++)
        if (name.codeUnitAt(i) == upperName.codeUnitAt(i)) {
          name = name.substring(0, i) + ' ' + name.substring(i);
          upperName = upperName.substring(0, i) + ' ' + upperName.substring(i);
          i++;
        }
      names.add(name);
    }
    return names;
  }
}

