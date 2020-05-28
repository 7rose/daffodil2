import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class HomeViewModel extends ChangeNotifier {
  
}

class KingKongItem {
  String href;
  String picUrl;
  String title;
  KingKongItem({this.href, this.picUrl,this.title});
  KingKongItem.fromJson(Map<String, dynamic> json)
      : href = json['href'],
        title=json['title'],
        picUrl = json['pic_url'];
}

class KingKongList {
  List<KingKongItem> items;
  KingKongList({this.items});
  factory KingKongList.fromJson( dynamic json) {
    List list = (json as List).map((i) {
      return KingKongItem.fromJson(i);
    }).toList();
    return KingKongList(items: list);
  }
}

class ProductItemModel {
  String jumpurl;
  String bgColor;
  String picurl;
  String title;
  String titleColor;
  String subtitle;
  String subtitleColor;
  ProductItemModel(
      {this.jumpurl,
        this.bgColor,
        this.picurl,
        this.title,
        this.titleColor,
        this.subtitle,
        this.subtitleColor});
  factory ProductItemModel.fromJson(Map<String, dynamic> json) {
    return ProductItemModel(
        bgColor: json['bg_color'],
        jumpurl: json['jump_url'],
        picurl: json['pic_url'],
        subtitle: json['subtitle'],
        titleColor: json['title_color'],
        subtitleColor: json['subtitle_color'],
        title: json['title']);
  }
}

class ProductListModel {
  List<ProductItemModel> items;
  String title;

  ProductListModel({this.items, this.title});
  factory ProductListModel.fromJson(Map<String, dynamic> json) {
    var itemsList = json['items'] as List;
    var menueItems = itemsList.map((i) {
      return ProductItemModel.fromJson(i);
    }).toList();

    return ProductListModel(items: menueItems, title: json['title']);
  }
}