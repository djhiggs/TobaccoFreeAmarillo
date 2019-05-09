import 'package:flutter/material.dart';
import 'package:tobaccoFreeAmarilloApp/tabs/settings/person.dart';
import '../settings/database.dart';
class Day{
  DateTime dateTime;
  ///If this is null then the success value was not specified
  bool successful;
  Day(this.dateTime,this.successful);
  ///returns the days since epoch for 'dateTime'
  int daysSinceEpoch() => dateTime.millisecondsSinceEpoch ~/ Duration.millisecondsPerDay;
}
class Calender extends StatefulWidget{
  static List<Day> _days= List();
  static Database db;
  static Person person;
  bool isEmpty() => _days.length == 0;
  bool updatedToday() => !isEmpty() && _days.last.daysSinceEpoch() == DateTime.now().millisecondsSinceEpoch ~/ Duration.millisecondsPerDay;
  void _load(){
    _days = List();
    //- for not specified
    //1 for successful
    //0 for not successful
    String stats = db["SuccessStats"];
    if(stats == null)
      stats = "";
    for(int i = 0; i < stats.length; i++)
      _days.add(Day(person.startDate.add(Duration(days: i)),stats[i]=='-'?null:stats[i]=='1'));
  }
  void add(Day day){
    print("_days.length = " + _days.length.toString());
    if(_days.length > 0)
      while(_days.last.daysSinceEpoch() + 2 < day.daysSinceEpoch())
        _days.add(Day(_days.last.dateTime.add(Duration(days: 1)),null));
    _days.add(day);
    _store();
  }
  void _store(){
    if(_days.length == 0)
      return;  
    //- for not specified
    //1 for successful
    //0 for not successful
    String stats = _days[0].successful == null?'-':(_days[0].successful?'1':'0');

    for(int i = 1; i < _days.length; i++){
      int difference = _days[i].dateTime.millisecondsSinceEpoch~/Duration.millisecondsPerDay
        -_days[i-1].dateTime.millisecondsSinceEpoch~/Duration.millisecondsPerDay;
      for(int j = 0; j < difference; j++)
        stats += '-';
      stats += _days[i].successful == null?'-':(_days[i].successful?'1':'0');
    }
    db.setLocal("SuccessStats", stats);
  }
  Calender(){
    db = Database.getLoadedInstance();
    person = Person.getLoadedInstance();
    if(_days.length == 0)
      _load();
  }
  @override
  State<StatefulWidget> createState() {
    
    return CalenderState(
      _days.length>CalenderState.LENGTH?_days.length - CalenderState.LENGTH : 
      0,_days);
  }
}
class CalenderState extends State<Calender>{
  List<Day> _days;
  int startingIndex;
  CalenderState(this.startingIndex,this._days);
  static const int LENGTH = 7;
  static const List<String> _WEEK__days =<String>[
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday",
  ]; 
  static const List<String> _MONTHS =<String>[
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec",
  ]; 
  @override
  Widget build(BuildContext context) {
    List<Widget> columns = List();
    for(int i = startingIndex; i < LENGTH + startingIndex && i < _days.length; i++){
      columns.add(Column(
        children: <Widget>[
          Text(_WEEK__days[_days[i].dateTime.weekday-1].substring(0,3)),
          CircleAvatar(
            child:  Text(_days[i].dateTime.day.toString()),
            backgroundColor: _days[i].successful == null? Colors.white : 
              _days[i].successful? Colors.green: Colors.red
          )
        ],
      ));
    }
    return Column(children: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[

          IconButton(icon: Icon(Icons.chevron_left),
            onPressed: () => setState((){
              startingIndex -= LENGTH;
              if(startingIndex < 0)
                startingIndex = 0;
            })),

          Text(_MONTHS[_days[startingIndex].dateTime.month-1]  + ' '+ _days[startingIndex].dateTime.year.toString(),
            textScaleFactor: 1.8),
          
          IconButton(icon: Icon(Icons.chevron_right),
            onPressed: () => setState((){
              startingIndex += LENGTH;
              if(startingIndex + columns.length >= _days.length)
                startingIndex = _days.length - columns.length;
            })),
        ],
      ),
      Row(children: columns,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,)
    ]);
  }
}