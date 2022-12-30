import 'package:anonymous_chat/custom/CustomTextField.dart';
import 'package:anonymous_chat/models/Message.dart';
import 'package:anonymous_chat/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatScreen extends StatefulWidget {
  String displayName;
  String phoneNumber;
  int pigeonId;
  ChatScreen(
      {super.key,
      required this.displayName,
      required this.phoneNumber,
      required this.pigeonId});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String message = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          Expanded(child: Container()),
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

    if (!await messageService.postMessage(postMessage)) {
      showToast("!oops something went wrong");
    }
    setState(() {
      isMessageLoading = false;
    });
    
    Navigator.pop(context);
     Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ChatScreen(displayName: widget.displayName,
       phoneNumber: widget.phoneNumber, 
       pigeonId: widget.pigeonId)),
    );
    
  }
}
