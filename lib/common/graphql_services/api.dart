import 'package:flutter/foundation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

String token = '';

ValueNotifier<GraphQLClient> client = ValueNotifier(
  GraphQLClient(
    cache: InMemoryCache(),
    link: HttpLink(
        uri: 'https://wechat.mooibay.com/graphql',
      headers: headers('')
    ),
  ),
);

Map<String, String> headers(token) => {
  "Content-Type": "application/json",
  "Accept": "application/json",
  "Authorization": "Bearer $token",
};


final String sendSMS = r'''
  mutation Send($device_id: String!, $mobile: ChineseMobile!) {
  sendSmsCode(input: {device_id: $device_id, mobile: $mobile}) {
    success
    registered
  }
}
''';

final String getToken = r'''
  mutation Check($device_id: String!, $mobile: ChineseMobile!, $code: SmsCode!) {
  getToken(input: {device_id: $device_id, mobile: $mobile, code: $code}) {
  token
  }
  }
  ''';

final String getUserInfo = r'''
  query ReadRepositories() {
  me{
    id
    info
    created_by
    created_at1
    updated_at
    orgs
    roles
  }
  }
''';

final String getJvToken = r'''
  mutation TrustMoblie($device_id: String!, $jv_token: String!) {
  trustMoblie(input: {device_id:$device_id, jv_token: $jv_token}) {
    token
    }
  }
''';