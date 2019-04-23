import 'package:flutter/material.dart';
import 'categories.dart';

// Builds the Expanding tiles Widgets for the drop down children and children of those children
class CategoriesWidget extends StatefulWidget{
  Categories _categories =Categories();
  @override
  CategoriesWidgetState createState() {
    return CategoriesWidgetState(_categories);
  }

}
class CategoriesWidgetState extends State<CategoriesWidget>{
  Categories _categories;
  CategoriesWidgetState(this._categories);
  @override
  Widget build(BuildContext context) {
    if(_categories.categories ==null){
      _categories.import().whenComplete(() =>setState(() {}));
      return Container();
    }
    var children = <Widget>[
      /*ListTile(title: Text("Useful Information",textScaleFactor: 1.8,))*/
    ];
    for(var c in _categories.categories)
      children.add(c.build(context));
    return new Container(
      alignment: Alignment.center,
      child: ListView(
        children: children
      ),
    );
  }
  
}