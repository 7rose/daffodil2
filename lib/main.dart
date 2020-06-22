import 'package:flutter/material.dart';
import 'package:daffodil/common/navigators/router.dart';
import 'package:provider/provider.dart';
import 'package:daffodil/model/homeStore.dart';
import 'package:daffodil/model/initAppStore.dart';
import 'package:daffodil/common/utils/length.dart';
import 'package:daffodil/pages/shared/app_theme.dart';
import 'package:daffodil/pages/shared/size_fit.dart';

import 'common/utils/screen_util.dart';

void main() {
  runApp(
      MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (ctx) => InitAppModel()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    HYSizeFit.initialize();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'xx商场',
// 主题
      theme: HYAppTheme.norTheme,
      // 路由
      initialRoute: LLRouter.initialRoute,
      routes: LLRouter.routes,
      onGenerateRoute: LLRouter.generateRoute,
      onUnknownRoute: LLRouter.unknownRoute,
    );
  }
}
