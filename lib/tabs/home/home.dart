import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../settings/person.dart';
//import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'intro_page_view.dart';
import 'calender.dart';

class Home extends StatefulWidget {
  Person _person;
  @override
  State<StatefulWidget> createState() {
    return HomeState(_person);
    //List<> achievements = List<>();
  }
}

class HomeState extends State<Home> {
  Person _person;
  HomeState(this._person) : super();
  @override
  void initState() {
    calender.load();
    if(calender.isEmpty()){
      calender.add(Day(DateTime(2019, 4, 27), true));
    }

    super.initState();
    //_checkDate();
  }

  Calender calender = Calender();

  @override
  Widget build(BuildContext context) {
    _person = Person.getLoadedInstance();

    // calender.load();
    // calender.days.addAll(<Day>[
    //   Day(DateTime(2019, 4, 27), true),
    //   Day(DateTime(2019, 4, 28), true),
    //   Day(DateTime(2019, 4, 29), false),
    //   Day(DateTime(2019, 4, 30), null),
    //   Day(DateTime(2019, 5, 01), null),
    //   Day(DateTime(2019, 5, 02), true),
    // ]);
    // calender.store();
    //successfulDays.add(DateTime.utc(2019,4,25), day1);
    //successfulDays.add(DateTime.utc(2019,4,24),);
    //successfulDays.add(DateTime.utc(2019,4,23),);
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
            Text("How many units did you consume today?"),
            Flexible(child: 
              CupertinoPicker(children: options, onSelectedItemChanged: (int index){
                  selectedAmount =index;
                }, itemExtent: 16,),
              fit:FlexFit.tight,
            ),
            RaisedButton(child: Text("Submit"),
              onPressed: () => setState((){
                int n = _person.expectedSmokingAmount(DateTime.now());
                calender.add(Day(
                    DateTime.now(),
                    selectedAmount <= _person.expectedSmokingAmount(DateTime.now())
                    ));
                  }
                ),
              )
            ],
          ));
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
                //contentPadding: ,
                titlePadding: EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 24.0),
              ),
        );
              },
            ),)
          ]
        ),);
    // return new Scaffold(
    //     body: new Stack(
    //   children: <Widget>[
    //     IntroPageView(),
    //     Container(
    //         margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, calenderPosition),
    //         child: Center(
    //           child: calender
    //           )
    //         ),
    //     Opacity(
    //       opacity: 0.0,
    //       child: ButtonTheme(
    //         minWidth: 500.0,
    //         child: Container(
    //           margin:
    //               EdgeInsets.fromLTRB(0.0, 0.0, 0.0, calenderPosition - 100),
    //           // child: Center(
    //           //   child: RaisedButton(
    //           //     onPressed: () {_onPressed();},
    //           //   ),
    //           // ),
    //         ),
    //       ),
    //     ),
    //   ],
    // ));

//     return new Scaffold(
//         body: new Stack(
//           children: <Widget>[
//             Container(
//               child: RaisedButton(
//                 onPressed: _onPressed(),
//               ),
//             ),
//             IntroPageView(),
//           ],
//         )
//     );
  }
}
