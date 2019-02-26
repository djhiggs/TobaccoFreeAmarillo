import 'smokeChart.dart';
import 'database.dart';
class Person
{
  Database db;
  String nickname;
  bool notificationsEnabled;
  bool soundEnabled;
  SmokeChartState smokeChart; 
  Person()
  {
    db = Database();
    smokeChart = SmokeChartState();
    if(null == null)//no file stored
    {
      nickname = "";
      notificationsEnabled =false;
      soundEnabled =false;
    }
    else
    {
      throw new Exception("Case not implemented, get some IO!!!!");
    }
  }

  void export(){

    //cloud saved elements
    db.createRecord("Users",{
      'DesiredCessationTime':smokeChart.sessationChangeTimeDays,
      'EndingUsage':smokeChart.desiredEndAmount,
      'Nickname':nickname,
      'Product':TobaccoProducts.values.indexOf(smokeChart.vice),
      'StartingUsage':smokeChart.startingAmountPerWeek
    });
    //local settings
  }
  void import(){

  }
}