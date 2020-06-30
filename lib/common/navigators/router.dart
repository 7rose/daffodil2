import 'package:daffodil/pages/Discovery/index.dart';
import 'package:daffodil/pages/main/main.dart';
import 'package:daffodil/pages/goodsDetail/goodsDetail.dart';
import 'package:daffodil/pages/category/category.dart';

import 'package:flutter/material.dart';
import 'package:daffodil/pages/user/index.dart';
import 'package:daffodil/pages/user/login/login.dart';
import 'package:daffodil/pages/user/login/JVerifyLogin.dart';

class LLRouter {
  static final String initialRoute = MainScreen.routeName;

  static final Map<String, WidgetBuilder> routes = {
    MainScreen.routeName: (ctx) => MainScreen(),
    GoodsDetail.routeName: (ctx) => GoodsDetail(),
    Category.routeName: (ctx) => Category(),
    UserCenterPage.routeName: (ctx) => UserCenterPage(),
    LoginPage.routeName: (ctx) => LoginPage(),
    JVerify.routeName: (ctx) => JVerify(),
    DiscoveryPage.routeName:(ctx) => DiscoveryPage()
  };



  // 自己扩展
  static final RouteFactory generateRoute = (settings) {
    return null;
  };

  static final RouteFactory unknownRoute = (settings) {
    return null;
  };
}