import 'package:anonymous_chat/custom/CustomTextField.dart';
import 'package:anonymous_chat/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatScreen extends StatefulWidget {
  String displayName;
   ChatScreen({super.key , required  this.displayName});

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
            title: Text( widget.displayName,
                style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold))),
          ),
          body: Container(
            padding:
                const EdgeInsets.only(top: 32, bottom: 16, right: 16, left: 16),
            child: Column(
              children: [
                Expanded(child: Container()),
                Container(
                  padding: const EdgeInsets.all(8),
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
                            Icons.send,
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
          ));
    }));
  }
}
