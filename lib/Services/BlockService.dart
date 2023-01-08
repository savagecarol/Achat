import 'package:cloud_firestore/cloud_firestore.dart';

class BlockService {
  BlockService._();
  factory BlockService.getInstance() => _instance;
  static final BlockService _instance = BlockService._();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  blockUser(String userPigeonId, String blockPigeonId) async {
    await _firestore
        .collection('BLOCKED')
        .doc(userPigeonId + blockPigeonId)
        .set({});
    await _firestore
        .collection('BLOCKED')
        .doc(blockPigeonId + userPigeonId)
        .set({});
  }

  Future<bool> getBlockCombination(String userPigeonId, String blockPigeonId) async {
    return await _firestore.collection('BLOCKED').doc(blockPigeonId + userPigeonId).get().then((value) async {
        if (value.exists) {
            return true;
          }
          return false;
        });
  }
}
