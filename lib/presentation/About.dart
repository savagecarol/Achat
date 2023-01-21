import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class About extends StatefulWidget {
  const About({super.key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
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
              title: Text("About Us",
                  style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold)))),
          body: _bodyWidget());
    }));
  }

  Widget _bodyWidget() {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 32 , vertical: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Center(
               child: Container(
                                  height: 60.h,
                                  width: 60.w,
                                  child: Image.asset("assets/images/dove.png")),
             ),
              
                      const SizedBox(
                        height: 16,
                      ),

             Text("Pigeon app is created for expressing the feelings to the people to whom you feel very difficult to talk.\n\n"
              "Be a happy part in someones life without letting them know who you are.\n\n"
              "Be a motivation to someone but you feel difficulties to say them as person\n\n"
              "There can be many reasons of downloading pigeon so choose your reason.",
            style: GoogleFonts.montserrat(
                              textStyle: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500))),
                    
                      const SizedBox(
                        height: 16,
                      ),

            Text("TERMS AND CONDITION",
                style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold))),
                      const SizedBox(
                        height: 16,
                      ),
                      Text("1. No use of bad language\n\n"
                       "2. No blackmailing , No threatning , No blackmailing, No humilating anyone\n\n"
                       "3. If someone reported police complaint against anyone.Then in investigation police ask for any information we will provide it",
                        style: GoogleFonts.montserrat(
                              textStyle: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500))),

                         const SizedBox(
                        height: 16,
                      ),
                      Text(
                          "HELP",
                          style: GoogleFonts.montserrat(
                              textStyle: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold))),
                        const SizedBox(
                        height: 16,
                      ),


                       Text("1. If you face any issue kindly sent email to svgcarol@gmail.com \n\n"
                       "2. Please add screenshot of the chat and if our team find it critical we will block that user permanently.",
                        style: GoogleFonts.montserrat(
                              textStyle: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500))),
                                          const SizedBox(
                        height: 32,
                      ),
          ],
        ),
      ),
    );
  }
}
