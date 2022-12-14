import 'package:anonymous_chat/custom/LastMessageBox.dart';
import 'package:anonymous_chat/models/ExsistContact.dart';
import 'package:anonymous_chat/models/LastMessageIcon.dart';
import 'package:anonymous_chat/presentation/ChatScreen.dart';
import 'package:anonymous_chat/presentation/ContactPage.dart';
import 'package:anonymous_chat/presentation/Profile.dart';
import 'package:anonymous_chat/utils/global.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';

class SplashScreen extends StatefulWidget {
  String pigeonId;
  SplashScreen({super.key, required this.pigeonId});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLoading = true;
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
      exsistContactList = list;
      setState(() => isLoading = false);
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

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(builder: ((context, child) {
      return Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: isLoading
            ? Container()
            : FloatingActionButton(
                backgroundColor: Colors.black,
                child: const Icon(Icons.message),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ContactPage()),
                  );
                },
              ),
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          title: _appBarWidget(),
        ),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              )
            : Column(
                children: [const SizedBox(height: 16), _screen1()],
              ),
      );
    }));
  }

  Widget _appBarWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
                height: 42.h,
                width: 42.w,
                margin: const EdgeInsets.only(right: 8),
                child: Image.asset("assets/images/dove.png")),
            Text("Pigeon",
                style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold))),
          ],
        ),
        InkWell(
          onTap: (() {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Profile()),
            );
          }),
          child: const Icon(
            Icons.account_circle_sharp,
            color: Colors.black,
            size: 36,
          ),
        )
      ],
    );
  }

  _streamBuilderWidget() {
    return Expanded(
      child: StreamBuilder(
        stream: pigeonService.getStream(widget.pigeonId),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            List<LastMessageIcon> listDocument =
                pigeonService.getListOfLastMessage(
                    snapshot.data.docs, widget.pigeonId, exsistContactList);
            if (listDocument.isEmpty) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 128),
                    Container(
                        height: 200.h,
                        child: SvgPicture.asset("assets/images/no_data.svg")),
                    const SizedBox(
                      height: 32,
                    ),
                    Text("Send your first secret message",
                        style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.w600)))
                  ],
                ),
              );
            } else {
              return ListView.builder(
                  itemCount: listDocument.length,
                  itemBuilder: (context, i) {
                    return GestureDetector(
                      onTap: () async {
                        if (await blockService.getBlockCombination(widget.pigeonId , listDocument[i]
                                      .lastMessage
                                      .receiverPigeonId.toString())) {
                          showToast("Blocked!!");
                        }
                        else
                        {
                             Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatScreen(
                                  displayName:
                                      listDocument[i].lastMessage.displayName,
                                  phoneNumber:
                                      listDocument[i].lastMessage.receiver,
                                  pigeonId: listDocument[i]
                                      .lastMessage
                                      .receiverPigeonId,
                                  userPigeonId: int.parse(widget.pigeonId)),
                            ));
                        }


                      },
                      child: LastMessageBox(lastMessageIcon: listDocument[i]),
                    );
                  });
            }
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 128),
                Container(
                    height: 200.h,
                    child: SvgPicture.asset("assets/images/no_data.svg")),
                const SizedBox(
                  height: 32,
                ),
                Text("Permission Denied",
                    style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w600)))
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _screen1() {
    return _streamBuilderWidget();
  }
}
