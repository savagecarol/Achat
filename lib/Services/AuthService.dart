import 'package:anonymous_chat/utils/global.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  AuthService._();

  factory AuthService.getInstance() => _instance;
  static final AuthService _instance = AuthService._();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Future<void> sendSms({required String phoneNumber}) async {
  //   try {
  //     await _firebaseAuth.verifyPhoneNumber(
  //       phoneNumber: phoneNumber,
  //       timeout: Duration(seconds: 60),
  //       verificationCompleted: (AuthCredential credential) async {
  //         UserCredential result =
  //             await _firebaseAuth.signInWithCredential(credential);
  //         if (result.user != null) {
  //           print("Success");
  //         } else {
  //           print("Error");
  //         }
  //       },
  //       verificationFailed: (FirebaseAuthException exception) {
  //         print(exception);
  //       },
  //       codeSent: (verificationId, forceResendingToken) {
  //         verification = verificationId;
  //       },
  //       codeAutoRetrievalTimeout: (verificationId) {
  //         verificationId = verificationId;
  //       },
  //     );
  //   } catch (e) {
  //     print("dfdfdffdf");
  //     print(e.toString());
  //     print("dfdfdffdf");
  //     print(e);
  //     print("dfdfdffdf");
  //   }
  // }

  Future<bool>  verify(String verificationId , String otp) async {
    try {
        print("auth request");
        AuthCredential credential = PhoneAuthProvider.credential(
            verificationId: verificationId, smsCode: otp);
        UserCredential credentials =
            await FirebaseAuth.instance.signInWithCredential(credential);
        print(credentials.user);
      }
   catch (e) {
      print(e);
      return false;
    }
    return true;
  }

  logout() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      print("Log Out in Auth Service");
      print(e);
      return e;
    }
  }
}
