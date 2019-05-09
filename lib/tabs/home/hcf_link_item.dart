import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'page_transformer.dart';
import 'package:url_launcher/url_launcher.dart';

class HCFLinkItem extends StatelessWidget {
  HCFLinkItem({
    @required this.pageVisibility,
  });

  final PageVisibility pageVisibility;

  Widget _applyTextEffects({
    @required double translationFactor,
    @required Widget child,
  }) {

    return Opacity(
      opacity: pageVisibility.visibleFraction,
      child: child,
    );
  }

  _buildTextContainer(BuildContext context) {
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
                  Text("Harrington Cancer Foundation",
                      softWrap: true,
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center),
                ],
              ),
              Container(
                padding: EdgeInsets.fromLTRB(
                    0, 0, 0, MediaQuery.of(context).size.height * 0.1),
                child: new Divider(
                  color: Colors.black,
                ),
              ),
              Container(
                child: RaisedButton(
                  color: Colors.black,
                  textColor: Colors.white,
                  onPressed: _launchURL,
                  child: Text('Visit Site!'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _launchURL() async {
    const url = 'http://www.hcfamarillo.org/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    var imageOverlayGradient = DecoratedBox(
      decoration: BoxDecoration(),
      child: Container(
        child: Image.asset(
          'assets/images/hcf.jpg',
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