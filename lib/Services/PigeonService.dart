import 'dart:convert';

import 'package:anonymous_chat/models/ExsistContact.dart';
import 'package:anonymous_chat/models/LastMessage.dart';
import 'package:anonymous_chat/models/LastMessageIcon.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PigeonService {
  PigeonService._();
  factory PigeonService.getInstance() => _instance;
  static final PigeonService _instance = PigeonService._();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<dynamic> getStream(String pigeonId) {
    return _firestore
        .collection('PIGEON')
        .orderBy('time', descending: true)
        .snapshots();
  }

  List<LastMessageIcon> getListOfLastMessage(List<DocumentSnapshot> docList,
      String pigeonId, List<ExsistContact> eList) {
    List<LastMessageIcon> list = [];

    for (int i = 0; i < docList.length; i++) {
      LastMessage message = LastMessage(
        displayName: "",
        lastMessage: docList[i].get('message'),
        time: docList[i].get('time').toDate(),
        receiver: "",
        receiverPigeonId: 0,
      );

      message.seenTime == docList[i].get('seenTime');
      message.isSeen = docList[i].get('isSeen');
    

      if (docList[i].id.startsWith(pigeonId)) {
        if (docList[i].get('senderPigeonId') == pigeonId) {
          message.displayName =
              nameByPhoneNumber(docList[i].get('receiver'), eList);
          message.receiver = docList[i].get('receiver');
          message.receiverPigeonId =
              int.parse(docList[i].get('receiverPigeonId'));
        } else {
          message.displayName =
              nameByPhoneNumber(docList[i].get('sender'), eList);
          message.receiver = docList[i].get('sender');
          message.receiverPigeonId =
              int.parse(docList[i].get('senderPigeonId'));
        }

        LastMessageIcon lastMessageIcon = LastMessageIcon(lastMessage: message);
        lastMessageIcon.isIcon = true;
        list.add(lastMessageIcon);
      } else if (docList[i].id.endsWith(pigeonId)) {
        if (docList[i].get('senderPigeonId') == pigeonId) {
          // ignore: prefer_interpolation_to_compose_strings
          message.displayName = "pigeon#" + docList[i].get('receiverPigeonId');
          message.receiver = docList[i].get('receiver');
          message.receiverPigeonId =
              int.parse(docList[i].get('receiverPigeonId'));
        } else {
          // ignore: prefer_interpolation_to_compose_strings
          message.displayName = "pigeon#" + docList[i].get('senderPigeonId');
          message.receiver = docList[i].get('sender');
          message.receiverPigeonId =
              int.parse(docList[i].get('senderPigeonId'));
        }

        LastMessageIcon lastMessageIcon = LastMessageIcon(lastMessage: message);
        lastMessageIcon.isIcon = false;
        list.add(lastMessageIcon);
      }
    }
    return list;
  }

  String nameByPhoneNumber(String number, List<ExsistContact> listContact) {
    for (int i = 0; i < listContact.length; i++) {
      if (listContact[i].contactNumber.number == number) {
        return listContact[i].contactNumber.name;
      }
    }
    return number;
  }
}
