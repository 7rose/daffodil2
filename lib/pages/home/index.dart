
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:daffodil/common/utils/length.dart';
import 'package:daffodil/common/utils/screen_util.dart';
import 'package:daffodil/pages/category/category.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:daffodil/pages/home/tbPage.dart';
import 'package:daffodil/pages/search/Search.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static HttpLink httpLink = HttpLink(uri: 'https://countries.trevorblades.com/');

  // 创建ValueNotifier，并传入HttpLink。在ValueNotifier中还可以自定义网络请求缓存策略
  final ValueNotifier<GraphQLClient> nitifier = ValueNotifier<GraphQLClient>(
    GraphQLClient(
      link: httpLink,
      cache: OptimisticCache(
        dataIdFromObject: typenameDataIdFromObject,
      ),
    ),
  );

  final ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
    GraphQLClient(
      link: httpLink,
      cache: OptimisticCache(
        dataIdFromObject: typenameDataIdFromObject,
      ),
    ),
  );




  final String query = '''
                      query Countries {
                          countries {
                            code
                            name
                            currency
                            emoji
                          }
                      }
                  ''';


  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: Klength.designWidth)..init(context);
    GlobalKey<TbHomeState> _newsKey = GlobalKey<TbHomeState>();

    return MaterialApp(
      home: DefaultTabController(
        length: 12,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: (){
                Scaffold.of(context).openDrawer();
              },
              icon: Icon(Icons.account_circle,color: Colors.white,size: 30),
            ),
            brightness: Brightness.light,
//            backgroundColor: Colors.white,
            bottom: PreferredSize(
              preferredSize:Size(100, 50) ,
              child: Row(
                children: <Widget>[
                  Container(
                    width: 360,
                    child: TabBar(
                      isScrollable: true,
                      tabs: [
                        Tab(text: '分类1',),
                        Tab(text: '分类2',),
                        Tab(text: '分类3',),
                        Tab(text: '分类4',),
                        Tab(text: '分类5',),
                        Tab(text: '分类6',),
                        Tab(text: '分类7',),
                        Tab(text: '分类8',),
                        Tab(text: '分类9',),
                        Tab(text: '分类10',),
                        Tab(text: '分类11',),
                        Tab(text: '分类12',),
                      ],
                    ),
                  ),
                IconButton(
                  icon: Icon(Icons.widgets,color:Colors.white),
                  onPressed: (){
//                    Navigator.of(context).push(route)
                    Navigator.of(context).pushNamed(Category.routeName,
                        arguments:{

                    });
                  },
                )
                ],
              ),
            ),
            title:Container(
              height: 30,
              margin:EdgeInsets.fromLTRB(20, 10, 40,10) ,
              decoration: BoxDecoration(
              color: Color(0xFFF2F2F2),
              borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                      Icon(Icons.search,color:Colors.black38),
                      FlatButton(
                          onPressed: (){
                            showSearch(context: context,delegate: SearchBarDelegate());
                            },
                          child: Text("大家都在搜",style: TextStyle(color: Colors.black38),))]
              ),
            )
          ),
          body: TabBarView(
            children: [
//              TbHome(),
              EasyRefresh(
              key: _newsKey,
                child: ListView(children:<Widget>[
                    TbHome(),
                ]),
                onRefresh: () async{},
//                onLoad: () async {},
              ),
              Icon(Icons.directions_transit),
              Icon(Icons.directions_bike),
              Icon(Icons.directions_car),
              Icon(Icons.directions_transit),
              Icon(Icons.directions_bike),
              Icon(Icons.directions_car),
              Icon(Icons.directions_transit),
              Icon(Icons.directions_bike),
              Icon(Icons.directions_car),
              Icon(Icons.directions_transit),
              GraphQLProvider(
                client:client,
                child: Query(
                  options: QueryOptions(documentNode:gql(query)),
                   builder: (QueryResult result, {VoidCallback refetch, FetchMore fetchMore }) {
                   if (result.loading) {
                     return Center(child: CircularProgressIndicator());
                    }

                    if (result.data == null) {
                      return Center(child: Text('Countries not found.'));
                     }
                  return EasyRefresh(child: _countriesView(result),
                    onRefresh: () async{},
                    onLoad: () async {},
                  );
                  }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ListView _countriesView(QueryResult result) {
    final countryList = result.data['countries'];
    return ListView.separated(
      itemCount: countryList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(countryList[index]['name']),
          subtitle: Text('Currency: ${countryList[index]['currency']}'),
          leading: Text(countryList[index]['emoji']),
          onTap: () {
            final snackBar = SnackBar(
                content:
                Text('Selected Country: ${countryList[index]['name']}'));
            Scaffold.of(context).showSnackBar(snackBar);
          },
        );
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
    );
  }

}
