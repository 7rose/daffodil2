import 'package:daffodil/common/graphql_services/api.dart';
import 'package:daffodil/pages/Discovery/discoveryCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class DiscoveryPage extends StatefulWidget {
  static const String routeName = "/discovery";
  @override
  _DiscoveryPageState createState() => new _DiscoveryPageState();
}

class _DiscoveryPageState extends State<DiscoveryPage> {
  var _scrollController = new ScrollController(initialScrollOffset: 0);
  var _discoveryList = [];
  var _load = 0;
  int _page = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      var px = _scrollController.position.pixels;
      if (px == _scrollController.position.maxScrollExtent) {
        print("加载更多！");
        _onLoadMore();
      }
    });
    _initData(_page);
  }

  Future<void> _initData(int page) async {
    var map = Map();
    map["size"] = 10;
    map["page"] = page;

    final QueryOptions queryDiscoveries =
        QueryOptions(documentNode: gql(getDiscoveries));

    final QueryResult result = await client.value.query(queryDiscoveries);
    if (result.data != null) {
      print('Discoveries:' + result.data.toString());
    } else {
      print('Get Discoveries Error' + result.exception.toString());
    }
    //var res = await HttpUtils.get("/data/福利/:size/:page", map);
//    var discoveryList = BaseBeanEntity.fromJsonList(res).getList<MeiZiEntity>();
    setState(() {
      print('discoveries0:' + page.toString());
      if (page == 1) {
        _discoveryList.clear();
      }
      print('discoveries2:' + result.data.toString());
      _discoveryList.addAll(result.data['discoveries']); //results为数组
      print('discoveries1:' + _discoveryList.toString());

      if (result.data == null || result.data.length == 0) {
        _load = 3;
      } else {
        _load = 0;
      }
      _page++;
    });
  }

//  Future<void> doGetDiscoveries() async {
//    final HttpLink d = client.value.link;
//
//    final QueryResult result = await client.value.query(queryDiscoveries);
//    print(result.data);
//    print('Get Discoveries Error' + result.exception.toString());
//  }

  @override
  Widget build1(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("发现"),
      ),
      body: new StaggeredGridView.countBuilder(
        crossAxisCount: 4,
        itemCount: 8,
        itemBuilder: (BuildContext context, int index) => new Container(
            color: Colors.green,
            child: new Center(
              child: new CircleAvatar(
                backgroundColor: Colors.white,
                child: new Text('$index'),
              ),
            )),
        staggeredTileBuilder: (int index) =>
            new StaggeredTile.count(2, index.isEven ? 2 : 1),
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print('Discoveries:' + _discoveryList.toString());
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("发现" + _discoveryList.length.toString()),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: RefreshIndicator(
              onRefresh: _onRefresh,
              child: StaggeredGridView.countBuilder(
                controller: _scrollController,
                padding: EdgeInsets.all(3),
                crossAxisCount: 4,
                itemCount: _discoveryList.length,
                itemBuilder: (BuildContext context, int index) => DiscoveryCard(
                  coverImage: _discoveryList[index]['cover_image'],
                  title: _discoveryList[index]['title'],
                  author: _discoveryList[index]['author']['name'],
                  tags: _discoveryList[index]['tags'].toString(),
                  likes: _discoveryList[index]['likes'],
                  comments: _discoveryList[index]['comments'],
                  favorites: _discoveryList[index]['favorites'],
                ),

//                  {
//                  print('discoveries2:'+index.toString()+_discoveryList[index]);
//                  return _discoveryList[index];
//                },
                staggeredTileBuilder: (index) => StaggeredTile.fit(2),
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
              ),
            ),
          ),
          Offstage(
            offstage: _load != 2,
            child: Center(
              child: Container(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        child: SizedBox(
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                          width: 14,
                          height: 14,
                        ),
                        alignment: Alignment.centerRight,
                        margin: EdgeInsets.only(right: 10),
                      ),
                    ),
                    Expanded(
                      child: Text("加载更多..."),
                    )
                  ],
                ),
                padding: EdgeInsets.all(15),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> _onRefresh() async {
    setState(() {
      _page = 1;
      _load = 1;
    });
    await _initData(_page);
    print("_onRefresh");
  }

  Future<void> _onLoadMore() async {
    if (_load == 3) return;
    setState(() {
      _load = 2;
    });
    await _initData(_page);
    print("_onLoadMore");
  }
}
