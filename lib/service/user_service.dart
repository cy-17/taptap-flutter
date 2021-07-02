import 'package:TapTap/config/http/http.dart';
import 'package:TapTap/config/http_options.dart';
import 'package:TapTap/entity/response.dart';
import 'package:TapTap/entity/user_info.dart';
import 'package:TapTap/util/GlobalData.dart';
import 'package:dio/dio.dart';

class UserService {
  static const String BASEURL = "/taptap/user-info";

  static Future<RESPONSE> userLogin(String phoneNumber) async {
    Map<String, dynamic> response = await Http.get(
      "$BASEURL/login/$phoneNumber",
    );

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

    return RESPONSE(
        code: response['code'],
        message: response['message'],
        map: response['data']);
  }

  static Future<UserInfo> getUserInfo() async {
    Response response = await Dio().get(
        "${HttpOptions.BASE_URL2}/user/queryprofile/${GlobalData.userInfo!.userId!}");
    UserInfo userInfo = UserInfo.fromEmpty();
    dynamic data = response.data['data'];
    userInfo.sex = data['Sex'];
    userInfo.userProfile = data['Introduction'];
    userInfo.userBirthday = data['Birthday'];
    userInfo.region = data['Location'];
    return userInfo;
  }

  static Future<Null> changgeInfo(
      String phoneNumber,
      String nickName,
      String profile,
      String coverImageUrl,
      int sex,
      String region,
      String birthday) async {
    Response response = await Dio().post(
        "${HttpOptions.BASE_URL2}/user/updateprofile/${GlobalData.userInfo!.userId!}",
        data: {
          "sex": sex,
          "nickname": nickName,
          "phone": phoneNumber,
          "avatar": coverImageUrl,
          "introduction": profile,
          "location": region,
          "birthday": birthday
        });
    GlobalData.userInfo!.userNickName = nickName;
    GlobalData.userInfo!.userPhoneNumber = phoneNumber;
    GlobalData.userInfo!.userCoverUrl = coverImageUrl;
    return null;
  }

  static Future<int> login(String phoneNumber) async {
    Response response = await Dio().post("${HttpOptions.BASE_URL2}/user/signin",
        data: {'passport': phoneNumber, 'password': "123456"});
    return response.data['data']['UserId'];
  }

  static Future<RESPONSE> uploadFile(String filePath) async {
    var image = await MultipartFile.fromFile(
      filePath,
    );
    FormData formData = FormData.fromMap({"file": image});
    Map<String, dynamic> response =
        await Http.post("$BASEURL/login/register/uploadCover", data: formData);
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

    dynamic d = new Dio().post("${HttpOptions.BASE_URL2}/user/signup", data: {
      "passport": userInfo.userPhoneNumber,
      "password": "123456",
      "password2": "123456",
      "nickname": userInfo.userNickName,
      "Avatar": userInfo.userCoverUrl
    }).then((value) => {
          login(userInfo.userPhoneNumber!).then((value) {
            userInfo.userId = value;
            GlobalData.userInfo = userInfo;
          })
        });
    return RESPONSE(
        code: response['code'],
        message: response['message'],
        map: response['data']);
  }
}
