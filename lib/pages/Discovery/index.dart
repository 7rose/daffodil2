import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class DiscoveryPage extends StatelessWidget {
  static const String routeName = "/discovery";
  static HttpLink httpLink =
  HttpLink(uri: 'https://countries.trevorblades.com/');

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
    return Scaffold(
      appBar: AppBar(
        title: Text("发现"),
      ),
      body: GraphQLProvider(
        client: client,
        child: Query(
            options: QueryOptions(documentNode: gql(query)),
            builder: (QueryResult result,
                {VoidCallback refetch, FetchMore fetchMore}) {
              if (result.loading) {
                return Center(child: CircularProgressIndicator());
              }

              if (result.data == null) {
                return Center(child: Text('Countries not found.'));
              }
              return EasyRefresh(
                child: StaggeredGridView.countBuilder(
                  crossAxisCount: 4,
                  itemCount: 20,
                  itemBuilder: (BuildContext context, int index) =>
                      Container(
                        color: Colors.blue,
                          child: getItem()
                      ),
                  staggeredTileBuilder: (int index) =>
                  new StaggeredTile.count(2, index.isEven ? 2 : 1),
                  mainAxisSpacing: 4.0,
                  crossAxisSpacing: 4.0,
                ),
                onRefresh: () async {},
                onLoad: () async {},
              );
            }),
      ),
    );
  }

  Widget getItem() {
    return Stack(
      children: [
        Image.network(
            'https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=1249876518,1604997101&fm=26&gp=0.jpg',
            fit: BoxFit.cover,
          height: 220,
        ),
        Text('我是标题',style: TextStyle(),),
      ],
    );
  }
}
