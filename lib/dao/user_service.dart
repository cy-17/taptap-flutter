import 'package:TapTap/config/http/http.dart';
import 'package:TapTap/entity/response.dart';

class UserService {
  static const String BASEURL = "/taptap/user-info";

  static Future<RESPONSE> userLogin(String phoneNumber) async {
    Map<String, dynamic> response = await Http.get(
      "$BASEURL/login/$phoneNumber",
    );
    print(response.toString());

    return RESPONSE(
        code: response['code'],
        message: response['message'],
        map: response['data']);
  }

  static Future<RESPONSE> checkValidCode(
      String phoneNumber, String validCode) async {
    Map<String, dynamic> response = await Http.post(
        "$BASEURL/login/checkValidCode",
        params: {'phoneNumber': phoneNumber, 'validCode': validCode});
    print(response.toString());

    return RESPONSE(
        code: response['code'],
        message: response['message'],
        map: response['data']);
  }
}
