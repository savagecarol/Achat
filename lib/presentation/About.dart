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
          children: [
            Text("Terms and ",
                style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w500))),
          ],
        ),
      ),
    );
  }
}
