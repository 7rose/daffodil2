import 'package:flutter/material.dart';
import 'package:daffodil/pages/category/right_list_view.dart';
import 'package:daffodil/pages/category/menue.dart';
import 'package:daffodil/pages/category/search_bar.dart';

import 'package:daffodil/model/category.dart';
import 'package:daffodil/model/sub_category.dart';
import 'package:daffodil/common/utils/screen_util.dart';

final double h = ScreenUtil.screenHeight - ScreenUtil.statusBarHeight;

class Category extends StatefulWidget {
  static const String routeName = "Category";
  final double rightListViewHeight = h;

  Category({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => CategoryState();
}

class CategoryState extends State<Category> {
  int currentPage = 0;
  GlobalKey<RightListViewState> rightListviewKey =
      new GlobalKey<RightListViewState>();
  GlobalKey<CategoryMenueState> categoryMenueKey =
      new GlobalKey<CategoryMenueState>();
  List<SubCategoryListModel> listViewData = [];
  bool isAnimating = false;
  int itemCount = 0;
  double menueWidth;
  double itemHeight;
  double height;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Color(0xFFFFFFFF),
          child: Column(
            children: <Widget>[
              SearchBar(),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SingleChildScrollView(
                      child: Container(
                        margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                        color: Color(0xFFf7f7f7),
                        width: ScreenUtil().L(75),
                        child: CategoryMenue(
                            key: categoryMenueKey,
                            items: categoryData.map((i) {
                              return i['name'] as String;
                            }).toList(),
                            itemHeight: ScreenUtil().L(44),
                            itemWidth: ScreenUtil().L(75),
                            menueTaped: menueItemTap),
                      ),
                    ),
                    RightListView(
                        key: rightListviewKey,
                        height: widget.rightListViewHeight,
                        dataItems: listViewData,
                        listViewChanged: listViewChanged),
                  ],
                ),
              )
            ],
          )),
    );
  }

  menueItemTap(int i) {
    rightListviewKey.currentState.jumpTopage(i);
  }

  listViewChanged(i) {
    this.categoryMenueKey.currentState.moveToTap(i);
  }

  @override
  void reassemble() {
    listViewData = categoryData.map((i) {
      return SubCategoryListModel.fromJson(i);
    }).toList();
    super.reassemble();
  }

  @override
  void initState() {
    listViewData = categoryData.map((i) {
      return SubCategoryListModel.fromJson(i);
    }).toList();
    super.initState();
  }
}
