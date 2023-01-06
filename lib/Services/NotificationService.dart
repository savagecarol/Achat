import 'dart:convert';

import 'package:anonymous_chat/models/Message.dart';
import 'package:anonymous_chat/utils/global.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;

class NotificationService {
  NotificationService._();
  factory NotificationService.getInstance() => _instance;
  static final NotificationService _instance = NotificationService._();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  getFcmToken(String pigeonId) async {
    NotificationSettings settings =
        await messaging.requestPermission(alert: true, sound: true);
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      String? value = await FirebaseMessaging.instance.getToken();
      await _firestore.collection('FCM').doc(pigeonId).set({'token': value!});
    }
  }

  void sendPushMessage(Message message) async {
    try {
      DocumentSnapshot x =
          await _firestore.collection('FCM').doc(message.receiverPigeonId).get();
      String? token = x.get('token');
      if (token != null) {
        var response =
            await http.post(Uri.parse("https://fcm.googleapis.com/fcm/send"),
                headers: {
                  "Content-Type": "application/json",
                  "Authorization":
                      "key=AAAA6xqGSk4:APA91bETou1sku3gVdy6vdugWBEQPfHMnL3RuqjlpCdz7c4NimpjwfMR2nFoyr7k4T9TLgC28dBeecXB1ZeeGbqYxgsKVgYFrm2ib43Q3b6I0vV-sjBscsuSsPyAEsb1FWB724wKWDg-"
                },
                body: jsonEncode({
                  "to": token,
                  "notification": {
                    "title": "Pigeon Message",
                    "body": message.message
                  }
                }));
        print(response.statusCode);
        print(response.body);
      }
    } catch (e) {
      print(e);
    }
  }
}
