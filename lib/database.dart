import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class Database
{
  final String _packageName = "anti.vaping.tmp";
  final String _nickname = "tobaccoFreeApp";
  static String _clientID = "";


  Firestore db = Firestore.instance;

  void createRecord(String table, Map<String, dynamic> content)
  {
    if(_clientID.length == 0)
      db.collection(table).add(content).then(
        (DocumentReference reference) {
          _clientID = reference.documentID;
        });
    else
      db.document(table + '/' + _clientID).updateData(content);
  }
  
}