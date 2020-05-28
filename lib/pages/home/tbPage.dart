import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:daffodil/model/homeStore.dart';
import 'package:daffodil/model/home.dart';

class TbHome extends StatefulWidget {
  @override
  TbHomeState createState() => TbHomeState();

  static Color string2Color(String colorString) {
    int value = 0x00000000;

    if (colorString != null) {
      if (colorString[0] == '#') {
        colorString = colorString.substring(1);
      }
      value = int.tryParse(colorString, radix: 16);
      if (value != null) {
        if (value < 0xFF000000) {
          value += 0xFF000000;
        }
      }
    }
    return Color(value);
  }
}


class TbHomeState extends State<TbHome> with AutomaticKeepAliveClientMixin{

  List<KingKongItem> kingKongItems =
      KingKongList.fromJson(menueDataJson['items']).items;

  List<KingKongItem> _page1 =
      KingKongList.fromJson(menueDataJson['items']).items.take(10).toList();

  List<KingKongItem> page2 =
      KingKongList.fromJson(menueDataJson['items']).items.skip(10).toList();

  ProductListModel data = ProductListModel.fromJson(recommendJson);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Banner(images: banner_images),
          FastEntry(page1: _page1, page2: page2, kingKongItems: kingKongItems),
          Container(
            margin: EdgeInsets.all(8),
            width: double.infinity,
            child: Card(
                child: Column(children: <Widget>[
                  SizedBox(height: 10),
                  Text(
                    data.title,
                    style: TextStyle(fontSize: 22),
                  ),
                  Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      alignment: WrapAlignment.spaceBetween,
                      children: data.items.map((ProductItemModel e) {
                        return Container(
                          color: TbHome.string2Color(e.bgColor),
                          child: Column(
                            children: <Widget>[
                              Text(e.title,
                                  style: TextStyle(
                                      color: TbHome.string2Color(e.subtitleColor))),
                              Image.network(
                                e.picurl,
                                width: 86,
                              ),
                              SizedBox(height: 20),
                            ],
                          ),
                        );
                      }).toList()),
                ])),
          )
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class FastEntry extends StatelessWidget {
  const FastEntry({
    Key key,
    @required List<KingKongItem> page1,
    @required this.page2,
    @required this.kingKongItems,
  })  : _page1 = page1,
        super(key: key);

  final List<KingKongItem> _page1;
  final List<KingKongItem> page2;
  final List<KingKongItem> kingKongItems;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      decoration: BoxDecoration(
        color: Colors.grey[50],
//          borderRadius:BorderRadius.only(topLeft: Radius(1),);
      ),
      alignment: Alignment.center,
      child: Swiper(
        autoplay: true,
        itemBuilder: (BuildContext context, int index) {
          List<KingKongItem> pageData = index == 0 ? _page1 : page2;
          return Wrap(
            alignment: WrapAlignment.spaceEvenly,
            children: pageData.map((KingKongItem e) {
              return Container(
                padding: EdgeInsets.all(8),
                child: Column(children: <Widget>[
                  Container(
                    color: Colors.grey[100],
                    child: Image.network(
                      e.picUrl,
                      key: UniqueKey(),
                      width: 60,
                      height: 60,
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(e.title),
                ]),
              );
            }).toList(),
          );
        },
        itemCount: kingKongItems.length ~/ 10 +
            (kingKongItems.length % 10 > 0 ? 1 : 0),
//        viewportFraction: 0.8,
//        scale: 0.9,
        pagination: SwiperPagination(
            builder: RectSwiperPaginationBuilder(
                space: 0,
                activeColor: Colors.red,
                size: Size(50, 3),
                activeSize: Size(50, 3),
                color: Colors.grey),
            alignment: Alignment.bottomCenter),
      ),
    );
  }
}

class Banner extends StatelessWidget {
  const Banner({
    Key key,
    @required this.images,
  }) : super(key: key);

  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 200,
          child: Swiper(
            autoplay: true,
            itemBuilder: (BuildContext context, int index) {
              return Image.network(
                images[index],
                fit: BoxFit.fill,
              );
            },
            itemCount: images.length,
//        viewportFraction: 0.8,
//        scale: 0.9,
            pagination: new SwiperPagination(alignment: Alignment.bottomCenter),
          ),
        ),
      ],
    );
  }
}
