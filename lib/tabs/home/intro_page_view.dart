import 'package:flutter/material.dart';
import 'page_transformer.dart';
import 'profile_item.dart';
import 'motivation_item.dart';
import 'cessation_item.dart';
import 'game_item.dart';
import 'milestone_item.dart';

class IntroPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    
    return Scaffold(
      body: Center(
        child: SizedBox.fromSize(
          size: const Size.fromHeight(500.0),
          child: PageTransformer(
            pageViewBuilder: (context, visibilityResolver) {
              final items = <Widget>[
                  ProfileItem(
                    pageVisibility: visibilityResolver.resolvePageVisibility(0),
                  ),
                  CessationItem(
                    pageVisibility: visibilityResolver.resolvePageVisibility(1),
                  ),
                  MotivationItem(
                    pageVisibility: visibilityResolver.resolvePageVisibility(2),
                  ),
                  GameItem(
                    pageVisibility: visibilityResolver.resolvePageVisibility(3),
                  ),
                  MilestoneItem(
                    pageVisibility: visibilityResolver.resolvePageVisibility(4),
                  ),
                  ];
              return PageView.builder(
                
                controller: PageController(viewportFraction: 0.85),
                itemCount: 5,
                itemBuilder: (context, index) {
                  return items[index];
                },
              );
            },
          ),
        ),
      ),
    );
  }
}