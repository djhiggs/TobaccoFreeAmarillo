import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tobaccoFreeAmarilloApp/landing_screen.dart';
import 'tabs/achievement_page/achievement.dart';
import 'tabs/home/home.dart' as _firstTab;
import 'tabs/gameGarage/gameGarage.dart' as _secondTab;
import 'tabs/settings/settings.dart' as _thirdTab;
import 'tabs/achievement_page/achievement_page.dart' as _achievementPage;
import 'tabs/usefulInfo/categoriesWidget.dart';


void main(){ 

  runApp(new MaterialApp(
    title: 'Flutter Starter',
    theme: new ThemeData(
      primarySwatch: Colors.blueGrey,
      scaffoldBackgroundColor: Colors.white,
      primaryColor: Colors.blueGrey, backgroundColor: Colors.white
    ),
    home: new Tabs(),
    // routes: <String, WidgetBuilder> {
    //   '/about': (BuildContext context) => new _aboutPage.About(),
    // }
  ));
}

class FromRightToLeft<T> extends MaterialPageRoute<T> {
  FromRightToLeft({ WidgetBuilder builder, RouteSettings settings })
    : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child) {

    if (settings.isInitialRoute)
      return child;

    return new SlideTransition(
      child: new Container(
        decoration: new BoxDecoration(
          boxShadow: [
            new BoxShadow(
              color: Colors.black26,
              blurRadius: 25.0,
            )
          ]
        ),
        child: child,
      ),
      position: new Tween<Offset>(
        begin: const Offset(1.0, 0.0),
        end: Offset.zero,
      )
      .animate(
        new CurvedAnimation(
          parent: animation,
          curve: Curves.fastOutSlowIn,
        )
      ),
    );
  }
  @override Duration get transitionDuration => const Duration(milliseconds: 50);
}
class Tabs extends StatefulWidget {
  @override
  TabsState createState() => new TabsState();
}


class TabsState extends State<Tabs> {
  List<Achievement> achievements = List<Achievement>();
  PageController _tabController;
TabsState(){

}
  var _title_app = null;
  int _tab = 0;


checkIfFirstLaunch() {
    SharedPreferences.getInstance().then((pref) async {
      final isFirstLaunch = pref.getBool("IS_FIRST_LAUNCH") ?? true;
      if (isFirstLaunch) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => LandingScreen()));
        pref.setBool("IS_FIRST_LAUNCH", false);
      }      
    });
  }
  
  @override
  void initState() {
    super.initState();
    checkIfFirstLaunch();
    _tabController = new PageController();
    this._title_app = TabItems[0].title;
  }

  @override
  void dispose(){
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build (BuildContext context) => new Scaffold(

    //App Bar
    appBar: new AppBar(
      title: new Text(
        _title_app, 
        style: new TextStyle(
          fontSize: Theme.of(context).platform == TargetPlatform.iOS ? 17.0 : 20.0,
        ),
      ),
      elevation: Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
    ),

    //Content of tabs
    body: new PageView(
      controller: _tabController,
      onPageChanged: onTabChanged,
      children: <Widget>[
        new _firstTab.Home(),
        new _secondTab.GameGarage(context),
        new CategoriesWidget(),
        new _achievementPage.AchievementPage(),
        new _thirdTab.StatefulSettings(),
        
      ],
    ),

    //Tabs
    bottomNavigationBar: Theme.of(context).platform == TargetPlatform.iOS ?
      new CupertinoTabBar(
        activeColor: Colors.blueGrey,
        currentIndex: _tab,
        onTap: onTap,
        items: TabItems.map((TabItem) {
          return new BottomNavigationBarItem(
            title: new Text(TabItem.title),
            icon: new Icon(TabItem.icon),
          );
        }).toList(),
      ):
      new BottomNavigationBar(
        type:BottomNavigationBarType.fixed,
        currentIndex: _tab,
        onTap: onTap,
        items: TabItems.map((TabItem) {
          return new BottomNavigationBarItem(
            title: new Text(TabItem.title),
            icon: new Icon(TabItem.icon),
          );
        }).toList(),
    ),

   /* //Drawer
   drawer: new Drawer(
      child: new ListView(
        children: <Widget>[
          new Container(
            height: 120.0,
            child: new DrawerHeader(
              padding: new EdgeInsets.all(0.0),
              decoration: new BoxDecoration(
                color: new Color(0xFFECEFF1),
              ),
              child: new Center(
                child: new FlutterLogo(
                  colors: Colors.blueGrey,
                  size: 54.0,
                ),
              ),
            ),
          ),
          new ListTile(
            leading: new Icon(Icons.chat),
            title: new Text('Support'),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushNamed('/support');
            }
          ),
          new ListTile(
            leading: new Icon(Icons.account_circle),
            title: new Text('Profile'),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushNamed('/profile');
            }
          ),
          new Divider(),
          new ListTile(
            leading: new Icon(Icons.exit_to_app),
            title: new Text('Sign Out'),
            onTap: () {
              Navigator.pop(context);
            }
          ),
        ],
      )
   )*/
  );

  void onTap(int tab){
    _tabController.jumpToPage(tab);
  }

  void onTabChanged(int tab) {
    setState((){
      this._tab = tab;
    });

    switch (tab) {
      case 0:
        this._title_app = TabItems[0].title;
      break;

      case 1:
        this._title_app = TabItems[1].title;
      break;

      case 2:
        this._title_app = TabItems[2].title;
      break;
      
      case 3:
        this._title_app =TabItems[3].title;
      break;

    }
  }
}

class TabItem {
  const TabItem({ this.title, this.icon });
  final String title;
  final IconData icon;
}

const List<TabItem> TabItems = const <TabItem>[
  const TabItem(title: 'Home', icon: Icons.home),
  const TabItem(title: 'Games', icon: Icons.gamepad),
  const TabItem(title: 'Useful Info', icon: Icons.book),
  const TabItem(title: 'Trophies', icon: Icons.star),
  const TabItem(title: 'Settings', icon: Icons.settings),
];