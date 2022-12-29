import 'package:anonymous_chat/utils/global.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  AuthService._();

  factory AuthService.getInstance() => _instance;
  static final AuthService _instance = AuthService._();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<bool> verify(String verificationId, String otp) async {
    try {
      print("auth request");
      AuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: otp);
      UserCredential credentials =
          await FirebaseAuth.instance.signInWithCredential(credential);
      String? uid = credentials.user?.uid;
      String? phoneNumber = credentials.user?.phoneNumber;
      await preferenceService.setUID(uid ?? "");
      await preferenceService.setPhone(phoneNumber ?? "");
      return true;
    } catch (e) {
      return false;
    }
  }

  logout() async {
    try {
      await _firebaseAuth.signOut();
      await preferenceService.removeUID();
      await preferenceService.removePhone();
    } catch (e) {
      return e;
    }
  }
}
