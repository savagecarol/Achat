import 'package:anonymous_chat/models/Message.dart';
import 'package:anonymous_chat/utils/global.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageService {
  MessageService._();
  factory MessageService.getInstance() => _instance;
  static final MessageService _instance = MessageService._();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> postMessage(Message message) async {
    try {
      DocumentReference documentReference =
          await _firestore.collection('MESSAGE').doc();
      await documentReference.set({
        'sender': message.sender,
        'receiver': message.receiver,
        'senderPigeonId': message.senderPigeonId,
        'receiverPigeonId': message.receiverPigeonId,
        'message': message.message,
        'isSeen': message.isSeen,
        'time': message.time,
        'seenTime' : message.seenTime
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  Stream<dynamic> getStream() {
    return _firestore.collection('MESSAGE').orderBy('time').snapshots();
  }

  List<Message> getSpecificMessage(
      List<DocumentSnapshot> docList, int sender, int receiver) {
    List<Message> messages = [];

    print(sender);
    print(receiver);

    for (int i = 0; i < docList.length; i++) {
      // if ((docList[i].get('senderPigeonId') == sender &&
      //         docList[i].get('receiverPigeonId') == receiver) ||
      //     (docList[i].get('senderPigeonId') == receiver &&
      //         docList[i].get('receiverPigeonId') == sender)) {
      print("asa");
      Message message = Message(
        sender: docList[i].get('sender').toString(),
        senderPigeonId: docList[i].get('senderPigeonId').toString(),
        receiver: docList[i].get('receiver').toString(),
        receiverPigeonId: docList[i].get('receiverPigeonId').toString(),
        isSeen: docList[i].get('isSeen'),
        message: docList[i].get('message'),
      );
      message.time == docList[i].get('time');
      message.seenTime == docList[i].get('seenTime');
      messages.add(message);
    }

    print(messages);
    return messages;
  }
}
