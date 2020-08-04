import 'package:daffodil/localization/app_localizations.dart';
import 'package:flutter/material.dart';
import '../home/index.dart';
import '../user/index.dart';
import '../Discovery/index.dart';

final List<Widget> pages = [
  HomePage(),
  DiscoveryPage(),
  UserCenterPage()
];


List<BottomNavigationBarItem> getBarItems(context) {

  final List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(
        title: Text(AppLocalizations.of(context).bottomBarHome,
//          style: TextStyle(color: Colors.blue),
        ),
        icon: Icon(Icons.home),
//        activeIcon: Icon(Icons.home,color: Colors.blue,)

    ),
    BottomNavigationBarItem(
        title: Text(AppLocalizations.of(context).bottomBarDiscover),
        icon: Icon(Icons.dehaze)
    ),
    BottomNavigationBarItem(
        title: Text(AppLocalizations.of(context).bottomBarUserCenter),
        icon: Icon(Icons.account_circle)
    ),
  ];

  return items;
}

//final List<BottomNavigationBarItem> items = [
//  BottomNavigationBarItem(
//    title: Text("首页"),
//    icon: Icon(Icons.home)
//  ),
//  BottomNavigationBarItem(
//      title: Text("发现"),
//      icon: Icon(Icons.dehaze)
//  ),
//  BottomNavigationBarItem(
//      title: Text("关注"),
//      icon: Icon(Icons.account_circle)
//  ),
//];