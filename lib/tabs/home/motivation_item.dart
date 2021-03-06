import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
//import 'intro_item.dart';
import 'page_transformer.dart';

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

  _buildTextContainer(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var categoryText = _applyTextEffects(
      translationFactor: 300.0,
      child: Text(
        //item.category,
        "Get help if you want it",
        style: textTheme.caption.copyWith(
          color: Colors.black,
          letterSpacing: 2.0,
          fontSize: 20.0,
        ),
        textAlign: TextAlign.center,
      ),
    );

    var titleText = _applyTextEffects(
      translationFactor: 200.0,
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Text(
          //item.title,
          "Smokers can receive free resources and assistance to help them quit. Your health care providers are also a good source for help and support.",
          style: textTheme.title.copyWith(color: Colors.black),
          textAlign: TextAlign.center,
        ),
      ),
    );

    return Positioned(
      bottom: MediaQuery.of(context).size.height * 0.05,
      left: MediaQuery.of(context).size.height * 0.01,
      right: MediaQuery.of(context).size.height * 0.01,
      //top: MediaQuery.of(context).size.height * 0.50,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
              //item.stat,
              "1-800-QUIT-NOW",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          categoryText,
          Container(
            width: 180.0,
          ),
          titleText,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var imageOverlayGradient = DecoratedBox(
      decoration: BoxDecoration(
        ),
      child: Container(
        child:  Image.asset(
          'assets/images/clock.jpg',
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
