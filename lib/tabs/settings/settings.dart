import 'package:flutter/material.dart';
import 'package:tobaccoFreeAmarilloApp/tabs/settings/privacy.dart';
import 'person.dart';

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
  // bool notificationsEnabled = false;
  // bool soundEnabled = false;
  // StatefulSettings({Key key, this.notificationsEnabled, this.soundEnabled})
  //     : super(key: key);

  @override
  _Settings createState() => _Settings();
}

Person _person;

class _Settings extends State<StatefulSettings> {
  final double spacingFactor = 25;
  final double buttonTextScaleFactor = 1.75;
  final double descriptionScaleFactor = 0.9;

  @override
  Widget build(BuildContext context) {
    if (_person == null) {
      _person = new Person();
      Person.getInstance().then((Person p) {
        _person = p;
        setState(() {});
      });
    }
    return new Container(
        child: ListView(
      children: <Widget>[
        ExpansionTile(
          title: Text(
            "Personal Information",
            textScaleFactor: buttonTextScaleFactor,
          ),
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(
                icon: const Icon(Icons.person),
                hintText: 'Enter a nickname',
                labelText: 'Nickname',
              ),
              onFieldSubmitted: (String txt) {
                _person.nickname = txt;
              },
              initialValue: _person.nickname,
            ),
            TextFormField(
              decoration: const InputDecoration(
                icon: const Icon(Icons.map),
                hintText: 'Enter your zipcode',
                labelText: 'Zipcode',
              ),
              onFieldSubmitted: (String txt) {
                _person.zipCode = int.parse(txt);
              },
              initialValue: _person.zipCode.toString(),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        ExpansionTile(
          title: Text(
            "Cessation Settings",
            textScaleFactor: buttonTextScaleFactor,
          ),
          children: <Widget>[
            TextFormField(
              initialValue: _person.startingUsage.toString(),
              decoration: const InputDecoration(
                icon: const Icon(Icons.smoking_rooms),
                hintText: 'tobacco products used per day',
                labelText: 'Average Usage',
              ),
              onFieldSubmitted: (String txt) {
                int count = int.tryParse(txt);
                if (count != null) _person.startingUsage = count;
              },
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              initialValue: _person.desiredUsage.toString(),
              decoration: const InputDecoration(
                icon: const Icon(Icons.smoking_rooms),
                hintText: 'Desired tobacco product usage per day',
                labelText: 'Desired Usage',
              ),
              onFieldSubmitted: (String txt) {
                int count = int.tryParse(txt);
                if (count != null) _person.desiredUsage = count;
              },
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              initialValue: _person.desiredDaysUntilComplete.toString(),
              decoration: const InputDecoration(
                icon: const Icon(Icons.timer),
                hintText: 'desired days till completion',
                labelText: 'Desired days until complete',
              ),
              onFieldSubmitted: (String txt) {
                int count = int.tryParse(txt);
                if (count != null) _person.desiredDaysUntilComplete = count;
              },
              keyboardType: TextInputType.number,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text("       Cessation Item", textScaleFactor: 1.4),
            ),
            FormField(
              builder: (FormFieldState field) {
                return DropdownButton(
                  value: _person.product,
                  hint: new Text("What are you trying to quit?"),
                  items: buildDropDownMenuItems(),
                  onChanged: (TobaccoProducts newProduct) {
                    _person.product = newProduct;
                    setState(() {});
                  },
                );
              },
            ),
            FormField(
              builder: (FormFieldState field) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RaisedButton(
                      child: Text("Cancel"),
                      onPressed: () {
                        _person.import();
                        setState(() {});
                      },
                    ),
                    RaisedButton(
                      child: Text("Apply"),
                      onPressed: () {
                        _person.export();
                        setState(() {});
                      },
                    )
                  ],
                );
              },
            ),
          ],
        ),
        ListTile(
          title: Text(
            "Privacy Policy",
            textScaleFactor: buttonTextScaleFactor,
          ),
          onTap: () {
            Privacy.show(context);
          },
        ),
      ],
    ));
  }

  List<DropdownMenuItem<TobaccoProducts>> buildDropDownMenuItems() {
    var names = TobaccoProducts.values;
    int startingIndex = names[0].toString().indexOf('.') + 1;
    List<DropdownMenuItem<TobaccoProducts>> elements = List();

    for (var objectifiedName in names) {
      String name = objectifiedName.toString().substring(startingIndex);
      String upperName = name.toUpperCase();
      for (int i = 1; i < name.length; i++)
        if (name.codeUnitAt(i) == upperName.codeUnitAt(i)) {
          name = name.substring(0, i) + ' ' + name.substring(i);
          upperName = upperName.substring(0, i) + ' ' + upperName.substring(i);
          i++;
        }
      elements.add(DropdownMenuItem(
        value: objectifiedName,
        child: Text(name),
      ));
    }
    return elements;
  }
}
