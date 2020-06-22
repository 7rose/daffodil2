import 'package:flutter/material.dart';
import 'package:jverify/jverify.dart';
import 'dart:async';
import 'dart:io';
import 'package:modal_progress_hud/modal_progress_hud.dart';


class InitAppModel extends ChangeNotifier {

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    final Jverify jverify = new Jverify();

    // 初始化 SDK 之前添加监听
    jverify.addSDKSetupCallBackListener((JVSDKSetupEvent event){
      print("receive sdk setup call back event :${event.toMap()}");
    });

    jverify.setDebugMode(true); // 打开调试模式
    jverify.setup(
        appKey: "49364da11a01d0e92197c41d",//"你自己应用的 AppKey",
        channel: "devloper-default");
    // 初始化sdk,  appKey 和 channel 只对ios设置有效
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.

    /// 授权页面点击时间监听
    jverify.addAuthPageEventListener((JVAuthPageEvent event) {
      print("receive auth page event :${event.toMap()}");
    });
  }

}