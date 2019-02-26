import 'package:flutter/material.dart';


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
  DateTime sessationStartDate;
  int sessationChangeTimeDays;
  int startingAmountPerWeek;
  int desiredEndAmount;
  TobaccoProducts vice;

  SmokeChartState({Key key})
  {
    if(true)//no file stored
    {
      sessationStartDate = DateTime.now();
      sessationChangeTimeDays = 72;
      startingAmountPerWeek = 14;
      desiredEndAmount = 2;
    }
    else
    {
      throw new Exception("Case not implemented, get some IO!!!!");
    }
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
}