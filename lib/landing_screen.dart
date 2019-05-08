import 'package:flutter/material.dart';
import 'tabs/settings/database.dart';
import 'tabs/settings/person.dart';

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final _nickNameController = TextEditingController();
  final _zipCodeController = TextEditingController();
  final _currentUsageController = TextEditingController();
  final _desiredUsageController = TextEditingController();
  final _daysUntilFullCessationController = TextEditingController();
  int _tabaccoTypesIndex = 0;

  final Database db =Database.getLoadedInstance();
  final Person person = Person.getLoadedInstance();
  bool dataCollectable = true;
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
                keyboardType: TextInputType.number,
              ),
            ),
            SizedBox(
              width: 300,
              child: TextFormField(
                controller: _currentUsageController,
                decoration: InputDecoration(
                  labelText: "Current using per day",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: theme.primaryColor),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            SizedBox(
              width: 300,
              child: TextFormField(
                controller: _desiredUsageController,
                decoration: InputDecoration(
                  labelText: "Desired usage per day",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: theme.primaryColor),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            SizedBox(
              width: 300,
              child: TextFormField(
                controller: _daysUntilFullCessationController,
                decoration: InputDecoration(
                  labelText: "Expected transition time",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: theme.primaryColor),
                  ),
                ),
                keyboardType: TextInputType.number,
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
            Row(children: <Widget>[
              Flexible(child: 
              Text("Do you or if under or 18 years of age your legal guardian consent of the collection of anonymous data?",
              maxLines: 10,textScaleFactor: 0.8,)),
              Checkbox(value: dataCollectable,onChanged: (bool val) {
                    dataCollectable=val;
                    setState((){});
                  }
                ,)
            ],),
            RaisedButton(
              onPressed: () {
                person.db.setCanUseRemote(dataCollectable);
                person.nickname =_nickNameController.text;
                person.zipCode =int.tryParse(_zipCodeController.text);
                if(person.zipCode == null)
                  person.zipCode = -1;
                person.startingUsage =int.tryParse(_currentUsageController.text);
                if(person.startingUsage == null)
                  person.startingUsage = 5;
                person.desiredUsage =int.tryParse(_desiredUsageController.text);
                if(person.desiredUsage == null)
                  person.desiredUsage = 0;
                person.desiredDaysUntilComplete =int.tryParse(_daysUntilFullCessationController.text);
                if(person.desiredDaysUntilComplete == null)
                  person.desiredDaysUntilComplete = 100;
                person.startDate = DateTime.now();
                person.product = TobaccoProducts.values[_tabaccoTypesIndex];
                person.export();
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
}

const tabaccoTypes = ["Smoking", "Vaping", "Smokeless Tabacco"];
