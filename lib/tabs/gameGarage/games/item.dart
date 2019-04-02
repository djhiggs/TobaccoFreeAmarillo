class Item{
  String itemName;
  String itemDescription;
  int crushPerClick;
  int price;
  int amountOfItem = 0;

  Item(
    this.itemName,
    this.itemDescription,
    this.crushPerClick,
    this.price
  );
  void incrementItem() {
    amountOfItem++;
  }

  //void update(double dt) {
  //  amountOfItem += increaseRate*dt;
  //}
}


