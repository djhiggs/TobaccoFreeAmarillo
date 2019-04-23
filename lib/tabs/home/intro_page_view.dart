import 'package:flutter/material.dart';
import 'intro_item.dart';
import 'intro_page_item.dart';
import 'page_transformer.dart';
import 'profile_item.dart';

class IntroPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    
    return Scaffold(
      body: Center(
        child: SizedBox.fromSize(
          size: const Size.fromHeight(500.0),
          child: PageTransformer(
            pageViewBuilder: (context, visibilityResolver) {
              return PageView.builder(
                controller: PageController(viewportFraction: 0.85),
                //items: = <Widget>[
                //]
                itemCount: 5,
                itemBuilder: (context, index) {
                  //final item = sampleItems[index];
                  final pageVisibility =
                      visibilityResolver.resolvePageVisibility(index);
                  return ProfileItem(
                    pageVisibility: pageVisibility,
                  );
                  
                },
              );
            },
          ),
        ),
      ),
    );
  }
}