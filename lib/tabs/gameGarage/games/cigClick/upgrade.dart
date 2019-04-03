import 'dart:math';
class Upgrade{
  Upgrade(this.initialCost,this.priceIncreaseRate,this.isPassive,this.incrementAmount,this.amountOwned,this.title);
  int initialCost;
  double priceIncreaseRate;
  bool isPassive;
  //This is per second if the upgrade is passive.
  //Otherwise, it is for each click.
  int incrementAmount;
  int amountOwned;
  String title;
  double cost() => exp(amountOwned * priceIncreaseRate) * initialCost;
}