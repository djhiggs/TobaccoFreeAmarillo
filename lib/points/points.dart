import 'package:shared_preferences/shared_preferences.dart';
class Points
{
  int _points;
  SharedPreferences _io;
  
  void addPoints(int amount) // Adds points from point generators
  {
    _points +=amount;
    _io.setInt("Points",_points);
  }

  bool checkPoints(int checking) => _points >=checking; // Compares cost of purchase to number of points user has

  int getPoints() // Shows points total to user.
  {
    return _points;
  }

  bool subtractPoints(int amount)  // If checkPoints passes, subtracts points during purchase.
  { 
    if(!checkPoints(amount))
      return false;
    addPoints(-amount);
    return true;
  }

// Stores the points from the app to the local storage 
// and compares that total to storage upon relaunch of app.
  static Future<Points> getInstance() async 
  {
    Points instance = Points();
    instance._io = await SharedPreferences.getInstance();
    try {
      instance._points = instance._io.getInt("Points"); 
    } catch (e) 
    {
      instance._points = 0;
      instance.addPoints(0);
    }
    return instance;
  }
}