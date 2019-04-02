
class Upgrade{
  Upgrade(this.cost,this.isPassive,this.incrementAmount,this.amountOwned,this.title);
  int cost;
  bool isPassive;
  //This is per second if the upgrade is passive.
  //Otherwise, it is for each click.
  int incrementAmount;
  int amountOwned;
  String title;
}