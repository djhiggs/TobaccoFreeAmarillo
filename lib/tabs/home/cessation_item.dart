import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
//import 'intro_item.dart';
import 'page_transformer.dart';
import '../settings/person.dart';

class CessationItem extends StatelessWidget {
  CessationItem({
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
                            _person
                                .startDate.millisecondsSinceEpoch) /
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
              Row(
                children: [
                  Text("Money Saved:",
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center),
                  Container(
                    padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.height * 0.085, 0, 0, 0),
                    child: Text(
                      moneySaved,
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.15,
                width: MediaQuery.of(context).size.width * 0.40,
                child: new Divider(
                  color: Colors.black,
                ),
              ),
              Row(
                children: [
                  Column(
                    children: <Widget>[
                      Text("Ciggerates",
                      softWrap: true,
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center),
                      Text("Evaded:",
                      softWrap: true,
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.height * 0.14, 0, 0, 0),
                    child: Text(
                      moneySaved,
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
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