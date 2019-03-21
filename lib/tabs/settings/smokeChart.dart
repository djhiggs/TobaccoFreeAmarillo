import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart';
import 'dart:math';
import 'dart:math' as math;

class SmokeChart extends StatefulWidget {
  @override
  SmokeChartState createState() {
    return new SmokeChartState();
  }
}
  enum TobaccoProducts{
    Smoking,
    Vaping,
    SmokelessTobacco,
  }
class SmokeChartState extends State<SmokeChart> {
  DateTime startDate;
  int desiredDaysUntilComplete;
  int averageUsage;
  int desiredUsage;
  TobaccoProducts product;

  SmokeChartState({Key key})
  {
    startDate = DateTime.now();
    desiredDaysUntilComplete = 72;
    averageUsage = 14;
    desiredUsage = 2;
    product =TobaccoProducts.SmokelessTobacco;
  }
  @override
  Widget build(BuildContext context) {
    LineChart chart = LineChart(<Series>[buildLine(averageUsage, desiredUsage, startDate, startDate.add(Duration(days:desiredDaysUntilComplete)), "Ideal Usage")]);

    // TODO: implement build
    return null;
  }
  final int msInDay = 86400000;
  //final Duration _dt =Duration(hours: 1);
  Series<Point,int> buildLine(int y_0, int y_1, DateTime t_0, DateTime t_1, String id){
    int firstDay = startDate.millisecondsSinceEpoch ~/ msInDay,
    lastDay = t_1.millisecondsSinceEpoch ~/ msInDay; 
    if(firstDay + 365 < lastDay)
      firstDay =lastDay - 365;
    List<Point> points = List();
    double a = (y_0 - y_1)/(exp(-firstDay)-exp(-lastDay));
    for(int i = firstDay; i <=lastDay;i++)
      points.add(Point(i,a*exp(-i)));
    return Series<Point, int>(data: points, domainFn: (Point datum, int index) => datum.x, id: null, measureFn: (Point datum, int index) => datum.y);
  }    
}