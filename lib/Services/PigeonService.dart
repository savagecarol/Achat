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

  List<LastMessageIcon> getListOfLastMessage(
      List<DocumentSnapshot> docList, String pigeonId, List<Contact> contacts) {
    List<LastMessageIcon> list = [];
    for (int i = 0; i < docList.length; i++) {
      LastMessage message = LastMessage(
          displayName:
              nameByPhoneNumber(docList[i].get('receiver'), contacts),
          lastMessage: docList[i].get('message'),
          timeStamp: DateTime.now());
      message.seenTime == docList[i].get('seenTime');
      LastMessageIcon lastMessageIcon = LastMessageIcon(lastMessage: message);
      lastMessageIcon.isIcon = true;
      list.add(lastMessageIcon);
    }
    return list;
  }

  String nameByPhoneNumber(String number, List<Contact> listContact) {
    for (int i = 0; i < listContact.length; i++) {
      if (removeSpaceDashBracket(listContact[i].phones!.first.value) ==
              number ||
          removeSpaceDashBracket(listContact[i].phones!.first.value) ==
              number.substring(3, 13)) {
        return listContact[i].displayName?? number;
      }
    }
    return number;
  }
}
