import 'package:flutter/material.dart';
import 'package:daffodil/pages/goodsDetail/goodsDetail.dart';
import 'package:daffodil/pages/user/login/login.dart';
import 'package:daffodil/pages/user/login/JVerifyLogin.dart';

import './initialize_items.dart';
import '../../common/navigators/router.dart';
import 'package:daffodil/common/global/global.dart';
import 'draw.dart';

class MainScreen extends StatefulWidget {
  static const String routeName = "/";
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children:pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedFontSize: 14,
        unselectedFontSize: 14,
        items: items,
        onTap: (index) {
          if(index == 2){
//            Navigator.of(context).pushNamed(
//                LoginPage.routeName,
//                arguments:{});
          Navigator.of(context).pushNamed(
            LoginPage.routeName,
          );
            return;
          }
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      drawer: HomeDrawer(),
      floatingActionButton: FloatingActionButton(
        backgroundColor:Colors.black26,
        onPressed: () {
          Navigator.of(context).pushNamed(GoodsDetail.routeName);
        },
        child: Icon(Icons.shopping_cart),
      ),
    );
  }
}
