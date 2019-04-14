import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Database
{
  static Database _instance;
  SharedPreferences _local;
  DocumentReference _remote;
  Database();
  static Future<Database> getInstance() async{
    if(_instance ==null){
      _instance =Database();
      await _instance.connect();
    }
    return _instance;
  }
  bool exists() => 
    _local.getKeys().length != 0;  

  Future connect() async{
    _local 
    = await SharedPreferences.getInstance();
    if(_local.getKeys().length == 0)
      _remote = await Firestore.instance.collection("Users").add(
        Map<String,dynamic>());
    else
      _remote = Firestore.instance.
        document("Users/" + this["userID"].toString());
  }

  operator [](String key) => _local.get(key);

  void operator []=(String key,dynamic value) {
    setLocal(key, value);
    _remote.updateData(<String,dynamic>{key:value});
  }

  Future<bool> setLocal(String key,dynamic value){
    var type = value.runtimeType;
    if(type == true.runtimeType)
      return _local.setBool(key, value);
    if(type == 1.0.runtimeType)
      return _local.setDouble(key, value);
    if(type == 1.runtimeType)
      return _local.setInt(key, value);
    if(type == "".runtimeType)
      return _local.setString(key, value);
    if(type == <String>[].runtimeType)
      return _local.setStringList(key, value);
    return _local.setString(key, value.toString());
  }
  Future updateRange(Map<String,dynamic> data) async{
    Map<String,dynamic> changedData = Map();
    for(String key in data.keys){
      var localCopy = this[key];
      var newData = data[key];
      if(localCopy != newData){
        changedData[key]=newData;
        await setLocal(key, newData);
      }
    }
    await _remote.updateData(changedData);
  }  
}
