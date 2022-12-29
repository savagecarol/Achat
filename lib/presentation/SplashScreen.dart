import 'dart:ffi';

import 'package:anonymous_chat/custom/LastMessageBox.dart';
import 'package:anonymous_chat/models/LastMessage.dart';
import 'package:anonymous_chat/presentation/ChatScreen.dart';
import 'package:anonymous_chat/presentation/ContactPage.dart';
import 'package:anonymous_chat/presentation/Profile.dart';
import 'package:anonymous_chat/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _splash = true;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(builder: ((context, child) {
      return Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          child: const Icon(Icons.message),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ContactPage()),
            );
          },
        ),
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          title: _appBarWidget(),
        ),
        body: Column(
          children: [
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     GestureDetector(
            //       onTap: () {
            //         setState(() {
            //           _splash = true;
            //         });
            //       },
            //       child: Container(
            //         margin: const EdgeInsets.only(right: 16),
            //         padding: const EdgeInsets.all(8),
            //         decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(5),
            //             color: randomcolor(),
            //             boxShadow: const [
            //               BoxShadow(
            //                   color: Colors.grey,
            //                   blurRadius: 2,
            //                   offset: Offset(2, 2))
            //             ]),
            //         child: Text("Chatters",
            //             style: GoogleFonts.montserrat(
            //                 textStyle: const TextStyle(
            //                     fontSize: 18,
            //                     color: Colors.white,
            //                     fontWeight: FontWeight.bold))),
            //       ),
            //     ),
            //     GestureDetector(
            //       onTap: () {
            //         setState(() {
            //           _splash = false;
            //         });
            //       },
            //       child: Container(
            //         margin: const EdgeInsets.only(left: 16),
            //         padding: const EdgeInsets.all(8),
            //         decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(5),
            //             color: randomcolor(),
            //             boxShadow: const [
            //               BoxShadow(
            //                   color: Colors.grey,
            //                   blurRadius: 2,
            //                   offset: Offset(2, 2))
            //             ]),
            //         child: Text("Pigenoary",
            //             style: GoogleFonts.montserrat(
            //                 textStyle: const TextStyle(
            //                     fontSize: 18,
            //                     color: Colors.white,
            //                     fontWeight: FontWeight.bold))),
            //       ),
            //     ),
            //   ],
            // ),
            const SizedBox(height: 16),
            _screen1() 
          ],
        ),
      );
    }));
  }

  Widget _screen1() {
      return Expanded(
        child: ListView.builder(
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                 onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChatScreen(displayName :"Kartikeya Sharma")),
                      );
                },
                child: LastMessageBox(
                  isIcon: index %2 == 0,
                    lastMessage: LastMessage(
                        displayName: "Kartikeya Sharma",
                        lastMessage: "My name is kartikeya sharna",
                        timeStamp: DateTime.now())),
              );
            }));
  }

  // Widget _screen2() {
  //   return Expanded(
  //       child: ListView.builder(
  //           itemCount: 10,
  //           itemBuilder: (BuildContext context, int index) {
  //             return GestureDetector(
  //               onTap: (){
  //                   Navigator.push(
  //                       context,
  //                       MaterialPageRoute(
  //                           builder: (context) => ChatScreen(displayName :"#1234566")),
  //                     );
  //               },
  //               child: LastMessageBox(
  //                 isIcon: false,
  //                   lastMessage: LastMessage(
  //                       displayName: "#1234566",
  //                       lastMessage: "My name is kartikeya sharma dnfjsf knsdkfbsdkf dg ndkf sdnsjkdf lsdinlfnsidl,",
  //                       timeStamp: DateTime.now())),
  //             );
  //           }));
  // }

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
          child:const  Icon(Icons.account_circle_sharp , color: Colors.black,size: 36 ,),
        )     
      ],
    );
  }
}
