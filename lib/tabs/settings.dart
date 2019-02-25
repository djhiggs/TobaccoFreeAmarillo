import 'package:flutter/material.dart';
import 'package:flutter_starter/person.dart';
import 'package:flutter_starter/smokeChart.dart';

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
  Person person =Person();
  @override
  Widget build(BuildContext context) => new Container(
      child: ListView(
        children: <Widget>[
          ListTile(
            title: Text("Notifications",
            textScaleFactor: buttonTextScaleFactor,),
            trailing: Switch(onChanged: (bool state){
                person.notificationsEnabled = state;
              },
              value: person.notificationsEnabled),
          ),
          ListTile(
            title: Text("Sound",
            textScaleFactor: buttonTextScaleFactor,),
            trailing: Switch(onChanged: (bool state){
                person.soundEnabled = state;
              },
              value: person.soundEnabled),
          ),
          ExpansionTile(
            title: Text("Personal Information",
            textScaleFactor: buttonTextScaleFactor,),
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(
                  icon: const Icon(Icons.person),
                  hintText: 'Enter a nickname',
                  labelText: 'Nickname',
                ),
                onFieldSubmitted: (String txt){
                  person.nickname = txt;
                },
              ),
                TextFormField(
                decoration: const InputDecoration(
                  icon: const Icon(Icons.person),
                  hintText: 'Enter your zipcode',
                  labelText: 'Zipcode',
                ),
                onFieldSubmitted: (String txt){
                  person.nickname = txt;
                },
              ),
            ],
          ),
          ExpansionTile(
            title: Text("Sessation Settings",
            textScaleFactor: buttonTextScaleFactor,),
            children: <Widget>[
              TextFormField(
                initialValue: person.smokeChart.startingAmountPerWeek.toString(),
                decoration: const InputDecoration(
                  icon: const Icon(Icons.person),
                  hintText: 'tobacco products used per week',
                  labelText: 'Average Usage',
                ),
                onFieldSubmitted: (String txt){
                  int count = int.tryParse(txt);
                  if(count !=null)
                    person.smokeChart.startingAmountPerWeek = count;
                  else throw null;
                },
              ),
              TextFormField(
                initialValue: person.smokeChart.desiredEndAmount.toString(),
                decoration: const InputDecoration(
                  icon: const Icon(Icons.person),
                  hintText: 'desired tobacco products used per week',
                  labelText: 'Desired Usage',
                ),
                onFieldSubmitted: (String txt){
                  int count = int.tryParse(txt);
                  if(count !=null)
                    person.smokeChart.desiredEndAmount = count;
                  else throw null;
                },
              ),
              TextFormField(
                initialValue: person.smokeChart.initialUpperBound.toString(),
                decoration: const InputDecoration(
                  icon: const Icon(Icons.person),
                  hintText: 'max tobacco products used per week',
                  labelText: 'Max Usage',
                ),
                onFieldSubmitted: (String txt){
                  int count = int.tryParse(txt);
                  if(count !=null)
                    person.smokeChart.initialUpperBound = count;
                  else throw null;
                },
              ),
              TextFormField(
                initialValue: person.smokeChart.initialLowerBound.toString(),
                decoration: const InputDecoration(
                  icon: const Icon(Icons.person),
                  hintText: 'min tobacco products used per week',
                  labelText: 'Minimum Usage',
                ),
                onFieldSubmitted: (String txt){
                  int count = int.tryParse(txt);
                  if(count !=null)
                    person.smokeChart.initialLowerBound = count;
                  else throw null;
                },
              ),
              TextFormField(
                initialValue: person.smokeChart.initialUpperBound.toString(),
                decoration: const InputDecoration(
                  icon: const Icon(Icons.person),
                  hintText: 'max tobacco products used per week',
                  labelText: 'Max Usage',
                ),
                onFieldSubmitted: (String txt){
                  int count = int.tryParse(txt);
                  if(count !=null)
                    person.smokeChart.initialUpperBound = count;
                  else throw null;
                },
              ),
              TextFormField(
                initialValue: person.smokeChart.sessationChangeTimeDays.toString(),
                decoration: const InputDecoration(
                  icon: const Icon(Icons.person),
                  hintText: 'desired days till completion',
                  labelText: 'Desired days until complete',
                ),
                onFieldSubmitted: (String txt){
                  int count = int.tryParse(txt);
                  if(count !=null)
                    person.smokeChart.sessationChangeTimeDays = count;
                  else throw null;
                },
              ),
              FormField(
                builder: (FormFieldState field) {
                  return DropdownButton(
                    items: buildDropDownMenuItems(),
                    onChanged: (TobaccoProducts newProduct){
                      person.smokeChart.vice =newProduct;
                    },
                  );
                },
                )
            ],
          ),
          ListTile(
            title: Text("View Privacy Policy",
            textScaleFactor: 1.2,),
            onTap: (){
              showDialog(
                builder: privacyPolicyBuilder, 
                context: context
              );
            },
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
          List<DropdownMenuItem<TobaccoProducts>> buildDropDownMenuItems()
          {
            var names = TobaccoProducts.values;
            int startingIndex = names[0].toString().indexOf('.') + 1;
            List<DropdownMenuItem<TobaccoProducts>> elements =List();

            for (var name in names) {
              elements.add(DropdownMenuItem(
                value: name,
                child: Text(name.toString().substring(startingIndex)),
                ));
            }
            return elements;
          }
}