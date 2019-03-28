import '../settings/person.dart';

class IntroItem {
  IntroItem({
    this.title,
    this.category,
    this.stat,
  });

  final String title;
  final String category;
  final String stat;
}

Person _person = new Person();
final sampleItems = <IntroItem>[
  new IntroItem(title: "Stop “Cold Turkey” \n The term “cold turkey” is most often used to refer to quitting abruptly or suddenly (rather than gradually cutting down to no cigarettes).", category: "Untill you are Tobacco Free", stat: _person.smokeChart.desiredDaysUntilComplete.toString() + " days"),
  new IntroItem(title: 'Occasionally wearing pants is a good idea.', category: 'CULTURE', stat: '0',),
  new IntroItem(title: 'We might have the best team spirit ever.', category: 'SPIRIT', stat: '0',),
];