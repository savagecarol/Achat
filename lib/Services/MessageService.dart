import 'package:anonymous_chat/models/Message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageService {
  MessageService._();
  factory MessageService.getInstance() => _instance;
  static final MessageService _instance = MessageService._();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> postMessage(Message message) async {
    try
    {
      DocumentReference documentReference = await _firestore.collection('MESSAGE')
      .doc();
      await documentReference.set
      ({
           'sender' :  message.sender , 
            'receiver' : message.receiver,
            'senderPigeonId' :  message.senderPigeonId,
            'receiverPigeonId':  message.receiverPigeonId,
            'message' : message.message,
            'isSeen' : message.isSeen,
            'time' : message.time
      }
      );
      return true;
      }
    catch (e) {
      return false;
    }
  }

}

