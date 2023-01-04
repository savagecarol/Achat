import 'dart:convert';

import 'package:anonymous_chat/models/ExsistContact.dart';
import 'package:anonymous_chat/models/LastMessage.dart';
import 'package:anonymous_chat/models/LastMessageIcon.dart';
import 'package:anonymous_chat/utils/global.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_service/contacts_service.dart';

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
        displayName: nameByPhoneNumber(docList[i].get('receiver'), eList),
        lastMessage: docList[i].get('message'),
        time: docList[i].get('time').toDate(),
        receiver: docList[i].get('receiver'),
        receiverPigeonId: int.parse(docList[i].get('receiverPigeonId')),
      );
      message.seenTime == docList[i].get('seenTime');
      if (docList[i].id.startsWith(pigeonId)) {
        LastMessageIcon lastMessageIcon = LastMessageIcon(lastMessage: message);
        lastMessageIcon.isIcon = true;
        list.add(lastMessageIcon);
      } else if (docList[i].id.endsWith(pigeonId)) {
        String str = docList[i].id;
        str = str.substring(0, str.length - pigeonId.length);

        if (str == docList[i].get('receiverPigeonId'))
          message.receiver = docList[i].get('receiver');
        else
          message.receiver = docList[i].get('sender');

        message.receiverPigeonId = int.parse(str);
        message.displayName = "pigeon#" + str;
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
