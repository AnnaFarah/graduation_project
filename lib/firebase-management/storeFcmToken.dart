import '../constant/appliApis.dart';
import 'package:http/http.dart' as http;

Future<void> storeFcmToken(
        {required String fcmToken, required String authToken}) =>
    http.post(
      Uri.parse('$url/api/storeFcmToken'),
      body: {'fcm_token': fcmToken},
      headers: {'Authorization': 'Bearer $authToken'},
    );
