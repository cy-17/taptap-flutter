class UserInfo {
  int? userId;
  String? userNickName;
  String? userPhoneNumber;
  String? userCoverUrl;
  String? userBirthday;
  String? userProfile;
  int? sex;
  String? region;

  UserInfo.fromEmpty();
  UserInfo(this.userNickName, this.userPhoneNumber, this.userCoverUrl);
}
