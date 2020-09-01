import 'package:art/screens/RandomTab/RandomPosterHome.dart';
import 'package:art/screens/AllPostersTab/AllPostersHome.dart';
import 'package:art/screens/InstructionTab/InstructionHome.dart';
import 'package:art/functions/userAPI.dart';
import 'package:art/screens/UserScreen/LoginHome.dart';
import 'package:art/configs/Palette.dart';
// import 'package:firebase_admob/firebase_admob.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // FirebaseAdMob.instance.initialize(appId: getAppId());
    return CupertinoApp(
      localizationsDelegates: <LocalizationsDelegate<dynamic>>[
        DefaultMaterialLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
      ],
      theme: CupertinoThemeData(
          primaryColor: mainThemeColor,
          brightness: Brightness.dark,
          barBackgroundColor: CupertinoColors.black,
          scaffoldBackgroundColor: CupertinoColors.black),
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FirebaseUser>(
        future: getCurrentUser(),
        builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return CircularProgressIndicator();
            default:
              if (snapshot.hasError)
                return Text("No internet connection");
              else if (snapshot.data == null)
                return LoginHome(notifyParent: refresh);
              else
                return HomeHome();
          }
        });
  }
}

class HomeHome extends StatefulWidget {
  @override
  _HomeHomeState createState() => _HomeHomeState();
}

class _HomeHomeState extends State<HomeHome> {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          currentIndex: 1,
          items: [
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.shuffle_thick),
              title: Text('Random'),
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.search),
              title: Text('instruction'),
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.collections_solid),
              title: Text('All'),
            ),
          ],
        ),
        tabBuilder: (context, i) {
          return CupertinoTabView(builder: (context) {
            return CupertinoPageScaffold(
              child: (i == 0)
                  ? RandomPosterHome()
                  : ((i == 1) ? (InstructionHome()) : ((AllPostersHome()))),
            );
          });
        });
  }
}
