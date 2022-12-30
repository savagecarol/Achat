import 'dart:collection';
import 'dart:convert';

import 'package:anonymous_chat/models/ExsistContact.dart';
import 'package:anonymous_chat/utils/global.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_service/contacts_service.dart';

class ContactService {
  ContactService._();
  factory ContactService.getInstance() => _instance;
  static final ContactService _instance = ContactService._();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<ExsistContact>> getAllActiveUserByContactList(
      List<Contact> listContact) async {
    List<ExsistContact> exsistContactList = [];
    HashSet<String> available = HashSet();
    HashSet<String> x = HashSet();

    for (int i = 0; i < listContact.length; i++) {
      x.add(checkStartPhoneNumber(
          removeSpaceDashBracket(listContact[i].phones!.first.value)));
    }

    var collection = _firestore.collection('APPUSER');
    var querySnapshot = await collection.get();
    for (var doc in querySnapshot.docs) {
      Map<String, dynamic> data = doc.data();

      if (x.contains(data['phoneNumber'])) {
         if(data['isActive'] == true) available.add(data['phoneNumber']);
      }

    }

    for (int i = 0; i < listContact.length; i++) {
      ExsistContact r = ExsistContact();
      r.contact = listContact[i];
      if (available.contains(checkStartPhoneNumber(
          removeSpaceDashBracket(listContact[i].phones!.first.value)))) {
        r.isActive = true;
      } else {
        r.isActive = false;
      }
      exsistContactList.add(r);
    }
    return exsistContactList;
  }
}
