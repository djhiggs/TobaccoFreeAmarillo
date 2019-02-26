import 'smokeChart.dart';
class Person
{
  Person()
  {
    smokeChart = SmokeChartState();
    if(null == null)//no file stored
    {
      nickname = "nickname";
      notificationsEnabled =false;
      soundEnabled =false;
    }
    else
    {
      throw new Exception("Case not implemented, get some IO!!!!");
    }
  }
  String nickname;
  bool notificationsEnabled;
  bool soundEnabled;
  SmokeChartState smokeChart; 
}