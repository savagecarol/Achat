import 'dart:math';

import 'package:anonymous_chat/Services/AuthService.dart';
import 'package:anonymous_chat/Services/ContactService.dart';
import 'package:anonymous_chat/Services/MessageService.dart';
import 'package:anonymous_chat/Services/PigeonService.dart';
import 'package:anonymous_chat/Services/PreferenceService.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

String verification = "";
final AuthService authService = AuthService.getInstance();
final ContactService contactService = ContactService.getInstance();
final PreferenceService preferenceService = PreferenceService.getInstance();
final MessageService messageService = MessageService.getInstance();
final PigeonService pigeonService = PigeonService.getInstance();
final FirebaseMessaging messaging = FirebaseMessaging.instance;
final MAX_INT = 4294967296;

Color accentPurpleColor = Color(0xFF6A53A1);
Color primaryColor = Color(0xFF121212);
Color accentPinkColor = Color(0xFFF99BBD);
Color accentDarkGreenColor = Color(0xFF115C49);
Color accentYellowColor = Color(0xFFFFB612);
Color accentOrangeColor = Color(0xFFEA7A3B);

Color randomcolor() {
  var generatedColor = Random().nextInt(Colors.primaries.length);
  return Colors.primaries[generatedColor];
}

String displayName(String x, {int length = 26}) {
  if (x.length > length) return x.substring(0, length);
  return x;
}

String showTime(DateTime time) {
  Duration diff = DateTime.now().difference(time);
  if (diff.inHours.abs() > 48) {
    return "${time.day}/${time.month}/${time.year}";
  } else if (diff.inHours.abs() > 24) {
    return "Yesterday";
  } else {
    return "${time.hour}:${time.minute}";
  }
}

showToast(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0);
}

String? phoneRegex(String phone) {
  String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
  RegExp regExp = new RegExp(pattern);
  if (phone.length == 0) {
    return 'Please enter mobile number';
  } else if (!regExp.hasMatch(phone)) {
    return 'Please enter valid mobile number';
  }
  return null;
}

String checkStartPhoneNumber(String phone) {
  if (phone.startsWith("+91")) {
    return phone;
  }
  if (phone.length == 11 && phone.startsWith("0")) {
    return "+91${phone.substring(1, 11)}";
  }
  if (phone.length == 12) {
    return "+$phone";
  } else {
    return "+91$phone";
  }
}

String removeSpaceDashBracket(String? phone) {
  if (phone == null) {
    showToast("!!Oops Something went Wrong");
    return "";
  } else {
    String x = "";
    for (int i = 0; i < phone.length; i++) {
      if (double.tryParse(phone[i]) != null) {
        x = x + phone[i];
      }
    }
    return x;
  }
}
