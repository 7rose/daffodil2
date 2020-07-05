import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../../../common/graphql_services/api.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jverify/jverify.dart';
import 'dart:async';
import 'dart:io';
import 'countdownTimer.dart';

class LoginPage extends StatefulWidget {
  static String routeName = 'LoginPage';
  @override
  _Login createState() => new _Login();
}
const tokenSaveName = 'token';

class _Login extends State<LoginPage> {
  //获取Key用来获取Form表单组件
  GlobalKey<FormState> loginKey = new GlobalKey<FormState>();
  String userName;
  String password;
  String smsTxt;
  bool isShowPassWord = false;


  bool _isShowFirstLogin = false;
  final Jverify jverify = new Jverify();   ///极光认证
  final String f_result_key = "result";  /// 统一 key
  final String f_code_key = "code";   /// 错误码
  final String f_msg_key = "message";   /// 回调的提示信息，统一返回 flutter 为 message
  /// 运营商信息
  final String f_opr_key = "operator";
  bool _loading = false;
  bool isShowTopSpeedLogin = false;
  String _result = "token=";
  String _platformVersion = 'Unknown';


  final MutationOptions getInfo =
      MutationOptions(documentNode: gql(getUserInfo));

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  void login() {
    FocusScope.of(context).requestFocus(FocusNode());
    this.doLogin();
  }

  void topSpeedLogin() {
    FocusScope.of(context).requestFocus(FocusNode());
    loginAuth();
  }

  Future<void> getSMS() async {
    if(this.userName.length < 11){
      // 手机号验证错误
      return;
    }

    final MutationOptions sendSMSOptions = MutationOptions(
      documentNode: gql(sendSMS),
      variables: <String, dynamic>{
        'device_id': 'sadjkljakd11231231dsadadasd',
        'mobile':this.userName ,
      },
    );
    final QueryResult result = await client.value.mutate(sendSMSOptions);
    print('=== getSMS' + result.data.toString());
  }

  Future<void> doLogin() async {
    final MutationOptions getTokenOptions = MutationOptions(
      documentNode: gql(getToken),
      variables: <String, dynamic>{
        'device_id': 'sadjkljakd11231231dsadadasd',
        'mobile': this.userName,
        'code': this.smsTxt,
      },
    );
    final QueryResult result = await client.value.mutate(getTokenOptions);
    final String token = result.data.toString();
    print('===' + token);
//    {result.data.getToken.token} is auth token
    showDialog(context: context, builder: (ctx)=> new AlertDialog(
      content:  Text('$token'),
    ));

    if(token != null){
      ///登录成功 存储token
      SpUtil.putString(tokenSaveName, token);
      String savedTokeName = SpUtil.getString(tokenSaveName);
      print("MyApp savedToken = : $savedTokeName ");
    }
  }

  Future<void> doGetUserInfo() async {
    final HttpLink d = client.value.link;
    final QueryResult result = await client.value.mutate(getInfo);
    print(result.data);
    print('===22' + result.exception.toString());
  }

  Future<void> getJVToken(String token) async {
    final MutationOptions getJVTokenOptions = MutationOptions(
      documentNode: gql(getJvToken),
      variables: <String, dynamic>{
        'device_id': 'sadjkljakd11231231dsadadasd',
        'jv_token': token,
      },
    );
    final QueryResult result = await client.value.mutate(getJVTokenOptions);
    print('===22' + result.data.toString());

    showDialog(context: context, builder: (ctx)=> new AlertDialog(
      content:  Text(result.data.toString()),
    ));
  }

  void showPassWord() {
    setState(() {
      isShowPassWord = !isShowPassWord;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('')),
      body: new Column(
        children: <Widget>[
          new Container(
            padding: const EdgeInsets.all(16.0),
            child: new Form(
              key: loginKey,
              autovalidate: true,
              child: new Column(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: Color.fromARGB(255, 240, 240, 240),
                                width: 1.0))),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: '请输入手机号',
                        labelStyle: TextStyle(
                            fontSize: 15.0,
                            color: Color.fromARGB(255, 93, 93, 93)),
                        border: InputBorder.none,
                      ),
                      keyboardType: TextInputType.phone,
                      onSaved: (value) {
                        this.userName = value;
                      },
                      validator: (phone) {
                        this.userName = phone;
                        if (phone.length > 0 && phone.length < 11) {
                          return '请输入正确的手机号';
                        }
                        return '';
                      },
                      onFieldSubmitted: (value) {},
                    ),
                  ),
                  Container(
                    decoration: new BoxDecoration(
                        border: new Border(
                            bottom: BorderSide(
                                color: Color.fromARGB(255, 240, 240, 240),
                                width: 1.0))),
                    child: new TextFormField(
                      decoration: new InputDecoration(
                          labelText: '请输入验证码',
                          labelStyle: new TextStyle(
                              fontSize: 15.0,
                              color: Color.fromARGB(255, 93, 93, 93)),
                          border: InputBorder.none,
                          suffixIcon: Container(
                            padding: EdgeInsets.only(top: 20),
                            child: LoginFormCode(onTapCallback: (){
                                this.getSMS();
                            },),
                          )),
                      keyboardType: TextInputType.number,
                      onSaved: (value) {
                        this.smsTxt = value;
                      },
                      validator: (phone) {
                        this.smsTxt = phone;
                        if (phone.length > 0 && phone.length < 4) {
                          return '请输入验证码';
                        }
                        return '';
                      },
                      onFieldSubmitted: (value) {},
                    ),
                  ),
                  Container(
                    height: 45.0,
                    margin: EdgeInsets.only(top: 40.0),
                    child: new SizedBox.expand(
                      child: new RaisedButton(
                        onPressed: login,
                        color: Color.fromARGB(255, 61, 203, 128),
                        child: new Text(
                          '登录',
                          style: TextStyle(
                              fontSize: 14.0,
                              color: Color.fromARGB(255, 255, 255, 255)),
                        ),
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(45.0)),
                      ),
                    ),
                  ),
                  _getFirstLoginButton(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _getFirstLoginButton() {
    if(_isShowFirstLogin){
      return Container(
        height: 45.0,
        margin: EdgeInsets.only(top: 40.0),
        child: new SizedBox.expand(
          child: new RaisedButton(
            onPressed: topSpeedLogin,
            color: Color.fromARGB(123, 161, 103, 228),
            child: new Text(
              '本机号一键登录',
              style: TextStyle(
                  fontSize: 14.0,
                  color: Color.fromARGB(255, 255, 255, 255)),
            ),
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(45.0)),
          ),
        ),
      );
    }
    return Container(height:0.0,width:0.0);
  }
  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;

    // 初始化 SDK 之前添加监听
    jverify.addSDKSetupCallBackListener((JVSDKSetupEvent event) {
      print("receive sdk setup call back event :${event.toMap()}");
    });

    jverify.setDebugMode(true); // 打开调试模式
    jverify.setup(
        appKey: "49364da11a01d0e92197c41d", //"你自己应用的 AppKey",
        channel: "devloper-default");
    // 初始化sdk,  appKey 和 channel 只对ios设置有效
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
    setState(() {
      _platformVersion = platformVersion;
    });

    /// 授权页面点击时间监听
    jverify.addAuthPageEventListener((JVAuthPageEvent event) {
      print("receive auth page event :${event.toMap()}");
    });

    isInitSuccess();
    checkVerifyEnable();
  }

  /// sdk 初始化是否完成
  void isInitSuccess() {
    jverify.isInitSuccess().then((map) {
      bool result = map[f_result_key];
      setState(() {
        if (result) {
          _result = "sdk 初始换成功";
        } else {
          _result = "sdk 初始换失败";
        }
      });
    });
  }

  /// 判断当前网络环境是否可以发起认证
  void checkVerifyEnable() {
    jverify.checkVerifyEnable().then((map) {
      bool result = map[f_result_key];
      setState(() {
        if (result) {
          _isShowFirstLogin = true;
          setState(() {

          });
          _result = "当前网络环境【支持认证】！";
        } else {
          _result = "当前网络环境【不支持认证】！";
        }
      });
    });
  }

  void loginAuth() {
    setState(() {
      _loading = true;
    });
    jverify.checkVerifyEnable().then((map) {
      bool result = map[f_result_key];
      if (result) {

        final screenSize = MediaQuery.of(context).size;
        final screenWidth = screenSize.width;
        final screenHeight = screenSize.height;
        bool isiOS = Platform.isIOS;

        /// 自定义授权的 UI 界面，以下设置的图片必须添加到资源文件里，
        /// android项目将图片存放至drawable文件夹下，可使用图片选择器的文件名,例如：btn_login.xml,入参为"btn_login"。
        /// ios项目存放在 Assets.xcassets。
        ///
        JVUIConfig uiConfig = JVUIConfig();
        //uiConfig.authBackgroundImage = ;

        //uiConfig.navHidden = true;
        uiConfig.navColor = Colors.red.value;
        uiConfig.navText = "";
        uiConfig.navTextColor = Colors.white.value;
        uiConfig.navReturnImgPath = "return_bg"; //图片必须存在

        uiConfig.logoWidth = 100;
        uiConfig.logoHeight = 80;
        //uiConfig.logoOffsetX = isiOS ? 0 : null;//(screenWidth/2 - uiConfig.logoWidth/2).toInt();
        uiConfig.logoOffsetY = 10;
        uiConfig.logoVerticalLayoutItem = JVIOSLayoutItem.ItemSuper;
        uiConfig.logoHidden = false;
        uiConfig.logoImgPath = "logo";

        uiConfig.numberFieldWidth = 200;
        uiConfig.numberFieldHeight = 40;
        //uiConfig.numFieldOffsetX = isiOS ? 0 : null;//(screenWidth/2 - uiConfig.numberFieldWidth/2).toInt();
        uiConfig.numFieldOffsetY = isiOS ? 20 : 120;
        uiConfig.numberVerticalLayoutItem = JVIOSLayoutItem.ItemLogo;
        uiConfig.numberColor = Colors.blue.value;
        uiConfig.numberSize = 18;

        uiConfig.sloganOffsetY = isiOS ? 20 : 160;
        uiConfig.sloganVerticalLayoutItem = JVIOSLayoutItem.ItemNumber;
        uiConfig.sloganTextColor = Colors.black.value;
        uiConfig.sloganTextSize = 15;
//        uiConfig.slogan
        //uiConfig.sloganHidden = 0;

        uiConfig.logBtnWidth = 220;
        uiConfig.logBtnHeight = 50;
        //uiConfig.logBtnOffsetX = isiOS ? 0 : null;//(screenWidth/2 - uiConfig.logBtnWidth/2).toInt();
        uiConfig.logBtnOffsetY = isiOS ? 20 : 230;
        uiConfig.logBtnVerticalLayoutItem = JVIOSLayoutItem.ItemSlogan;
        uiConfig.logBtnText = "登录";
        uiConfig.logBtnTextColor = Colors.brown.value;
        uiConfig.logBtnTextSize = 16;
        uiConfig.loginBtnNormalImage = "login_btn_normal"; //图片必须存在
        uiConfig.loginBtnPressedImage = "login_btn_press"; //图片必须存在
        uiConfig.loginBtnUnableImage = "login_btn_unable"; //图片必须存在

        uiConfig.privacyHintToast =
            false; //only android 设置隐私条款不选中时点击登录按钮默认显示toast。

        uiConfig.privacyState = true; //设置默认勾选
        uiConfig.privacyCheckboxSize = 20;
        uiConfig.checkedImgPath = "check_image"; //图片必须存在
        uiConfig.uncheckedImgPath = "uncheck_image"; //图片必须存在
        uiConfig.privacyCheckboxInCenter = true;
        //uiConfig.privacyCheckboxHidden = false;

        //uiConfig.privacyOffsetX = isiOS ? (20 + uiConfig.privacyCheckboxSize) : null;
        uiConfig.privacyOffsetY = 60; // 距离底部距离
        uiConfig.privacyVerticalLayoutItem = JVIOSLayoutItem.ItemSuper;
        uiConfig.clauseName = "协议1";
        uiConfig.clauseUrl = "http://www.baidu.com";
        uiConfig.clauseBaseColor = Colors.black.value;
        uiConfig.clauseNameTwo = "协议二";
        uiConfig.clauseUrlTwo = "http://www.hao123.com";
        uiConfig.clauseColor = Colors.red.value;
        uiConfig.privacyText = ["登录即表示您已详细阅读并同意", "app", "与", ""];
        uiConfig.privacyTextSize = 13;
        //uiConfig.privacyWithBookTitleMark = true;
        //uiConfig.privacyTextCenterGravity = false;
        uiConfig.authStatusBarStyle = JVIOSBarStyle.StatusBarStyleDarkContent;
        uiConfig.privacyStatusBarStyle = JVIOSBarStyle.StatusBarStyleDefault;

        uiConfig.statusBarColorWithNav = true;
        uiConfig.virtualButtonTransparent = true;

        uiConfig.privacyStatusBarColorWithNav = true;
        uiConfig.privacyVirtualButtonTransparent = true;

        uiConfig.needStartAnim = true;
        uiConfig.needCloseAnim = true;

        uiConfig.privacyNavColor = Colors.red.value;
        ;
        uiConfig.privacyNavTitleTextColor = Colors.blue.value;
        uiConfig.privacyNavTitleTextSize = 16;

        uiConfig.privacyNavTitleTitle = "ios lai le"; //only ios
        uiConfig.privacyNavTitleTitle1 = "协议11 web页标题";
        uiConfig.privacyNavTitleTitle2 = "协议22 web页标题";
        uiConfig.privacyNavReturnBtnImage = "return_bg"; //图片必须存在;

        /// 添加自定义的 控件 到授权界面
        List<JVCustomWidget> widgetList = [];

        /// 步骤 1：调用接口设置 UI
        jverify.setCustomAuthorizationView(true, uiConfig,
            landscapeConfig: uiConfig, widgets: widgetList);

        /// 步骤 2：调用一键登录接口

        /// 方式一：使用同步接口 （如果想使用异步接口，则忽略此步骤，看方式二）
        /// 先，添加 loginAuthSyncApi 接口回调的监听
        jverify.addLoginAuthCallBackListener((event) {
          setState(() {
            _loading = false;
            _result = "监听获取返回数据：[${event.code}] message = ${event.message}";
            this.getJVToken(event.message);
          });
          print(
              "通过添加监听，获取到 loginAuthSyncApi 接口返回数据，code=${event.code},message = ${event.message},operator = ${event.operator}");
        });

        /// 再，执行同步的一键登录接口
        jverify.loginAuthSyncApi(autoDismiss: true);
      } else {
        setState(() {
          _loading = false;
          _result = "[2016],msg = 当前网络环境不支持认证";
        });
      }
    });
  }
}
