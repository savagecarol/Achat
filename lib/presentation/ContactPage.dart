import 'package:anonymous_chat/presentation/ChatScreen.dart';
import 'package:anonymous_chat/utils/global.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
      return const Center(child: CircularProgressIndicator());
    }
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.only(right: 32, left: 32),
        child : Column(
          children: [
            for(int i = 0 ; i < _contacts!.length; i++) _contactWidget(_contacts![i])
          ],
        )));
        }
          

Widget _contactWidget(Contact contact)
{
    return  Container(
                  padding: const EdgeInsets.only(right: 8 ,top: 16 , bottom: 16),
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.grey,
                            blurRadius: 5,
                            offset: Offset(2, 2))
                      ]),
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              height: 32,
                              child: FloatingActionButton(onPressed: () {} , 
                              backgroundColor: randomcolor(),
                              child: Text(contact.displayName[0],
                                  style: GoogleFonts.montserrat(
                                      textStyle: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold))),
                              ),
                            ),
                            
                            Container(
                              width: 220,
                              child: Text(contact.displayName,    
                                  style: GoogleFonts.montserrat(
                                      textStyle: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500))),
                            ),
                          ],
                        ),
                        const Icon(Icons.arrow_forward)
                      ],
                    ),
                  ),
                );
}




  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
