class LastMessage {
  String displayName;
  String lastMessage;
  DateTime timeStamp;
  DateTime? seenTime;

  LastMessage(
      {required this.displayName,
      required this.lastMessage,
      required this.timeStamp});
}
