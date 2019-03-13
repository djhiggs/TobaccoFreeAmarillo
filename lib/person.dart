import 'smokeChart.dart';
import 'database.dart';
class Person
{

  Person(){ 
    db = Database();
    smokeChart = SmokeChartState();
    nickname = "";
    notificationsEnabled =false;
    soundEnabled =false;
    zipCode = -1;
  }
  static Person _person =null;


  static Future<Person> getInstance() async
  {
    if(_person ==null)
      _person =Person();
      await _person._initialize();
    return _person;
  }
  Database db;
  String nickname;
  bool notificationsEnabled;
  bool soundEnabled;
  SmokeChartState smokeChart; 
  int zipCode;

  _initialize() async
  {

    db = Database();
    smokeChart = SmokeChartState();
    nickname = "";
    notificationsEnabled =false;
    soundEnabled =false;
    zipCode = -1;
    await import();
  }

  void export() async{
    var userData = {
      'DesiredDaysUntilComplete':smokeChart.desiredDaysUntilComplete,
      'EndingUsage':smokeChart.desiredUsage,
      'Nickname':nickname,
      'Product':TobaccoProducts.values.indexOf(smokeChart.product),
      'StartingUsage':smokeChart.averageUsage,
      'StartDate':smokeChart.startDate.millisecondsSinceEpoch,
      'ZipCode':zipCode,
    };
    //cloud saved elements
    db.createRecordRemote("Users",userData).whenComplete(()
      {
        userData["NotificationsEnabled"] =notificationsEnabled;
        userData["SoundEnabled"] =soundEnabled;
        db.setLocalData(userData);
      }
    );
    //local settings

  }
  Future<bool> import() async
  {
    var raw = await db.getLocalData(<String>[
      'DesiredDaysUntilComplete',
      'EndingUsage',
      'Nickname',
      'Product',
      'StartingUsage',
      'StartDate',
      'NotificationsEnabled',
      'SoundEnabled',
      'ZipCode'
    ]);
    
    if(raw ==null)
      return false;
    else
      {
        try{
          smokeChart.desiredDaysUntilComplete = int.parse(raw["DesiredDaysUntilComplete"]);
          smokeChart.desiredUsage = int.parse(raw["EndingUsage"]);
          nickname = raw["Nickname"];
          smokeChart.product = TobaccoProducts.values.elementAt(int.parse(raw["Product"]));
          smokeChart.averageUsage = int.parse(raw["StartingUsage"]);
          smokeChart.startDate = DateTime.fromMicrosecondsSinceEpoch(int.parse(raw["StartDate"]));
          notificationsEnabled = raw["NotificationsEnabled"] =="true";
          soundEnabled = raw["SoundEnabled"] =="true";
          zipCode = int.parse(raw["ZipCode"]);
        }
        catch(e){//this can most likely be removed (or should at least have a better catch)
          return false;
        }
        return true;
      }
  }
}