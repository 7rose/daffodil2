import 'package:flutter/material.dart';
import 'package:daffodil/pages/search/Search.dart';
import './color.dart';
import './string.dart';

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      margin: EdgeInsets.only(top:MediaQuery.of(context).padding.top),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color:KColorConstant.searchBarBgColor,width: 1.0))),
      padding: EdgeInsets.symmetric(horizontal: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(icon:
          Icon(Icons.arrow_back),iconSize:28,
              onPressed:(){
                Navigator.of(context).pop();
              }
          ),
          SizedBox(width: 35),
          Expanded(
            child: Container(
              width: 300,
            height: 27, margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
            padding: EdgeInsets.symmetric(horizontal: 6),
            alignment: Alignment.center,
            color: KColorConstant.searchBarBgColor,
            child: Row(
              children: <Widget>[
                Icon(Icons.search,size: 17,),
                FlatButton(
                  onPressed: (){
                    showSearch(context: context,delegate: SearchBarDelegate());
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 5) ,
                    child: Text(KString.categorySearchBarHint,style: TextStyle(color: KColorConstant.searchBarTxtColor),),
                  ),
                )
              ],
            ),
        ),
          )],
      ),
    );
  }
}
