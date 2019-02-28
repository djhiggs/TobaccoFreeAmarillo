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
    if(!import())//no file stored
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
    var userData = {
      'DesiredCessationTime':smokeChart.sessationChangeTimeDays,
      'EndingUsage':smokeChart.desiredEndAmount,
      'Nickname':nickname,
      'Product':TobaccoProducts.values.indexOf(smokeChart.vice),
      'StartingUsage':smokeChart.startingAmountPerWeek,
      'StartingDate':smokeChart.sessationStartDate
    };
    //cloud saved elements
    db.createRecordRemote("Users",userData);
    //local settings
    userData["notificationsEnabled"] =notificationsEnabled;
    userData["soundEnabled"] =soundEnabled;
    db.setLocalData("userData.txt", userData);
  }
  bool import(){
    var raw = db.getLocalData("userData.txt");
    if(raw ==null)
      return false;
    else
      {
        smokeChart.sessationChangeTimeDays = int.parse(raw["DesiredCessationTime"]);
        smokeChart.desiredEndAmount = int.parse(raw["EndingUsage"]);
        smokeChart.vice = TobaccoProducts.values[int.parse(raw["Product"])];
        smokeChart.startingAmountPerWeek = int.parse(raw["StartingUsage"]);
        smokeChart.sessationChangeTimeDays = int.parse(raw["DesiredCessationTime"]);
        smokeChart.sessationStartDate = DateTime.fromMicrosecondsSinceEpoch(int.parse(raw["StartDate"]));
        return true;
      }
  }
}