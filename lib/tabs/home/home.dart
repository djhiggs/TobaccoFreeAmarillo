import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../settings/person.dart';
import 'intro_page_view.dart';
import 'calender.dart';

class Home extends StatefulWidget {
  Person _person;
  @override
  State<StatefulWidget> createState() {
    return HomeState(_person);
  }
}

class HomeState extends State<Home> {
  Person _person;
  HomeState(this._person) : super();
  @override
  void initState() {
    super.initState();
  }

  Calender calender = Calender();
  bool giveFeedback = false;
  bool successful = false;
  @override
  Widget build(BuildContext context) {
    _person = Person.getLoadedInstance();

    if(giveFeedback){
      giveFeedback = false;
      int nextGoal = _person.expectedSmokingAmount(DateTime.now().add(Duration(days: 1)));
      return Padding(
        padding: EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 30
        ),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(successful? "Congratulations!" : "Hmmm, always tomorrow right?"),
          Text(successful? 
            "You've taken another step towards independence from " + _person.consumableUnitName(true) + "!" : 
            "Don't worry, you can always succeed tomorrow!",maxLines: 5,
            textAlign: TextAlign.center,
            ),
          Text("Your goal for tommorrow is to consume no more than " + nextGoal.toString() + " " + _person.consumableUnitName(nextGoal!=1)
          ,maxLines: 3,),
          RaisedButton(child: Text("Continue"),onPressed: () => setState((){}))
      ]));
    }
    if(!calender.updatedToday()){
      int selectedAmount = 0;
      List<Widget> options = <Widget>[
        Text("0 " + _person.consumableUnitName(true)),
        Text("1 " + _person.consumableUnitName(false)),
      ];
      while(options.length < 99)
        options.add( RaisedButton(
            child: Text(options.length.toString() + " " + _person.consumableUnitName(true)),
              onPressed: (){
                selectedAmount = options.length;
              },
            )
          );

      

      return Container(child: Column(children: <Widget>[
            Text("How many " + _person.consumableUnitName(true) + " did you consume today?"),
            Flexible(child: 
              CupertinoPicker(children: options, onSelectedItemChanged: (int index){
                  selectedAmount =index;
                }, itemExtent: 16,),
              fit:FlexFit.tight,
            ),
            RaisedButton(child: Text("Submit"),
              onPressed: () => setState((){
                    successful =selectedAmount <= _person.expectedSmokingAmount(DateTime.now());
                    calender.add(Day(
                       DateTime.now(),
                       successful
                        )
                      );
                    giveFeedback =true;
                  }
                ),
              )
            ],
          )
        );
    }
    return Scaffold(
        body: Stack(children: <Widget>[IntroPageView(), calender]),
        bottomSheet: Row(
          children: <Widget> [
            Expanded(child: RaisedButton(
              child: Text("Testing"),
              onPressed: () {
                            showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text("Test"),
                titlePadding: EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 24.0),
              ),
        );
              },
            ),)
          ]
        ),);
  }
}
