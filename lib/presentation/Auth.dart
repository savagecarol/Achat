import 'package:anonymous_chat/custom/CustomButton.dart';
import 'package:anonymous_chat/custom/CustomTextField.dart';
import 'package:anonymous_chat/presentation/OTP.dart';
import 'package:anonymous_chat/presentation/SplashScreen.dart';
import 'package:anonymous_chat/utils/global.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  bool isPageLoading = true;
  String phoneNumber = "";
  bool isSmsLoading = false;
  late String verifId;

  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  _checkAuth() async {
    if (await preferenceService.getUID() != "") {
      Navigator.pop(context);
      Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SplashScreen()),
      );
    }
    setState(() {
      isPageLoading = false;
    });
  }

  void _goToOtpScreen() {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => OTP(verifId: verifId)),
    );
  }

  Future<void> phoneAuth() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: "+91$phoneNumber",
      codeSent: (String id, forceResendingToken) {
        verifId = id;
        print("verifId ----> " + verifId);
        _goToOtpScreen();
      },
      codeAutoRetrievalTimeout: (String id) {
        verifId = id;
      },
      timeout: Duration(seconds: 30),
      verificationCompleted: (AuthCredential credential) {
        print("cred-----> ");
        print(credential);
      },
      verificationFailed: (FirebaseAuthException exception) {
        print("exceprion----> ");
        print(exception.message);
        showToast("!oops Not able to send Otp");
      },
    );
  }

  void getOtp() async {
    String? message = phoneRegex(phoneNumber);
    if (message == null) {
      setState(() {
        isSmsLoading = true;
      });
      await phoneAuth();

      setState(() {
        isSmsLoading = false;
      });
    } else {
      showToast(message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(builder: ((context, child) {
      return Scaffold(
          body: isPageLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 128),
                      child: Center(
                        child: Column(
                          children: [
                            Container(
                                height: 100.h,
                                width: 100.w,
                                child: Image.asset("assets/images/dove.png")),
                            SizedBox(
                              height: 64.h,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Chat With Pigeon",
                                    style: GoogleFonts.montserrat(
                                        textStyle: const TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold))),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  child: Row(
                                    children: [
                                      Container(
                                          padding:
                                              const EdgeInsets.only(right: 8),
                                          child: Text("+91 -",
                                              style: GoogleFonts.montserrat(
                                                  textStyle: const TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w600)))),
                                      Flexible(
                                        child: CustomTextField(
                                            textInputType: TextInputType.number,
                                            hintText: "Phone Number",
                                            hintTextSize: 16,
                                            initialValue: '',
                                            onChanged: (value) {
                                              phoneNumber = value!;
                                            },
                                            onSaved: () {},
                                            validator: () {}),
                                      ),
                                    ],
                                  ),
                                ),
                                CustomButton(
                                    isLoading: isSmsLoading,
                                    postIcon: Icons.arrow_forward,
                                    visiblepostIcon: true,
                                    postIconColor: Colors.white,
                                    postIconSize: 18.h,
                                    labelText: "SEND OTP  ",
                                    sizelabelText: 16.h,
                                    onTap: () async {
                                      getOtp();
                                    },
                                    containerColor: Colors.black)
                              ],
                            ),
                          ],
                        ),
                      )),
                ));
    }));
  }
}
