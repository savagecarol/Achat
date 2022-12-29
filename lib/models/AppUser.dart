class AppUser {
  late String uid;
  String phoneNumber;
  String pigeonId;
  DateTime creationTime = DateTime.now();
  String isActive;
  AppUser({
    required this.phoneNumber,
    required this.pigeonId,
    required this.creationTime,
    required this.isActive,
  });
}
