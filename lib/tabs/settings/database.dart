import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../usefulInfo/quiz.dart';
class Database
{
  static Database _instance;
  SharedPreferences _local;
  DocumentReference _remote;
  ///Not for you to use!
  Database();
  ///This gets an instance
  ///use this to get an object, don't just use a constructor!!!
  static Future<Database> getInstance() async{
    if(_instance ==null){
      _instance =Database();
      await _instance._connect();
      Quiz.initialize(_instance);
    }
    return _instance;
  }
  ///This gets an instance of database if one has already been loaded
  ///otherwise, it returns null
  ///use this to get an object, don't just use a constructor!!!
  static Database getLoadedInstance() => _instance;
  ///Checks if the database has been created on this device.
  bool exists() => 
    _local.getKeys().length != 0;  

  Future _connect() async{
    _local 
    = await SharedPreferences.getInstance();
    if(_local.getKeys().length == 0)
      _remote = await Firestore.instance.collection("Users").add(
        Map<String,dynamic>());
    else
      _remote = Firestore.instance.
        document("Users/" + this["userID"].toString());
  }
  ///Returns the object as specified by a String perameter.
  operator [](String key) => _local.get(key);

  ///Sets an object identified by the 'key' (String) perameter.
  void operator []=(String key,dynamic value) {
    setLocal(key, value);
    _remote.updateData(<String,dynamic>{key:value});
  }

  ///Will set a value to the local datastore ONLY
  ///that is identified by the key perameter.
  ///NOTE: this will mess things up if the perameter
  ///also exists in the remote.
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

  //updates a collection of variables locally and
  //in the remote database
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