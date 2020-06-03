import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class GoodsDetail extends StatelessWidget {
  static const String routeName = "/detail";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("购物车"),
        ),
      body:  Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Image.network(
            "http://via.placeholder.com/288x188",
            fit: BoxFit.fill,
          );
        },
        itemCount: 1,
        viewportFraction: 0.8,
        scale: 0.9,
      ),
    );
  }
}
