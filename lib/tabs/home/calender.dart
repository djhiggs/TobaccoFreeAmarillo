import 'package:flutter/material.dart';
import 'package:tobaccoFreeAmarilloApp/tabs/settings/person.dart';
import '../settings/database.dart';
class Day{
  DateTime dateTime;
  ///If this is null then the success value was not specified
  bool successful;
  Day(this.dateTime,this.successful);
}
class Calender extends StatefulWidget{
  List<Day> days;
  Database db;
  Person person;
  void load(){
    //- for not specified
    //1 for successful
    //0 for not successful
    days = List();
    String stats = db["SuccessStats"];
    if(stats == null)
      stats = "";
    for(int i = 0; i < stats.length; i++)
      days.add(Day(person.startDate.add(Duration(days: i)),stats[i]=='-'?null:stats[i]=='1'));

    
  }
  void store(){
    if(days.length == 0)
      return;  
    //- for not specified
    //1 for successful
    //0 for not successful
    String stats = days[0].successful == null?'-':(days[0].successful?'1':'0');

    for(int i = 1; i < days.length; i++){
      int difference = days[i].dateTime.millisecondsSinceEpoch~/Duration.millisecondsPerDay
        -days[i-1].dateTime.millisecondsSinceEpoch~/Duration.millisecondsPerDay;
      for(int j = 0; j < difference; j++)
        stats += '-';
      stats += days[i].successful == null?'-':(days[i].successful?'1':'0');
    }
    db.setLocal("SuccessStats", stats);
  }
  Calender(){
    db = Database.getLoadedInstance();
    person = Person.getLoadedInstance();
  }
  @override
  State<StatefulWidget> createState() {
    
    return CalenderState(
      days.length>CalenderState.LENGTH?days.length - CalenderState.LENGTH : 
      0,days);
  }
}
class CalenderState extends State<Calender>{
  List<Day> days;
  int startingIndex;
  CalenderState(this.startingIndex,this.days);
  static const int LENGTH = 7;
  static const List<String> _WEEK_DAYS =<String>[
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
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
    for(int i = startingIndex; i < LENGTH + startingIndex && i < days.length; i++){
      columns.add(Column(
        children: <Widget>[
          Text(_WEEK_DAYS[days[i].dateTime.weekday-1].substring(0,3)),
          CircleAvatar(
            child:  Text(days[i].dateTime.day.toString()),
            backgroundColor: days[i].successful == null? Colors.white : 
              days[i].successful? Colors.green: Colors.red
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

          Text(_MONTHS[days[startingIndex].dateTime.month-1]  + ' '+ days[startingIndex].dateTime.year.toString(),
            textScaleFactor: 1.8),
          
          IconButton(icon: Icon(Icons.chevron_right),
            onPressed: () => setState((){
              startingIndex += LENGTH;
              if(startingIndex + columns.length >= days.length)
                startingIndex = days.length - columns.length;
            })),
        ],
      ),
      Row(children: columns,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,)
    ]);
  }
}