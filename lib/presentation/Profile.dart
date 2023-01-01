import 'package:anonymous_chat/custom/CustomButton.dart';
import 'package:anonymous_chat/presentation/About.dart';
import 'package:anonymous_chat/presentation/Auth.dart';
import 'package:anonymous_chat/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:typed_data';
class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool isLogout = false;
  bool isPageLoading = true;
  String phoneNumber = "";

  @override
  void initState() {
    super.initState();
    _isPageLoading();
  }

  _isPageLoading() async 
  {
    phoneNumber = await preferenceService.getPhone();
    setState(() {
      isPageLoading = false;
    });
  }

  _goToAuthScreen() async {
    setState(() {
      isLogout = true;
    });
    await authService.logout();

    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Auth()),
    );

    setState(() {
      isLogout = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(builder: ((context, child) {
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
              title: Text("PROFILE",
                  style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold)))),
          body: isPageLoading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                )
              : SingleChildScrollView(
                  child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 32),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(phoneNumber,
                                style: GoogleFonts.montserrat(
                                    textStyle: const TextStyle(
                                        fontSize: 24,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold))),
                            const SizedBox(
                              height: 32,
                            ),
                            _barWidget(Icons.notes, "About Us",
                                Icons.arrow_forward, () {
                                      Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const About()),
    );

                                }),
                            const SizedBox(
                              height: 16,
                            ),
                            _barWidget(Icons.share, "Invite A Friend",
                                Icons.arrow_forward, () async {
                              Share.share( "https://play.google.com/store/apps/details?id=com.savagecarol.multiply2");
                            }),
                            const SizedBox(
                              height: 16,
                            ),
                            _barWidget(Icons.rate_review, "Rate Us",
                                Icons.arrow_forward, () async {
                              String url =
                                  "https://play.google.com/store/apps/details?id=com.savagecarol.multiply2";
                              if (!await launchUrl(Uri.parse(url))) {
                                showToast("!!oops not able to reach link");
                              }
                            }),
                            const SizedBox(
                              height: 64,
                            ),
                            CustomButton(
                                isLoading: isLogout,
                                postIcon: Icons.arrow_forward,
                                visiblepostIcon: true,
                                postIconColor: Colors.white,
                                postIconSize: 18.h,
                                labelText: "LOG OUT  ",
                                sizelabelText: 16.h,
                                onTap: _goToAuthScreen,
                                containerColor: Colors.black),
                          ]))));
    }));
  }

  Widget _barWidget(
      IconData icon, String text, IconData postIcon, Function action) {
    return InkWell(
        onTap: () {
          action();
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            border: Border(
              // top: BorderSide(width: 2, color: Colors.grey.shade600),
              bottom: BorderSide(width: 2, color: Colors.grey.shade200),
            ),
          ),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    margin: const EdgeInsets.only(right: 8),
                    child: Icon(
                      icon,
                      color: Colors.grey.shade700,
                      size: 28,
                    )),
                Text(text,
                    style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w700)))
              ],
            ),
            Icon(
              postIcon,
              color: Colors.grey.shade700,
              size: 28,
            ),
          ]),
        ));
  }
}
