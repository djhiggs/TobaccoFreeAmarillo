import 'package:flutter/material.dart';
class Day{
  DateTime dateTime;
  bool successful;
}
class Calender extends StatefulWidget{
  List<Day> days;

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
  static const int LENGTH = 3;
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
          Text(_WEEK_DAYS[days[i].dateTime.weekday].substring(0,3)),
          CircleAvatar(
            child:  Text(days[i].dateTime.day.toString()),
            backgroundColor: days[i].successful? Colors.green : Colors.red
          )
        ],
      ));
      return Column(children: <Widget>[
        Row(
          children: <Widget>[

            IconButton(icon: Icon(Icons.chevron_left),
              onPressed: () => setState((){
                startingIndex -= LENGTH;
                if(startingIndex < 0)
                  startingIndex = 0;
              })),

            Text(_MONTHS[days[startingIndex].dateTime.month] + days[startingIndex].dateTime.year.toString()),
            
            IconButton(icon: Icon(Icons.chevron_right),
              onPressed: () => setState((){
                startingIndex += LENGTH;
                if(startingIndex + columns.length >= days.length)
                  startingIndex = days.length - columns.length - 1;
              })),
          ],
        ),
        Row(children: columns)
      ]);
    }
  }
  
}