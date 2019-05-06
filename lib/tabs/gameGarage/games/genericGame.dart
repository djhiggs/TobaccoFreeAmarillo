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
    db = Database.getLoadedInstance();
    _purchased = db["GamePrice.$title"];
    if(_purchased == null){
      db.setLocal("GamePrice.$title", false);
      _purchased = false;
    }
    // TODO: remove this and get purchase working
    _purchased = true;
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