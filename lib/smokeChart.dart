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
    // TODO: implement build
    return null;
  }
}