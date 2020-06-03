import 'package:flutter/material.dart';
import '../home/index.dart';
import '../user/index.dart';

final List<Widget> pages = [
  HomePage(),
  UserCenterPage(),
  UserCenterPage()
];

final List<BottomNavigationBarItem> items = [
  BottomNavigationBarItem(
    title: Text("首页"),
    icon: Icon(Icons.home)
  ),
  BottomNavigationBarItem(
      title: Text("发现"),
      icon: Icon(Icons.dehaze)
  ),
  BottomNavigationBarItem(
      title: Text("关注"),
      icon: Icon(Icons.account_circle)
  ),
];