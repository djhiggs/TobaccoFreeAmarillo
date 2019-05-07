import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
//import 'intro_item.dart';
import 'page_transformer.dart';
import '../settings/person.dart';

class MilestoneItem extends StatelessWidget {
  MilestoneItem({
    @required this.pageVisibility,
  });

  final PageVisibility pageVisibility;

  Widget _applyTextEffects({
    @required double translationFactor,
    @required Widget child,
  }) {
    final double xTranslation = pageVisibility.pagePosition * translationFactor;

    return Opacity(
      opacity: pageVisibility.visibleFraction,
      child: child,
    );
  }

  _buildTextContainer(BuildContext context) {
    Person _person = new Person();
    var moneySaved = "\$" +
        (_person.averageUsage *
                5.06 *
                (((DateTime.now().millisecondsSinceEpoch -
                            _person.startDate.millisecondsSinceEpoch) /
                        (3600 * 1000 * 24 * 7))
                    .round()))
            .toString();

    return Positioned(
      bottom: MediaQuery.of(context).size.height * 0.08,
      left: 32.0,
      right: 32.0,
      child: Stack(
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text("Money Saved",
                      softWrap: true,
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center),
                ],
              ),
              Container(
                //height: MediaQuery.of(context).size.height * 0.15,
                //width: MediaQuery.of(context).size.width * 0.40,
                padding: EdgeInsets.fromLTRB(
                  0,
                  0,
                  0,
                  MediaQuery.of(context).size.height * 0.1
                  ),
                child: new Divider(
                  color: Colors.black,
                ),
              ),
              Container(
                child: Text(
                  moneySaved,
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var imageOverlayGradient = DecoratedBox(
      decoration: BoxDecoration(),
      child: Container(
        child: Image.asset(
          'assets/images/bank_notes.jpg',
          fit: BoxFit.fitHeight,
        ),
      ),
    );

    return Padding(
      padding: EdgeInsets.fromLTRB(8.0, 180.0, 8.0, 10.0),
      child: Material(
        elevation: 4.0,
        borderRadius: BorderRadius.circular(8.0),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Opacity(
              opacity: 0.2,
              child: imageOverlayGradient,
            ),
            _buildTextContainer(context),
          ],
        ),
      ),
    );
  }
}
