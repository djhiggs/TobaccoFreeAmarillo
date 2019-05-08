import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
//import 'intro_item.dart';
import 'page_transformer.dart';

class CessationItem extends StatelessWidget {
  CessationItem({

    @required this.pageVisibility,
  });

  final PageVisibility pageVisibility;

  Widget _applyTextEffects({
    @required double translationFactor,
    @required Widget child,
  }) {
    //final double xTranslation = pageVisibility.pagePosition * translationFactor;

    return Opacity(
      opacity: pageVisibility.visibleFraction,
      child: Transform(
        alignment: FractionalOffset.bottomCenter,
        transform: Matrix4.translationValues(
          0.0,
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
        "category",
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
          "title",
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
          Text(
            "Stat",
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
    /*
    var imageOverlayGradient = DecoratedBox(
      decoration: BoxDecoration(
        //image: Image.asset(name),
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
    */
    
    return Padding(
      //padding: const EdgeInsets.symmetric(
      //  vertical: 100.0,
      //  horizontal: 8.0,
      //),
      padding: EdgeInsets.fromLTRB(8.0, 180.0, 8.0, 10.0),
      child: Material(
        elevation: 4.0,
        borderRadius: BorderRadius.circular(8.0),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Opacity(
              opacity: 0.1,
              child: Icon(Icons.smoke_free, size: 200.0,color: Theme.of(context).primaryColor,),
            ),
            _buildTextContainer(context),
          ]
        ),
      ),
    );
  }
}
