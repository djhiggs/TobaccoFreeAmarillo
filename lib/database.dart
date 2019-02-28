import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Database
{
  final String _packageName = "anti.vaping.tmp";
  final String _nickname = "tobaccoFreeApp";
  //DOUBLE-STRUCK CAPITAL C (Complex domain symbol)
  static String _clientID = "";

  Firestore db = Firestore.instance;
  Future createRecordRemote(String table, Map<String, dynamic> content) async
  {
    if(_clientID.length == 0)
    {
      var prefs =await SharedPreferences.getInstance();
      try{
        _clientID =prefs.getString("ClientID");
        //throw null;
      }
      catch (e) 
      {
        db.collection(table).add(content).then(
          (DocumentReference reference) {
            _clientID = reference.documentID;
            prefs.setString("ClientID", _clientID);
          });
      }
    }
    else
      db.document(table + '/' + _clientID).updateData(content);
  }
  
  //bool initDone = false;
  //void setLocalData(String filename, Map<String,dynamic> map) async
  //{
  //  var writer = (await _getLocalFile(filename)).openWrite();
  //  map.forEach((String key, dynamic value){
  //    writer.writeln(key + _delimiter + value.toString());
  //  });
  //  writer.close();
  //}
  void setLocalData(Map<String,dynamic> values) async
  {
    var preferences =await SharedPreferences.getInstance();
    values.forEach((String key, dynamic value){
      preferences.setString(key, value.toString());
    });
  }
  Future<Map<String,String>> getLocalData(List<String> keys) async
  {
    var preferences =await SharedPreferences.getInstance();
    Map<String,String> data = new Map();
    for(var key in keys)
      data[key] =preferences.getString(key);
    return data;
  }
  //Future<Map<String,String>> getLocalData(String filename) async
  //{
  //  try{
  //    Map<String,String> data = new Map<String,String>();
  //    //var lines = (await _getLocalFile(filename)).readAsLinesSync();
  //    var obj = (await _getLocalFile(filename));
  //    if(!obj.existsSync())
  //      return null;
  //    var lines = obj.readAsLinesSync();
  //    for(var line in lines){
  //      //name + _delimiter + value
  //      //no quotes or spaces
  //      var tokens = line.split(_delimiter);  
  //      data[tokens[0]] = tokens[1]; 
  //    }
  //    return data;
  //  }
  //  catch(e)
  //  {
  //    return null;
  //  }
  //}
}