import 'package:shared_preferences/shared_preferences.dart';
class Achievement{
  bool status;
  String name;
  String description;
  int points;

  Achievement(this.status, this.name, this.description, this.points);
  init(){
    // TODO: init external data
  }
  load(){
    SharedPreferences.getInstance().then((SharedPreferences s){
      status = s.getBool("Achievements.$name");
    });
  }
  complete(){
    //add points
    status = true;
    var instance = SharedPreferences.getInstance(); 
    SharedPreferences.getInstance().then((SharedPreferences s){
      s.setBool("Achievements.$name", status);
    });
  }
}