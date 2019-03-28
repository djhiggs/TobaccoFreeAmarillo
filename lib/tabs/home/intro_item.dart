import '../settings/person.dart';

class IntroItem {
  IntroItem({
    this.title,
    this.category,
    this.imageUrl,
  });

  final String title;
  final String category;
  final String imageUrl;
}

Person _person = new Person();
final sampleItems = <IntroItem>[
  new IntroItem(title: "\$"+(_person.smokeChart.averageUsage*5.06*(
            (DateTime.now().millisecondsSinceEpoch - _person.smokeChart.startDate.millisecondsSinceEpoch)/(3600*1000*24*7))).toString(), category: 'USAGE', imageUrl: 'assets/test.png',),
  new IntroItem(title: 'Occasionally wearing pants is a good idea.', category: 'CULTURE', imageUrl: 'assets/test.png',),
  new IntroItem(title: 'We might have the best team spirit ever.', category: 'SPIRIT', imageUrl: 'assets/test.png',),
];