import 'package:anonymous_chat/custom/CustomTextField.dart';
import 'package:anonymous_chat/custom/MessageBox.dart';
import 'package:anonymous_chat/models/Message.dart';
import 'package:anonymous_chat/models/MessageDirection.dart';
import 'package:anonymous_chat/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatScreen extends StatefulWidget {
  String displayName;
  String phoneNumber;
  int pigeonId;
  int userPigeonId;
  ChatScreen(
      {super.key,
      required this.displayName,
      required this.phoneNumber,
      required this.pigeonId,
      required this.userPigeonId});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String message = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return InkWell(
              child: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onTap: () {
                Navigator.pop(context);
              },
            );
          },
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(displayName(widget.displayName),
                style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold))),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
              child: StreamBuilder(
            stream: messageService.getStream(),
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                List<MessageDirection> listDocument =
                    messageService.getSpecificMessage(snapshot.data.docs,
                        widget.userPigeonId, widget.pigeonId);
                if (listDocument.isEmpty) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 128),
                        Container(
                            height: 200.h,
                            child:
                                SvgPicture.asset("assets/images/no_data.svg")),
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
                      reverse: true,
                      itemCount: listDocument.length,
                      itemBuilder: (context, index) {
                        return MessageBox(messageDirection : listDocument[index]);
                      });
                }
              } else {
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
              }
            }),
          )),
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: CustomTextField(
                      hintText: "Write Message ...",
                      hintTextSize: 16,
                      initialValue: message,
                      onChanged: (value) {
                        message = value!;
                      },
                      maxLine: MAX_INT,
                      onSaved: () {},
                      validator: () {}),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 8),
                  height: 42.h,
                  child: FloatingActionButton(
                    onPressed: _postMessage,
                    backgroundColor: Colors.black,
                    elevation: 0,
                    child: isMessageLoading
                        ? Container(
                            height: 16.h,
                            width: 16.w,
                            child: const CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : Icon(
                            Icons.send_rounded,
                            color: Colors.white,
                            size: 18.h,
                          ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  bool isMessageLoading = false;

  _postMessage() async {
    setState(() {
      isMessageLoading = true;
    });
    String sender = await preferenceService.getPhone();
    String receiver = widget.phoneNumber;
    String senderPigeonId = await preferenceService.getPigeonId();
    String receiverPigeonId = widget.pigeonId.toString();
    Message postMessage = Message(
        sender: sender,
        receiver: receiver,
        message: message,
        senderPigeonId: senderPigeonId,
        receiverPigeonId: receiverPigeonId);
    postMessage.seenTime = postMessage.time;

    if (!await messageService.postMessage(postMessage)) {
      showToast("!oops something went wrong");
    }
    setState(() {
      isMessageLoading = false;
    });

    // ignore: use_build_context_synchronously
    Navigator.pop(context);
    // ignore: use_build_context_synchronously
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ChatScreen(
              displayName: widget.displayName,
              phoneNumber: widget.phoneNumber,
              pigeonId: widget.pigeonId,
              userPigeonId: widget.userPigeonId)),
    );
  }
}
