import 'package:anonymous_chat/models/Message.dart';
import 'package:anonymous_chat/models/MessageDirection.dart';
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
        'seenTime': message.seenTime
      });

      DocumentReference pigeonLastMessageReference = await _firestore
          .collection('PIGEON')
          .doc(message.senderPigeonId + message.receiverPigeonId);
      await pigeonLastMessageReference.set({
        'sender': message.sender,
        'receiver': message.receiver,
        'senderPigeonId': message.senderPigeonId,
        'receiverPigeonId': message.receiverPigeonId,
        'message': message.message,
        'isSeen': message.isSeen,
        'time': message.time,
        'seenTime': message.seenTime
      });

      return true;
    } catch (e) {
      return false;
    }
  }

  Stream<dynamic> getStream() {
    return _firestore
        .collection('MESSAGE')
        .orderBy('time', descending: true)
        .snapshots();
  }

  List<MessageDirection> getSpecificMessage(
      List<DocumentSnapshot> docList, int sender, int receiver) {
    print(sender);
    print(receiver);
    List<MessageDirection> messages = [];
    for (int i = 0; i < docList.length; i++) {
      Message message = Message(
        sender: docList[i].get('sender').toString(),
        senderPigeonId: docList[i].get('senderPigeonId').toString(),
        receiver: docList[i].get('receiver').toString(),
        receiverPigeonId: docList[i].get('receiverPigeonId').toString(),
        isSeen: docList[i].get('isSeen'),
        message: docList[i].get('message'),
      );

      if ((docList[i].get('senderPigeonId') == sender.toString() &&
          docList[i].get('receiverPigeonId') == receiver.toString())) {
        messages.add(MessageDirection(message: message, isLeft: false));
      } else if (docList[i].get('senderPigeonId') == receiver.toString() &&
          docList[i].get('receiverPigeonId') == sender.toString()) {
        messages.add(MessageDirection(message: message, isLeft: true));
      }
    }
    return messages;
  }
}
