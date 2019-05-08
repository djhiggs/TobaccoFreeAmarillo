
import 'database.dart';
enum TobaccoProducts{
    Smoking,
    Vaping,
    SmokelessTobacco,
  }
class Person
{

  Person(){ 
    db = Database();
    nickname = "";
    notificationsEnabled =false;
    soundEnabled =false;
    zipCode = -1;
    startDate =DateTime.now();
    desiredDaysUntilComplete = -1;
    averageUsage = 5;
    desiredUsage = 0;
    product =TobaccoProducts.Vaping;
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
  static Person getLoadedInstance()
  {
    if(_person ==null){
          if(Database.loaded){
            if(_person ==null){
              _person = Person();
              _person.db =Database.getLoadedInstance();
              if(!_person.db.exists())
                _person.export();
        }
      }
      else
        throw Exception("Person not loaded yet");
    }
    return _person;
  }
  Database db;
  String nickname;
  bool notificationsEnabled;
  bool soundEnabled;
  DateTime startDate;
  int desiredDaysUntilComplete;
  int averageUsage;
  int desiredUsage;
  TobaccoProducts product;
  int zipCode;
  int expectedSmokingAmount(DateTime time) => 3;
  //TODO: check these names
  String consumableUnitName(bool plural){
    switch (product) {
      case TobaccoProducts.SmokelessTobacco:
        return plural? "Containers" : "Container";
      case TobaccoProducts.Smoking:
        return plural? "Cigarettes" : "Cigarette";
      case TobaccoProducts.Vaping:
        return plural? "Cartridges" : "Cartridge" ;
      default:
        throw Exception("Item does not exist"); 
    }
  }
  Future export() async{
    var userData = {
      'DesiredDaysUntilComplete':desiredDaysUntilComplete,
      'EndingUsage':desiredUsage,
      'Nickname':nickname,
      'Product':TobaccoProducts.values.indexOf(product),
      'StartingUsage':averageUsage,
      'StartDate':startDate.millisecondsSinceEpoch,
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
    desiredDaysUntilComplete = int.parse(db["DesiredDaysUntilComplete"]);
    desiredUsage = int.parse(db["EndingUsage"]);
    nickname = db["Nickname"];
    product = TobaccoProducts.values.elementAt(int.parse(db["Product"]));
    averageUsage = int.parse(db["StartingUsage"]);
    startDate = DateTime.fromMicrosecondsSinceEpoch(int.parse(db["StartDate"]));
    notificationsEnabled = db["NotificationsEnabled"] =="true";
    soundEnabled = db["SoundEnabled"] =="true";
    zipCode = int.parse(db["ZipCode"]);
  }
}