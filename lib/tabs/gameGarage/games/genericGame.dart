import 'package:flutter/material.dart';
import 'package:flame/game.dart' as game;
import 'package:flame/flame.dart' as flame;
import '../../settings/database.dart';
class GenericGame extends game.BaseGame{
  static int count = 0;
  String title;
  String description;
  BuildContext _context;
  int price;
  bool get purchased =>_purchased;
  void purchase(){
    db.setLocal("GamePrice.$title", false);
    _purchased =true;
  }
  bool _purchased;
  static Database db;
  GenericGame(this._context,this.price){
    title = "Game " + (count++).toString();
    description = "This is a game";
    //initialize();
    return;
    if(db == null)
      Database.getInstance().then((Database data){
        db = data;
        _purchased = db["GamePrice.$title"];
        if(_purchased)
        db.setLocal("GamePrice.$title", false);
      });
    else{
      _purchased = db["GamePrice.$title"];
      if(_purchased)
        db.setLocal("GamePrice.$title", false);
    }
  }
  static Future<void> initialize() async{
    db = await Database.getInstance();
  }
  open(){
    Navigator.push(_context, MaterialPageRoute(builder: (BuildContext context) {
      return this.widget;
    }));
  }
  close(){
    Navigator.of(_context).pop();
  }
}