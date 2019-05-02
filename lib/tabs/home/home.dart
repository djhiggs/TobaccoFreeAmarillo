import 'package:flutter/material.dart';
import '../settings/person.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'intro_page_view.dart';
import 'day_result.dart';


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
  Widget build(BuildContext context) {
    if (_person == null) {
      _person = Person(); //initial state to get rid of nulls
      Person.getInstance().then((Person p) {
        _person = p;
        setState(() {});
      });
    }
    _onPressed() {
      showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Check out your successful days with this Calender!"),
        //contentPadding: ,
        titlePadding: EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 24.0),
        ),
      );
    }
    double calenderPosition = 385.0;
    
    DayResult day1 = new DayResult(DateTime.utc(2019,4,25), Icon(Icons.check));
    
    EventList<DayResult> successfulDays = EventList<DayResult>();
    
    successfulDays.add(DateTime.utc(2019,4,25), day1);
    //successfulDays.add(DateTime.utc(2019,4,24),);
    //successfulDays.add(DateTime.utc(2019,4,23),);
    
    return new Scaffold(
        body: new Stack(
      children: <Widget>[
        IntroPageView(),
        Container(
            margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, calenderPosition),
            child: Center(
              child: CalendarCarousel<DayResult>(
                //iconColor: Theme.of(context).primaryColor,
                weekFormat: true,
                //weekdayTextStyle:
                    //TextStyle(fontSize: 14.0, color: Theme.of(context).primaryColor),
                //headerTextStyle: TextStyle(fontSize: 25.0, color: Colors.black),
                //weekFormat: false,
                //weekDayFormat: WeekdayFormat.short,
                height: 300.0,
                // selectedDayBorderColor: Colors.white,
                // selectedDayButtonColor: Colors.white,
                // selectedDayTextStyle: TextStyle(color: Colors.black),
                markedDatesMap: successfulDays,
                markedDateIconBorderColor: Colors.red,
                markedDateWidget: Icon(Icons.check),
                // todayBorderColor: Colors.white,
                // todayButtonColor: Colors.white,
                // todayTextStyle: TextStyle(color: Colors.black),
                //onDayPressed: (DateTime data, List<>),
                //onDayPressed: (DateTime data, List<bool> days){
                //  _onPressed();
                //}
              ),
            )),
        Opacity(
          opacity: 0.0,
          child: ButtonTheme(
            minWidth: 500.0,
            child: Container(
              margin:
                  EdgeInsets.fromLTRB(0.0, 0.0, 0.0, calenderPosition - 100),
              child: Center(
                child: RaisedButton(
                  onPressed: () {_onPressed();},
                ),
              ),
            ),
          ),
        ),
      ],
    ));

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
