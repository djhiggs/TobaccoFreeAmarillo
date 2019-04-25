import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
//import 'intro_item.dart';
import 'page_transformer.dart';
import '../settings/person.dart';

class MotivationItem extends StatelessWidget {
  MotivationItem({
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
      // child: Transform(
      //   alignment: FractionalOffset.bottomCenter,
      //   // transform: Matrix4.translationValues(
      //   //   0.0,
      //   //   0.0,
      //   //   0.0,
      //   // ),
      //   child: child,
      // ),
    );
  }

  _buildText(
      BuildContext context, var moneySaved, var textTheme, var description) {
    return _applyTextEffects(
      translationFactor: 200.0,
      child: Column(children: <Widget>[
        Container(
          child: Text(
            moneySaved,
            style: textTheme.title.copyWith(color: Colors.black),
            //TextStyle(fontSize: 15),
            textAlign: TextAlign.center,
          ),
        ),
        Text(description,
            style: textTheme.title.copyWith(color: Colors.black),
            textAlign: TextAlign.center),
      ]),
    );
  }

  _buildTextContainer(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    Person _person = new Person();
    var moneySaved = "\$" +
        (_person.smokeChart.averageUsage *
                5.06 *
                (((DateTime.now().millisecondsSinceEpoch -
                            _person
                                .smokeChart.startDate.millisecondsSinceEpoch) /
                        (3600 * 1000 * 24 * 7))
                    .round()))
            .toString();

    return Positioned(
      bottom: 50,
      left: 32.0,
      right: 32.0,
      child: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.30,
            width: MediaQuery.of(context).size.width * 0.15,
            child: new VerticalDivider(
              color: Colors.black,
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildText(context, moneySaved, textTheme, "Money Saved:"),
              _buildText(context, moneySaved, textTheme, "Money Saved:"),
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
