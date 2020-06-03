import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GoodsDetail extends StatelessWidget {
  static const String routeName = "/detail";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("购物车"),
        ));
  }
}
