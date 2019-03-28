import 'package:flutter/material.dart';
import '../settings/person.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import '../achievement_page/achievement.dart';
import 'intro_page_view.dart';

class Home extends StatefulWidget {
  Person _person;
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomeState(_person);
  }
}

class HomeState extends State<Home> {
  Person _person;
  HomeState(this._person) : super();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (_person == null) {
      _person = Person(); //initial state to get rid of nulls
      Person.getInstance().then((Person p) {
        _person = p;
        setState(() {});
      });
    }
    return new Scaffold(
        body: new Stack(
          children: <Widget>[
            IntroPageView(),
            Container(
                margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 445.0),
                child: Center(
                  child: CalendarCarousel<Achievement>(
                    weekFormat: true,
                    weekDayFormat: WeekdayFormat.short,
                    height: 170.0,
                    onDayPressed:
                        (DateTime data, List<Achievement> achievement) {
                      this.setState(() {});
                    },
                  ),
                ))
          ],
        ));
  }
}
