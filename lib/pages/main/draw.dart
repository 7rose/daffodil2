import 'package:flutter/material.dart';
import 'package:daffodil/common/extension/int_extension.dart';

class HomeDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 210.px,
        child: Drawer(
          child: Column(
            children: <Widget>[
              buildHeaderView(context),
              buildListTile(context, Icon(Icons.reorder), "订单", () {
              }),
              buildListTile(context, Icon(Icons.settings), "设置", () {
                Navigator.of(context).pop();

              }),
            ],
          ),
        )
    );
  }

  Widget buildHeaderView(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 120.px,
      color: Colors.grey[300],
      margin: EdgeInsets.only(bottom: 20.px),
      alignment: Alignment(0, 0.5),
      child: Row(
        children: <Widget>[
          SizedBox(width: 10,),
          Icon(Icons.account_circle,size: 40,),
          SizedBox(width: 10,),
          Text("138****1111", style: Theme.of(context).textTheme.headline4),
        ],
      ),
    );
  }

  Widget buildListTile(BuildContext context, Widget icon, String title, Function handler) {
    return ListTile(
      leading: icon,
      title: Text(title, style: Theme.of(context).textTheme.headline3,),
      onTap: handler,
    );
  }
}
