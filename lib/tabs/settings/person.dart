
import 'database.dart';
import 'dart:math';
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
    desiredDaysUntilComplete = 100;
    startingUsage = 5;
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
      _person.import();
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
  ///the total amount of days from the first day to the desired last day
  int desiredDaysUntilComplete;
  int startingUsage;
  int desiredUsage;
  TobaccoProducts product;
  int zipCode;
  int expectedSmokingAmount(DateTime time) {
    double a = startingUsage + 1.0;
    double b = (desiredUsage + 1)/a;
    double c = (time.millisecondsSinceEpoch~/Duration.millisecondsPerDay 
      - startDate.millisecondsSinceEpoch~/Duration.millisecondsPerDay)/
      desiredDaysUntilComplete;
    //return (a * pow(b,c) - 1).round();
    var y = (a * pow(b,c) - 1).ceil();
    return y;
  }
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
      'DesiredUsage':desiredUsage,
      'Nickname':nickname,
      'Product':TobaccoProducts.values.indexOf(product),
      'StartingUsage':startingUsage,
      'StartMilisecondSinceEpoch':startDate.millisecondsSinceEpoch,
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
    var data = db["DesiredDaysUntilComplete"];
    desiredDaysUntilComplete = data == null?100:data;

    data = db["DesiredUsage"];
    desiredUsage = data==null?0:data;

    data = db["Nickname"];
    nickname = data==null?"Atlas":data;

    data = db["Product"];
    product = TobaccoProducts.values.elementAt(data==null?0:data);

    data = db["StartingUsage"];
    startingUsage = data==null?0:data;

    data = db["StartMilisecondSinceEpoch"];
    startDate = data==null?DateTime.now():DateTime.fromMillisecondsSinceEpoch(data);

    notificationsEnabled = db["NotificationsEnabled"] == true;

    soundEnabled = db["SoundEnabled"] == true;

    data = db["ZipCode"];
    zipCode = data==null?0:data;
  }
}