import 'package:anonymous_chat/custom/CustomButton.dart';
import 'package:anonymous_chat/presentation/Auth.dart';
import 'package:anonymous_chat/presentation/SplashScreen.dart';
import 'package:anonymous_chat/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class OTP extends StatefulWidget {
  String verifId;
  OTP({super.key, required this.verifId});

  @override
  State<OTP> createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  bool isSmsLoading = false;
  String otp = "";

  void _goToChatScreen() async {
    if (await authService.verify(widget.verifId, otp)) {
      if (await preferenceService.getUID() != "") {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SplashScreen()),
        );
      }
      else {
        showToast("!!oops Something Went Wrong");
      }
    }
    else {
      showToast("!!oops Please type correct Otp");
    }
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
    TextStyle? createTextStyle(Color color) {
      ThemeData theme = Theme.of(context);
      return theme.textTheme.headlineSmall?.copyWith(color: color);
    }

    List<TextStyle?> otpTextStyles = [
      createTextStyle(accentPurpleColor),
      createTextStyle(accentYellowColor),
      createTextStyle(accentDarkGreenColor),
      createTextStyle(accentOrangeColor),
      createTextStyle(accentPinkColor),
      createTextStyle(accentPurpleColor),
    ];

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
                  child: OtpTextField(
                    numberOfFields: 6,
                    borderColor: accentPurpleColor,
                    focusedBorderColor: accentPurpleColor,
                    styles: otpTextStyles,
                    showFieldAsBox: false,
                    borderWidth: 4.0,
                    keyboardType: TextInputType.number,
                    onSubmit: (String verificationCode) {
                      otp = verificationCode;
                      print(otp);
                    },
                    onCodeChanged: (String verificationCode) {
                      otp = verificationCode;
                      print(otp);
                    },
                  )),
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
                    onTap: _goToChatScreen,
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
