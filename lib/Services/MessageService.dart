import 'dart:convert';

import 'package:anonymous_chat/models/Message.dart';
import 'package:anonymous_chat/models/MessageDirection.dart';
import 'package:anonymous_chat/utils/global.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageService {
  MessageService._();
  factory MessageService.getInstance() => _instance;
  static final MessageService _instance = MessageService._();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> postMessage(Message message) async {
    try {
      if (message.receiverPigeonId != message.senderPigeonId) {
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
        await _firestore
            .collection('PIGEON')
            .doc(message.receiverPigeonId + message.senderPigeonId)
            .get()
            .then((docSnapshot) async {
          if (docSnapshot.exists) {
            DocumentReference pigeonLastMessageReference = await _firestore
                .collection('PIGEON')
                .doc(message.receiverPigeonId + message.senderPigeonId);
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
          } else {
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
          }
        });
      }

      AssetsAudioPlayer.newPlayer().open(
        Audio("assets/music/tone.mp3"),
        showNotification: true,
      );

      print("sakdaskl");
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

  List<MessageDirection> getSpecificMessage(List<DocumentSnapshot> docList,
      int senderPigeonId, int receiverPigeonId) {
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
      message.time = docList[i].get('time').toDate();

      if ((docList[i].get('senderPigeonId') == senderPigeonId.toString() &&
          docList[i].get('receiverPigeonId') == receiverPigeonId.toString())) {
        messages.add(MessageDirection(message: message, isLeft: false));
      } else if (docList[i].get('senderPigeonId') ==
              receiverPigeonId.toString() &&
          docList[i].get('receiverPigeonId') == senderPigeonId.toString()) {
        messages.add(MessageDirection(message: message, isLeft: true));
      }
    }
    return messages;
  }

  updateMessage(int senderPigeonId, int receiverPigeonId) async {
    var x = await _firestore
        .collection('MESSAGE')
        .where('receiverPigeonId', isEqualTo: senderPigeonId.toString())
        .where('senderPigeonId', isEqualTo: receiverPigeonId.toString())
        .where('isSeen', isEqualTo: false)
        .get();
    var r = x.docs.toList();
    for (int i = 0; i < r.length; i++) {
      DocumentReference documentReference =
          await _firestore.collection('MESSAGE').doc(r[i].id);
      await documentReference
          .update({'isSeen': true, 'seenTime': DateTime.now()});
    }
  }
}
