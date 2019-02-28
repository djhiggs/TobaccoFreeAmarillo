import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
class Database
{
  final String _packageName = "anti.vaping.tmp";
  final String _nickname = "tobaccoFreeApp";
  //DOUBLE-STRUCK CAPITAL C (Complex domain symbol)
  final String _delimiter =String.fromCharCode(8450);
  static String _clientID = "";
  static String _baseDirectory;

  Firestore db = Firestore.instance;
  void createRecordRemote(String table, Map<String, dynamic> content)
  {
    if(_clientID.length == 0)
    {
      var raw =getLocalData("remoteData.txt");
      if(raw ==null)
      {
        db.collection(table).add(content).then(
          (DocumentReference reference) {
            _clientID = reference.documentID;
          });
          setLocalData("remoteData.txt", {"clientID":_clientID});
      }
      else
        _clientID =raw["clientID"];
    }
    else
      db.document(table + '/' + _clientID).updateData(content);
  }
  void _initLocal() =>
    getApplicationDocumentsDirectory().then(
      (Directory dir){
        _baseDirectory = dir.path;
      }
    );
  void setLocalData(String filename, Map<String,dynamic> map)
  {
    if(_baseDirectory ==null)
      _initLocal();
    var writer = File(_baseDirectory + filename).openWrite();
    map.forEach((String key, dynamic value){
      writer.writeln(key + _delimiter + value.toString());
    });
    writer.close();
  }
  Map<String,String> getLocalData(String filename){
    if(_baseDirectory ==null)
      _initLocal();
    try{
    Map<String,String> data = new Map<String,String>();
    var lines = File(_baseDirectory + filename).readAsLinesSync();
    for(var line in lines){
      //name + _delimiter + value
      //no quotes or spaces
      var tokens = line.split(_delimiter);  
      data[tokens[0]] = tokens[1]; 
    }
    return data;
    }
    catch(e)
    {
      return null;
    }
  }
}