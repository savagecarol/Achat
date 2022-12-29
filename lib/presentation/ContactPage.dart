import 'package:anonymous_chat/presentation/ChatScreen.dart';
import 'package:anonymous_chat/utils/global.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:google_fonts/google_fonts.dart';

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

  Future _fetchContacts() async {
    if (!await FlutterContacts.requestPermission(readonly: true)) {
      setState(() => _permissionDenied = true);
    } else {
      final contacts = await FlutterContacts.getContacts();
      setState(() => _contacts = contacts);
    }
  }

  Widget _body() {
    if (_permissionDenied) {
      return const Center(child: Text('Permission denied'));
    }
    if (_contacts == null) {
      return const Center(child: CircularProgressIndicator(color: Colors.black));
    }
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child : Column(
          children: [
            for(int i = 0 ; i < _contacts!.length; i++) _contactWidget(_contacts![i])
          ],
        )));
        }
          

Widget _contactWidget(Contact contact)
{
    return  Container(
                  padding: const EdgeInsets.symmetric(vertical: 8 , horizontal: 8),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChatScreen(displayName : contact.displayName )),
                      );
                    },
                    child: Row(
                      children: [
                         Container(
                   height: 32,
                   width: 32,
                   margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
            color: randomcolor(),
            shape: BoxShape.circle
          ),
                child: Center(
                  child: Text(contact.displayName[0],
                      style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold))),
                ),
              ),        
                        Text(displayName(contact.displayName),
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
