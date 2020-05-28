import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserCenterPage extends StatelessWidget {
  static const String routeName = "/userCenter";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("用户中心"),
        ),
      body: Text('11'),
    );
  }
}
