import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DiscoveryCard extends StatelessWidget {
  final String coverImage;
  final String title;
  final String author;
  final String tags;
  final int likes;
  final int comments;
  final int favorites;

  DiscoveryCard(
      {this.coverImage,
        this.title,
        this.author,
        this.tags,
        this.likes,
        this.comments,
        this.favorites});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(width: 750, height: 1334, allowFontScaling: false);
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            color: Colors.deepOrange,
            child: CachedNetworkImage(
                imageUrl: '$coverImage'
            ),
          ),
          Container(
            padding:
            EdgeInsets.symmetric(horizontal: 20.w),
            margin: EdgeInsets.symmetric(vertical: 10.h),
            child: Text(
              '$title',
              style: TextStyle(
                  fontSize: 30.sp,
                  fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Container(
            padding: EdgeInsets.only(
                left: 20.w,
                bottom: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: NetworkImage('$coverImage'
                      ''
                      ''),
                  radius: 30.w,
                  // maxRadius: 40.0,
                ),
                Container(
                  margin: EdgeInsets.only(left:20.w),
                  width: 250.w,
                  child: Text(
                    '$author',
                    style: TextStyle(
                      fontSize: 25.sp,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 80.w),
                  child: Text(
                    '${tags == '' ? '经典' : '其他'}',
                    style: TextStyle(
                      fontSize: 25.sp,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

