class LastMessage {
  String displayName;
  String lastMessage;
  DateTime time;
  DateTime? seenTime;
  int receiverPigeonId;
  String receiver;
  bool? isSeen;

  LastMessage(
      {required this.displayName,
      required this.lastMessage,
      required this.time,
      required this.receiverPigeonId,
      required this.receiver});
}
