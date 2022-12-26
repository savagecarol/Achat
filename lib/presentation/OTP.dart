import 'package:anonymous_chat/custom/CustomButton.dart';
import 'package:anonymous_chat/custom/OtpField.dart';
import 'package:anonymous_chat/presentation/Auth.dart';
import 'package:anonymous_chat/presentation/ChatScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class OTP extends StatefulWidget {
  String phoneNumber;
  OTP({super.key, required this.phoneNumber});

  @override
  State<OTP> createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  bool isSmsLoading = false;

  void _goToChatScreen() {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ChatScreen()),
    );
  }

  void _backToAuthPage() {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Auth()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(builder: ((context, child) {
      return Scaffold(
          body: SingleChildScrollView(
              child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 128),
        child: Center(
          child: Column(
            children: [
              Container(
                  height: 100.h,
                  width: 100.w,
                  child: Image.asset("assets/images/dove.png")),
              Container(
                margin: const EdgeInsets.only(top: 48, bottom: 32),
                child: OtpField(otpFunction: (x) {}),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                child: CustomButton(
                    isLoading: isSmsLoading,
                    postIcon: Icons.arrow_forward,
                    visiblepostIcon: true,
                    postIconColor: Colors.white,
                    postIconSize: 18.h,
                    labelText: "VERIFY OTP  ",
                    sizelabelText: 16.h,
                    onTap: () async {
                      _goToChatScreen();
                    },
                    containerColor: Colors.black),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: _backToAuthPage,
                    child: Text('Enter PhoneNumber?',
                        style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        )),
                  ),
                ],
              )
            ],
          ),
        ),
      )));
    }));
  }
}
