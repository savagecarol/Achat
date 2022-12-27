import 'package:anonymous_chat/custom/CustomTextField.dart';
import 'package:anonymous_chat/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatScreen extends StatefulWidget {
  String displayName;
  ChatScreen({super.key, required this.displayName});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String message = "";
  @override
  Widget build(BuildContext context) {

    return ScreenUtilInit(builder: ((context, child) {
      return Scaffold(
          appBar: AppBar(
            leading: Builder(
              builder: (BuildContext context) {
                return InkWell(
                  child: const Icon(Icons.arrow_back ,    color: Colors.black,),
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
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: CustomTextField(
                          hintText: "Write Message ...",
                          hintTextSize: 16,
                          initialValue: '',
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
                        onPressed: () {},
                        backgroundColor: Colors.black,
                        elevation: 0,
                        child: Icon(
                          Icons.send_rounded,
                          color: Colors.white,
                          size: 18.h,
                        ),
                      ),
                    ),
                    SizedBox(),
                  ],
                ),
              ),
            ],
          ));
    }));
  }
}
