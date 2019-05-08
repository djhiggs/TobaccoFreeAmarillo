import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../usefulInfo/quiz.dart';
import 'package:synchronized/synchronized.dart';
class Database
{
  static Database _instance;
  SharedPreferences _local;
  DatabaseReference _remote;
  ///Not for you to use!
  Database();
  ///This gets an instance
  ///use this to get an object, don't just use a constructor!!!
  static Future<Database> getInstance() async{
    if(_instance ==null || _instance._local == null){
      _instance =Database();
      _instance._local 
      = await SharedPreferences.getInstance();
      if(_instance.getCanUseRemote()){
        if(_instance["remotePath"] ==null){
          _instance._remote = FirebaseDatabase.instance.reference().push();
          _instance["remotePath"] =_instance._remote.path;
        }
        else
          _instance._remote = FirebaseDatabase.instance.reference().child(_instance["remotePath"]);
      }
      Quiz.initialize(_instance);
    }
    return _instance;
  }
  static bool get loaded => _instance ==null && _instance._local ==null;
  //TODO: get it so this is not necessary (always true bypass)
  bool getCanUseRemote() => this["CanUseRemote"]==true||true;
  void setCanUseRemote(bool value) => setLocal("CanUseRemote", value);
  ///This gets an instance
  ///use this to get an object, don't just use a constructor!!!
  static Database getLoadedInstance() {
    if(_instance ==null || _instance._local ==null)
      throw Exception("Database not fully loaded");
    return _instance;
  }
  ///Checks if the database has been created on this device.
  bool exists() => 
    _local.getKeys().length != 0;  
  dynamic get the => throw Exception("OBJECT NOT FOUND");
  ///Returns the object as specified by a String perameter.
  operator [](String key) => _local.get(key);

  ///Sets an object identified by the 'key' (String) perameter.
  void operator []=(String key,dynamic value) async{
    setLocal(key, value);
    if(getCanUseRemote())
      await _remote.set(<String,dynamic>{key:value});
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
    //Map<String,dynamic> changedData = Map();
    for(String key in data.keys){
      //var localCopy = this[key];
      var newData = data[key];
  //    if(localCopy != newData){
        //changedData[key]=newData;
//
      //}
      await setLocal(key, newData);
    }
    if(getCanUseRemote())
      await _remote.set(data);
  }  
}