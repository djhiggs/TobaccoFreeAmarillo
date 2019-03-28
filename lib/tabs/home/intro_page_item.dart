import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'intro_item.dart';
import 'page_transformer.dart';

class IntroPageItem extends StatelessWidget {
  IntroPageItem({
    @required this.item,
    @required this.pageVisibility,
  });

  final IntroItem item;
  final PageVisibility pageVisibility;

  Widget _applyTextEffects({
    @required double translationFactor,
    @required Widget child,
  }) {
    final double xTranslation = pageVisibility.pagePosition * translationFactor;

    return Opacity(
      opacity: pageVisibility.visibleFraction,
      child: Transform(
        alignment: FractionalOffset.bottomCenter,
        transform: Matrix4.translationValues(
          xTranslation,
          0.0,
          0.0,
        ),
        child: child,
      ),
    );
  }

  _buildTextContainer(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var categoryText = _applyTextEffects(
      translationFactor: 300.0,
      child: Text(
        item.category,
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
          item.title,
          style: textTheme.title.copyWith(color: Colors.black),
          textAlign: TextAlign.left,
        ),
      ),
    );

    return Positioned(
      bottom: 50,
      left: 32.0,
      right: 32.0,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(item.stat,
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
          categoryText,
          Container(
            width: 180.0,
            child: new Divider(
              color: Colors.black,
              height: 50,
              ),
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
        gradient: LinearGradient(
          begin: FractionalOffset.bottomCenter,
          end: FractionalOffset.topCenter,
          colors: [
            const Color(0xFF000000),
            const Color(0x00000000),
          ],
        ),
      ),
    );

    return Padding(
      //padding: const EdgeInsets.symmetric(
      //  vertical: 100.0,
      //  horizontal: 8.0,
      //),
      padding: EdgeInsets.fromLTRB(8.0, 140.0, 8.0, 10.0),
      child: Material(
        elevation: 4.0,
        borderRadius: BorderRadius.circular(8.0),
        child: Stack(
          fit: StackFit.expand,
          children: [
            _buildTextContainer(context),
          ],
        ),
      ),
    );
  }
}
