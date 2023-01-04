import 'package:anonymous_chat/models/AppUser.dart';
import 'package:anonymous_chat/models/ExsistContact.dart';
import 'package:anonymous_chat/presentation/ChatScreen.dart';
import 'package:anonymous_chat/utils/global.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});
  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  List<Contact>? _contacts;
  List<ExsistContact> exsistContactList = [];
  bool _permissionDenied = false;

  @override
  void initState() {
    super.initState();
    _fetchContacts();
  }

  Future<void> _fetchContacts() async {
    PermissionStatus permissionStatus = await _getContactPermission();
    if (permissionStatus == PermissionStatus.granted) {
      var contacts = await ContactsService.getContacts();
      
      var list = await contactService.getAllActiveUserByContactList(contacts);
      setState(() => exsistContactList = list);
    } else {
      _permissionDenied = true;
    }
  }

  Future<PermissionStatus> _getContactPermission() async {
    PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.permanentlyDenied) {
      PermissionStatus permissionStatus = await Permission.contacts.request();
      return permissionStatus;
    } else {
      return permission;
    }
  }

  Widget _body() {
    if (_permissionDenied) {
      return Column(
        children: [
          const SizedBox(height: 128),
          SizedBox(
              height: 256,
              child: SvgPicture.asset("assets/images/no_data.svg")),
          const SizedBox(
            height: 32,
          ),
          Text("Permission Denied",
              style: GoogleFonts.montserrat(
                  textStyle: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w700)))
        ],
      );
    }

    if (exsistContactList.isEmpty) {
      return const Center(
          child: CircularProgressIndicator(color: Colors.black));
    }

    return (exsistContactList.isEmpty)
        ? Column(
            children: [
              const SizedBox(height: 128),
              Container(
                  height: 256,
                  child: SvgPicture.asset("assets/images/no_data.svg")),
              const SizedBox(
                height: 32,
              ),
              Text("No Contact found",
                  style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w700)))
            ],
          )
        : SingleChildScrollView(
            child: Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    for (int i = 0; i < exsistContactList.length; i++)
                      _contactWidget(exsistContactList[i])
                  ],
                )),
          );
  }

  Widget _contactWidget(ExsistContact exsistContact) {
    return InkWell(
      onTap: () async {
        String value = exsistContact.contactNumber.number;
        if (value != "") {
          AppUser a = await authService.creatUnverifiedUser(value);
          int userPigeonId = int.parse(await preferenceService.getPigeonId());

          if (a.pigeonId != null) {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChatScreen(
                      displayName: exsistContact.contactNumber.name,
                      phoneNumber: a.phoneNumber!,
                      pigeonId: a.pigeonId!,
                      userPigeonId: userPigeonId)),
            );
          }
          
        } else {
          showToast("!oops Something Went Wrong");
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 32,
                  width: 32,
                  margin: const EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                      color: randomcolor(), shape: BoxShape.circle),
                  child: Center(
                    child: Text(exsistContact.contactNumber.name[0],
                        style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold))),
                  ),
                ),
                Text(displayName(exsistContact.contactNumber.name ),
                    style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w500))),
              ],
            ),
            exsistContact.isActive
                ? const Icon(
                    Icons.check,
                    color: Colors.green,
                    size: 24,
                  )
                : Container()
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  color: Colors.black,
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                );
              },
            ),
            elevation: 0.0,
            backgroundColor: Colors.white,
            title: Text("CONTACTS",
                style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold)))),
        body: _body());
  }
}
