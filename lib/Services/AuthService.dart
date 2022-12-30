import 'dart:convert';
import 'package:anonymous_chat/models/AppUser.dart';
import 'package:anonymous_chat/utils/global.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  AuthService._();

  factory AuthService.getInstance() => _instance;
  static final AuthService _instance = AuthService._();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
      await preferenceService.removePigeonId();
    } catch (e) {
      return e;
    }
  }

  Future<int> getLastPigeonNumber() async {
    try {
      DocumentReference documentReference =
          await _firestore.collection('LASTMETAINFO').doc('pigeonNumber');
      DocumentSnapshot doc = await documentReference.get();
      int value = await jsonDecode(jsonEncode(doc.data()))['lastPigeonId'];
      await documentReference.set({'lastPigeonId': value + 1});
      return value + 1;
    } catch (e) {
      throw e;
    }
  }

  Future<void> createVerifiedUser() async {
    try {
      AppUser appUser = AppUser();
      appUser.uid = await preferenceService.getUID();
      appUser.phoneNumber = await preferenceService.getPhone();
      DocumentSnapshot checkDoc =
          await _firestore.collection('APPUSER').doc(appUser.phoneNumber).get();
      if (!checkDoc.exists) {
        appUser.pigeonId = await getLastPigeonNumber();
        appUser.isActive = true;
        DocumentReference documentReference =
            _firestore.collection('APPUSER').doc(appUser.phoneNumber);
        await documentReference.set({
          'uid': appUser.uid,
          'phoneNumber': appUser.phoneNumber,
          'pigeonId': appUser.pigeonId,
          'dateTime': appUser.creationTime,
          'isActive': appUser.isActive
        });
        await preferenceService.setPigeonId(appUser.pigeonId!);
      } else {
        DocumentReference documentReference =
            _firestore.collection('APPUSER').doc(appUser.phoneNumber);
        await documentReference.update({'isActive': true, 'uid': appUser.uid});
        await preferenceService.setPigeonId(checkDoc.get('pigeonId'));
      }
    } catch (e) {
      print("upload post in post service");
      print(e);
      throw e;
    }
  }

  Future<AppUser> creatUnverifiedUser(String phoneNumber) async {
    String? message = phoneRegex(phoneNumber);
    if (message == null) {
      try {
        AppUser appUser = AppUser();
        appUser.phoneNumber = checkStartPhoneNumber(phoneNumber);

        DocumentSnapshot checkDoc = await _firestore
            .collection('APPUSER')
            .doc(appUser.phoneNumber)
            .get();

        if (!checkDoc.exists) {
          appUser.pigeonId = await getLastPigeonNumber();
          appUser.isActive = false;
          DocumentReference documentReference =
              _firestore.collection('APPUSER').doc(appUser.phoneNumber);
          await documentReference.set({
            'pigeonId': appUser.pigeonId,
            'dateTime': appUser.creationTime,
            'isActive': appUser.isActive,
            'phoneNumber': appUser.phoneNumber
          });
          return appUser;
        } else {
          appUser.pigeonId = checkDoc.get('pigeonId');
          print(appUser.pigeonId);
          return appUser;
        }
      } catch (e) {
        showToast("!oops Something Went Wrong");
        return AppUser();
      }
    } else {
      showToast(message);
      return AppUser();
    }
  }
}
