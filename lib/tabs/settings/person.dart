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

  ///use this to create a person instance
  static Future<Person> getInstance() async
  {
    if(_person ==null){
      _person = Person();
      _person.db =await Database.getInstance();
      if(!_person.db.exists())
        await _person.export();
    }
    return _person;
  }
  Database db;
  String nickname;
  bool notificationsEnabled;
  bool soundEnabled;
  SmokeChartState smokeChart; 
  int zipCode;
  int expectedSmokingAmount(DateTime time) => 3;
  Future export() async{
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
    await db.updateRange(userData);
    //local settings
    await db.setLocal('NotificationsEnabled',notificationsEnabled);
    await db.setLocal('SoundEnabled',soundEnabled);
  }
  Future import() async
  {
    smokeChart.desiredDaysUntilComplete = int.parse(db["DesiredDaysUntilComplete"]);
    smokeChart.desiredUsage = int.parse(db["EndingUsage"]);
    nickname = db["Nickname"];
    smokeChart.product = TobaccoProducts.values.elementAt(int.parse(db["Product"]));
    smokeChart.averageUsage = int.parse(db["StartingUsage"]);
    smokeChart.startDate = DateTime.fromMicrosecondsSinceEpoch(int.parse(db["StartDate"]));
    notificationsEnabled = db["NotificationsEnabled"] =="true";
    soundEnabled = db["SoundEnabled"] =="true";
    zipCode = int.parse(db["ZipCode"]);
  }
}