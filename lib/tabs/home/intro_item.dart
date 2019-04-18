import '../settings/person.dart';
//import 'home.dart';

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


//Person _person;
Person _person = new Person();
final sampleItems = <IntroItem>[
  //new IntroItem(title: "The stuff", category: _person.nickname, stat: ""),
  new IntroItem(title: "Stop “Cold Turkey”. The term “cold turkey” is most often used to refer to quitting abruptly or suddenly (rather than gradually cutting down to no cigarettes).", category: "Untill you are Tobacco Free", stat: _person.smokeChart.desiredDaysUntilComplete.toString() + " days"),
  new IntroItem(title: " Smokers can receive free resources and assistance to help them quit. Your health care providers are also a good source for help and support.", category: "Get help if you want it", stat: "1-800-QUIT-NOW"),
  new IntroItem(title: " Nearly all smokers have some feelings of nicotine withdrawal when they try to quit. Nicotine is addictive. Knowing this will help you deal with withdrawal symptoms.", category: "Dollars Saved", stat: "\$"+(_person.smokeChart.averageUsage*5.06*(
            ((DateTime.now().millisecondsSinceEpoch - _person.smokeChart.startDate.millisecondsSinceEpoch)/(3600*1000*24*7)).round())).toString())];