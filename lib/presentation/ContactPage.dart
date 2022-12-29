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
  bool _permissionDenied = false;

  @override
  void initState() {
    super.initState();
    _fetchContacts();
  }

  Future<void> _fetchContacts() async {
    PermissionStatus permissionStatus = await _getContactPermission();
    if (permissionStatus == PermissionStatus.granted) {
      final contacts = await ContactsService.getContacts();
      setState(() => _contacts = contacts);
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
    if (_contacts == null) {
      return const Center(
          child: CircularProgressIndicator(color: Colors.black));
    }

    return (_contacts == null)
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
                    for (int i = 0; i < _contacts!.length; i++)
                      _contactWidget(_contacts![i])
                  ],
                )),
          );
  }

  Widget _contactWidget(Contact contact) {
    return InkWell(
      onTap: () async {
        String value = removeSpaceDashBracket(contact.phones!.first.value);
        if (value != "") {
          if (await authService.creatUnverifiedUser(value)) {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ChatScreen(displayName: contact.displayName!)),
            );
          }
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 32,
              width: 32,
              margin: const EdgeInsets.only(right: 8),
              decoration:
                  BoxDecoration(color: randomcolor(), shape: BoxShape.circle),
              child: Center(
                child: Text(contact.displayName![0],
                    style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold))),
              ),
            ),
            Text(displayName(contact.displayName!),
                style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w500))),
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
