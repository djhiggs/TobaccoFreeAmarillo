import 'package:flutter/material.dart';
import 'page_transformer.dart';
import 'profile_item.dart';
import 'motivation_item.dart';
import 'link_item.dart';
import 'milestone_item.dart';
import 'cdc_link_item.dart';
import 'hcf_link_item.dart';

class IntroPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    
    return Scaffold(
      body: Center(
        //heightFactor: MediaQuery.of(context).size.height * .9,
        child: SizedBox.fromSize(
          size: const Size.fromHeight(700.0),
          child: PageTransformer(
            pageViewBuilder: (context, visibilityResolver) {
              final items = <Widget>[
                  ProfileItem(
                    pageVisibility: visibilityResolver.resolvePageVisibility(0),
                  ),
                  MilestoneItem(
                    pageVisibility: visibilityResolver.resolvePageVisibility(1),
                  ),
                  MotivationItem(
                    pageVisibility: visibilityResolver.resolvePageVisibility(2),
                  ),
                  LinkItem(
                    pageVisibility: visibilityResolver.resolvePageVisibility(3),
                  ),
                  HCFLinkItem(
                    pageVisibility: visibilityResolver.resolvePageVisibility(4),
                  ),
                  CDCLinkItem(
                    pageVisibility: visibilityResolver.resolvePageVisibility(5),
                  ),
                  ];
              return PageView.builder(
                
                controller: PageController(viewportFraction: 0.85),
                itemCount: 6,
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