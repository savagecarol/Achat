import 'dart:convert';
import 'package:anonymous_chat/models/AppUser.dart';
import 'package:anonymous_chat/models/LastMetaInfo.dart';
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
      appUser.isActive = true;

      DocumentSnapshot checkDoc =
          await _firestore.collection('APPUSER').doc(appUser.uid).get();
      if (!checkDoc.exists) {
        appUser.pigeonId = await getLastPigeonNumber();
        DocumentReference documentReference =
            _firestore.collection('APPUSER').doc(appUser.uid);
        await documentReference.set({
          'uid': appUser.uid,
          'phoneNumber': appUser.phoneNumber,
          'pigeonId': appUser.pigeonId,
          'dateTime': appUser.creationTime,
          'isActive': appUser.isActive
        });
      }
    } catch (e) {
      print("upload post in post service");
      print(e);
      throw e;
    }
  }
}
