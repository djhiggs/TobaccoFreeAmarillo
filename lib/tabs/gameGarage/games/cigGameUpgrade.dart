import 'clicker.dart';
class CigGameUpgrade{
  int cost;
  bool isPassive;
  //This is per second if the upgrade is passive.
  //Otherwise, it is for each click.
  int incrementAmount;
  int amountOwned() => _amountOwned;
  int _amountOwned; 
  String title;
  purchase(MyHomePage game) => isPassive? 
    game.passiveIncreaseRate += incrementAmount : 
    game.activeIncreaseRate += incrementAmount;
}