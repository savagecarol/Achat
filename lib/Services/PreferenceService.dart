import 'package:shared_preferences/shared_preferences.dart';

class PreferenceService {
  PreferenceService._();

  factory PreferenceService.getInstance() => _instance;

  static final PreferenceService _instance = PreferenceService._();

  static const String uid = 'uid';
  static const String phone = 'phone';
static const String pigeonId = 'pigeonId';
  Future<SharedPreferences> _getInstance() async {
    return SharedPreferences.getInstance();
  }

  //uid

  Future<void> setUID(String uid) async {
    (await _getInstance()).setString(PreferenceService.uid, uid);
  }

  Future<String> getUID() async {
    String? value = (await _getInstance()).getString(PreferenceService.uid);
    if (value != null) {
      return value;
    }
    return "";
  }

  Future<void> removeUID() async {
    (await _getInstance()).setString(PreferenceService.uid, "");
  }


  Future<void> setPhone(String phone) async {
    (await _getInstance()).setString(PreferenceService.phone, phone.toString());
  }

  Future<String> getPhone() async {
    String? value = (await _getInstance()).getString(PreferenceService.phone);
    if (value != null) {
      return value;
    }
    return "";
  }
  Future<void> removePhone() async {
    (await _getInstance()).setString(PreferenceService.phone, "");
  }  


  Future<void> setPigeonId(int pigeonId) async {
    (await _getInstance()).setString(PreferenceService.pigeonId, pigeonId.toString());
  }

  Future<String> getPigeonId() async {
    String? value = (await _getInstance()).getString(PreferenceService.pigeonId);
    if (value != null) {
      return value;
    }
    return "";
  }
  Future<void> removePigeonId() async {
    (await _getInstance()).setString(PreferenceService.pigeonId, "");
  }  

}
