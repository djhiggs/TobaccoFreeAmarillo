import 'package:flutter/material.dart';
import 'usefulinfo.dart';

// This class should pull from usefulinfo.dart but I am failing to get this to pull properly
/*


class PassageType {
  PassageType(this.title, [this.children = const <PassageType>[]]);
  final String title;
  final List<PassageType> children;

  var topic = UsefulInfo();
  var passage =  UsefulInfo();



  List<PassageType> passageType = <PassageType>[
    new PassageType(
      'Immediate Health Effects' ,
      <PassageType>[
        new PassageType(topic.infoBox(1),
          <PassageType>[
           new PassageType(passage.infoBox(1),
           new RaisedButton(
             child: const Text ('Take Quiz'),
             color: Colors.white,
             elevation: 4.0,
             splashColor: Colors.blue,
             onPressed: () {
               // Travel to quiz_page.dart
              /* Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                    QuizBox),*/
            ),
          );
             }
           ))
          ]
        )
      ]
    )
  ];
}
*/

// Ignore this code

/*class PassageTypeTile extends StatelessWidget {
  var list = new List.generate(10, (i)=> "Item ${i+1}");
  @override
  Widget build(BuildContext context) {
    return new ListView.builder(itemBuilder: (context, i)=> ExpansionTile(
      title: new Text("Header ${i+1}"),
      children: list.map((val) => new ListTile(
        title: new Text(val)
        ))
        .toList(),
      ),
      itemCount: 5,);
  }
}*/

// This code should work, but I can't figure out why I keep getting errors
/*
class PassageTypeTile extends StatelessWidget{
  const PassageTypeTile(this.infoBox);

  final PassageType infoBox;

  Widget _buildTiles(PassageType root) {
    return ExpansionTile(
      key: PageStorageKey<PassageType>(root),
      title: Text(root.title),
      children: root.children.map<Widget>(_buildTiles.toList()),
    );
  }

  @override
  Widget build(BuildContext context) {
    reutrn _buildTiles(infoBox);
  }
}
*/

