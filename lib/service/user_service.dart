import 'dart:io';

import 'package:TapTap/config/http/http.dart';
import 'package:TapTap/entity/response.dart';
import 'package:TapTap/entity/user_info.dart';
import 'package:dio/dio.dart';

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

  static Future<RESPONSE> uploadFile(String filePath) async {
    var image = await MultipartFile.fromFile(
      filePath,
    );
    print("object");
    FormData formData = FormData.fromMap({"file": image});
    Map<String, dynamic> response =
        await Http.post("$BASEURL/login/register/uploadCover", data: formData);
    print(response.toString());
    return RESPONSE(
        code: response['code'],
        message: response['message'],
        map: response['data']);
  }

  static Future<RESPONSE> register(UserInfo userInfo) async {
    Map<String, dynamic> response =
        await Http.post("$BASEURL/login/register", params: {
      "userNickName": userInfo.userNickName,
      "userPhoneNumber": userInfo.userPhoneNumber,
      "userCoverUrl": userInfo.userCoverUrl
    });
    print(response.toString());
    return RESPONSE(
        code: response['code'],
        message: response['message'],
        map: response['data']);
  }
}
