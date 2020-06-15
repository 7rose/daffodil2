import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../../../common/services/http_request.dart';

class LoginPage extends StatefulWidget {
  static String routeName = 'LoginPage';

  @override
  _Login createState() => new _Login();
}

class _Login extends State<LoginPage> {
  //获取Key用来获取Form表单组件
  GlobalKey<FormState> loginKey = new GlobalKey<FormState>();
  String userName;
  String password;
  String smsTxt;
  bool isShowPassWord = false;

  final GraphQLClient _client = GraphQLClient(
    cache: InMemoryCache(),
    link: HttpLink(
        uri: "https://wechat.mooibay.com/graphql",
        headers: <String, String>{
          'Authorization': 'Bearer 1|ur8G6LplMWxvEIXCjY07yZ0jEW3hUEV74nEBUtg8jNOwQTPhAAK3XmSrAUcx2NT0alwtngIsc2WmNfKs',
        }
    ),
  );


  static const String sendSMS = r'''
  mutation Send($device_id: String!, $mobile: ChineseMobile!) {
  sendSmsCode(input: {device_id: $device_id, mobile: $mobile}) {
    success
    registered
  }
}
''';

  static const String getToken= r'''
  mutation Check($device_id: String!, $mobile: ChineseMobile!, $code: SmsCode!) {
  getToken(input: {device_id: $device_id, mobile: $mobile, code: $code}) {
  token
  }
  }
  ''';

  static const String getUserInfo = r'''
  query ReadRepositories() {
  me{
    id
    info
    created_by
    created_at
    updated_at
    orgs
    roles
  }
  }
''';


  final MutationOptions sendSMSOptions = MutationOptions(
    documentNode: gql(sendSMS),
    variables: <String, dynamic>{
      'device_id': 'sadjkljakd11231231dsadadasd',
      'mobile': '18600407768',
    },
  );

  final MutationOptions getTokenOptions = MutationOptions(
    documentNode: gql(getToken),
    variables: <String, dynamic>{
      'device_id': 'sadjkljakd11231231dsadadasd',
      'mobile': '18600407768',
      'code':'',
    },
  );

  final MutationOptions getInfo = MutationOptions(
    documentNode: gql(getUserInfo)
  );


  static Future<List> getMealData() async {

    // 1.发送网络请求
    final url = "/meal";
    final result = await HttpRequest.request(url);

    // 2.json转modal
    final mealArray = result["meal"];
    List<String> meals = [];
    for (var json in mealArray) {
      meals.add('11');
    }
    return meals;
  }

  void login() {
    //读取当前的Form状态
//    var loginForm = loginKey.currentState;
//    //验证Form表单
//    if (loginForm.validate()) {
//      loginForm.save();
//      print('userName: ' + userName + ' password: ' + password);
////      getMealData();
//      getSMS(userName,password);
//    }
    this.doGetUserInfo();
  }

  Future<void> getSMS(String userName,String password) async {
    final QueryResult result = await _client.mutate(sendSMSOptions);
    print('==='+result.data.toString());
  }

  Future<void> doLogin(String userName,String password) async {
    final QueryResult result = await _client.mutate(getTokenOptions);
    print('==='+result.data.id);

  }

  Future<void> doGetUserInfo() async {
    final QueryResult result = await _client.mutate(getInfo);
    print(result.data);
    print('===22'+result.exception.toString());

  }

  void showPassWord() {
    setState(() {
      isShowPassWord = !isShowPassWord;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('登陆')),
      body: new Column(
        children: <Widget>[
          new Container(
              padding: EdgeInsets.only(top: 100.0, bottom: 10.0),
              child: new Text(
                'LOGO',
                style: TextStyle(
                    color: Color.fromARGB(255, 53, 53, 53),
                    fontSize: 50.0
                ),
              )
          ),
          new Container(
            padding: const EdgeInsets.all(16.0),
            child: new Form(
              key: loginKey,
              autovalidate: true,
              child: new Column(
                children: <Widget>[
                  Container(
                    decoration: new BoxDecoration(
                        border: new Border(
                            bottom: BorderSide(
                                color: Color.fromARGB(255, 240, 240, 240),
                                width: 1.0
                            )
                        )
                    ),
                    child: new TextFormField(
                      decoration: new InputDecoration(
                        labelText: '请输入手机号',
                        labelStyle: new TextStyle(
                            fontSize: 15.0, color: Color.fromARGB(255, 93, 93,
                            93)),
                        border: InputBorder.none,
                        // suffixIcon: new IconButton(
                        //   icon: new Icon(
                        //     Icons.close,
                        //     color: Color.fromARGB(255, 126, 126, 126),
                        //   ),
                        //   onPressed: () {

                        //   },
                        // ),
                      ),
                      keyboardType: TextInputType.phone,
                      onSaved: (value) {
                        userName = value;
                      },
                      validator: (phone) {
                        // if(phone.length == 0){
                        //   return '请输入手机号';
                        // }
                      },
                      onFieldSubmitted: (value) {

                      },
                    ),
                  ),
//                  Container(
//                    decoration:  BoxDecoration(
//                        border: new Border(
//                            bottom: BorderSide(
//                                color: Color.fromARGB(255, 240, 240, 240),
//                                width: 1.0
//                            )
//                        )
//                    ),
//                    child: TextFormField(
//                      decoration: new InputDecoration(
//                          labelText: '请输入密码',
//                          labelStyle: new TextStyle(
//                              fontSize: 15.0, color: Color.fromARGB(255, 93, 93,
//                              93)),
//                          border: InputBorder.none,
//                          suffixIcon: new IconButton(
//                            icon: new Icon(
//                              isShowPassWord ? Icons.visibility : Icons
//                                  .visibility_off,
//                              color: Color.fromARGB(255, 126, 126, 126),
//                            ),
//                            onPressed: showPassWord,
//                          )
//                      ),
//                      obscureText: !isShowPassWord,
//                      onSaved: (value) {
//                        password = value;
//                      },
//                    ),
//                  ),
                  Container(
                    decoration: new BoxDecoration(
                        border: new Border(
                            bottom: BorderSide(
                                color: Color.fromARGB(255, 240, 240, 240),
                                width: 1.0
                            )
                        )
                    ),
                    child: new TextFormField(
                      decoration: new InputDecoration(
                        labelText: '请输入验证码',
                        labelStyle: new TextStyle(
                            fontSize: 15.0, color: Color.fromARGB(255, 93, 93,
                            93)),
                        border: InputBorder.none,

                      ),
                      keyboardType: TextInputType.number,
                      onSaved: (value) {
                        smsTxt = value;
                      },
                      validator: (phone) {
                         if(phone.length == 0){
                           return '请输入验证码';
                         }
                         return '';
                      },
                      onFieldSubmitted: (value) {

                      },
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
                              color: Color.fromARGB(255, 255, 255, 255)
                          ),
                        ),
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(45.0)),
                      ),
                    ),
                  ),
                  new Container(
                    margin: EdgeInsets.only(top: 30.0),
                    padding: EdgeInsets.only(left: 8.0, right: 8.0),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new Container(
                          child: Text(
                            '注册账号',
                            style: TextStyle(
                                fontSize: 13.0,
                                color: Color.fromARGB(255, 53, 53, 53)
                            ),
                          ),

                        ),

                        Text(
                          '忘记密码？',
                          style: TextStyle(
                              fontSize: 13.0,
                              color: Color.fromARGB(255, 53, 53, 53)
                          ),
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

