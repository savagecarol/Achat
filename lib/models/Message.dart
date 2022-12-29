class Message {
  String sender;
  String receiver;
  String senderPigeonId;
  String receiverPigeonId;
  DateTime time = DateTime.now();
  String message;
  bool isSeen;
  Message({
      required this.sender,
      required this.receiver,
      required this.message , 
      required this.senderPigeonId,
      required this.receiverPigeonId,
      this.isSeen = false
      }
      );
}
