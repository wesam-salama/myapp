import 'package:shared_preferences/shared_preferences.dart';

class ShaerdHelper {
  ShaerdHelper._();

  static ShaerdHelper sHelper = ShaerdHelper._();

  SharedPreferences sharedPreferences;

  initSharedPrefrences() async {
    if (sharedPreferences == null) {
      sharedPreferences = await SharedPreferences.getInstance();
      return sharedPreferences;
    } else {
      return sharedPreferences;
    }
  }

  setValueisSeen(bool value) async {
    sharedPreferences = await initSharedPrefrences();
    sharedPreferences.setBool('seen', value);
  }

  setValueisSeenOnBoarding(bool value) async {
    sharedPreferences = await initSharedPrefrences();
    sharedPreferences.setBool('OnBoardingSeen', value);
  }

  setUserName(String name) async {
    sharedPreferences = await initSharedPrefrences();
    sharedPreferences.setString('userName', name);
  }

  setMobile(String mobile) async {
    sharedPreferences = await initSharedPrefrences();
    sharedPreferences.setString('mobile', mobile);
  }

  setUid(String uid) async {
    sharedPreferences = await initSharedPrefrences();
    sharedPreferences.setString('uid', uid);
  }

  setEmail(String email) async {
    sharedPreferences = await initSharedPrefrences();
    sharedPreferences.setString('email', email);
  }

  setPhotoUrl(String photoUrl) async {
    sharedPreferences = await initSharedPrefrences();
    sharedPreferences.setString('photoUrl', photoUrl);
  }

  Future<String> getUserName() async {
    sharedPreferences = await initSharedPrefrences();
    String informationUser = sharedPreferences.getString('userName');
    return informationUser;
  }

  Future<String> getEmail() async {
    sharedPreferences = await initSharedPrefrences();
    String informationUser = sharedPreferences.getString('email');
    return informationUser;
  }

  Future<String> getUid() async {
    sharedPreferences = await initSharedPrefrences();
    String informationUser = sharedPreferences.getString('uid');
    return informationUser;
  }

  Future<String> getPhotoUrl() async {
    sharedPreferences = await initSharedPrefrences();
    String informationUser = sharedPreferences.getString('photoUrl');
    return informationUser;
  }

  Future<String> getMobile() async {
    sharedPreferences = await initSharedPrefrences();
    String informationUser = sharedPreferences.getString('mobile');
    return informationUser;
  }

  Future<bool> getValueisSeen() async {
    sharedPreferences = await initSharedPrefrences();

    bool x = sharedPreferences.getBool('seen');
    return x;
  }

  Future<bool> getValueisSeenOnBoarding() async {
    sharedPreferences = await initSharedPrefrences();

    bool x = sharedPreferences.getBool('OnBoardingSeen');
    return x;
  }
}
