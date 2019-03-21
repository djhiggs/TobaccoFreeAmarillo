import 'package:flutter/material.dart';
import '../settings/person.dart';
class Home extends StatefulWidget {
  Person _person;
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomeState(_person);
  }
}
class HomeState extends State<Home>{
  Person _person;
  HomeState(this._person):super();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if(_person ==null)
    {
      _person =Person();//initial state to get rid of nulls
      Person.getInstance().then((Person p){
          _person = p;
          setState((){});
        });
    }
    return new Container(
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          new Icon(
            Icons.home,
            size: 64.0,
            color: Colors.black12
          ),
          new Text('Welcome Back'),
          new Text(_person.nickname),
          Text('You have been free for'),
          Text(DateTime.now().difference(_person.smokeChart.startDate).inDays.toString() + " days"),
                    new OutlineButton(
            child: Text("Reset"),
            onPressed: (){
              showDialog(context: context, builder: (BuildContext c){
                return AlertDialog(title: Column(mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Are you sure?"),
                    ButtonBar(children: <Widget>[
                      FlatButton(child: Text("Yes"),onPressed: (){
                        _person.smokeChart.startDate =DateTime.now();
                        _person.export();
                        Navigator.of(c).pop();
                        setState(() {});
                      },),
                      FlatButton(child: Text("No"),onPressed: 
                        () { 
                          Navigator.of(c).pop();
                          setState(() {});
                          },)
                    ],)
                  ],));
              });
            },
          ),
          new Text("Approximate Money Saved"),
          new Text("\$"+(_person.smokeChart.averageUsage*5.06*(
            (DateTime.now().millisecondsSinceEpoch - _person.smokeChart.startDate.millisecondsSinceEpoch)/(3600*1000*24*7))).toString()),
          //_person.smokeChart.build(context),
        ],
      )
    );
  }

}