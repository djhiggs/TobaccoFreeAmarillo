import 'package:flutter/material.dart';
import '../settings/person.dart';
//import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'intro_page_view.dart';
import 'day_result.dart';
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
    super.initState();
    _checkDate();
  }

  Calender calender = Calender();

  _checkDate() async {
    calender.load();
    calender.days.addAll(<Day>[
      Day(DateTime(2019, 4, 27), true),
      Day(DateTime(2019, 4, 28), true),
      Day(DateTime(2019, 4, 29), false),
      Day(DateTime(2019, 4, 30), null),
      Day(DateTime(2019, 5, 01), null),
      Day(DateTime(2019, 5, 02), true),
    ]);
    if (calender.days.length != 0) {
      if (DateTime.now().millisecondsSinceEpoch ~/
              Duration.millisecondsPerDay !=
          calender.days.last.dateTime.millisecondsSinceEpoch ~/
              Duration.millisecondsPerDay) {
                print("jumbalaya");
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text("Test"),
                //contentPadding: ,
                titlePadding: EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 24.0),
              ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    if (_person == null) {
      _person = Person(); //initial state to get rid of nulls
      Person.getInstance().then((Person p) {
        _person = p;
        setState(() {});
      });
    }
    _onPressed() {}
    double calenderPosition = 385.0;

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
    return new Scaffold(
        body: new Stack(children: <Widget>[IntroPageView(), calender]),
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
