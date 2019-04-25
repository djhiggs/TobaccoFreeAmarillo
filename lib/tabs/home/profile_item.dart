import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
//import 'intro_item.dart';
import 'page_transformer.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ProfileItem extends StatelessWidget {
  ProfileItem({
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

  _buildTextContainer(BuildContext context) {
    //var textTheme = Theme.of(context).textTheme;
    // var categoryText = _applyTextEffects(
    //   translationFactor: 300.0,
    //   child: Text(
    //     //item.category,
    //     "test",
    //     style: textTheme.caption.copyWith(
    //       color: Colors.black,
    //       letterSpacing: 2.0,
    //       fontSize: 20.0,
    //     ),
    //     textAlign: TextAlign.center,
    //   ),
    // );

    var daysUntilFreeIndicator = new CircularPercentIndicator(
      //radius: 175.0,
      radius:  MediaQuery.of(context).size.width * 0.45,
      lineWidth: 25.0,
      animation: true,
      percent: 0.7,
      // center: Text(
      //   "0 Days",
      //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
      // ),
      center: Icon(
        Icons.smoke_free,
        size: 50.0,
        ),
      header:  Text(
        "Nickname",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
      ),
      footer:  Text(
        "__ Days Until You Quit!",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
      ),
      circularStrokeCap: CircularStrokeCap.round,
      progressColor: Colors.deepPurpleAccent,
    );

    return Positioned(
      bottom: 25,
      left: 32.0,
      right: 32.0,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            //width: 180.0,
            child: daysUntilFreeIndicator,
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
          'assets/images/endurance.jpg',
          fit: BoxFit.fitHeight,
        ),
      ),
    );

    return Padding(
      padding: EdgeInsets.fromLTRB(8.0, 180.0, 8.0, 10.0),
      child: Material(
        elevation: 4.0,
        shape: null,
        borderRadius: BorderRadius.circular(8.0),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Opacity(
              opacity: 0.25,
              child: imageOverlayGradient,
            ),
            _buildTextContainer(context),
          ],
        ),
      ),
    );
  }
}
