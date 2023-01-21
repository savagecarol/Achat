import 'package:anonymous_chat/custom/CustomButton.dart';
import 'package:anonymous_chat/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class BlockScreen extends StatefulWidget {
  String displayName;
  String userPigeonId;
  String blockPigeonId;
  BlockScreen({super.key,
   required this.displayName,
   required this.userPigeonId,
   required this.blockPigeonId});

  @override
  State<BlockScreen> createState() => _BlockScreenState();
}

class _BlockScreenState extends State<BlockScreen> {
  bool isBlockLoading = false;
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
              title: Text("BLOCK",
                  style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold)))),
          body: SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(displayName(widget.displayName),
                          style: GoogleFonts.montserrat(
                              textStyle: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold))),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                          "1. If, you block ${displayName(widget.displayName)} then you can never unblock it.",
                          style: GoogleFonts.montserrat(
                              textStyle: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500))),
                        const SizedBox(
                        height: 16,
                      ),
                      Text(
                          "2. If, ${displayName(widget.displayName)} is bothering, blackmailing, humilating you.In that situation you can visit our help section on About us page.",
                          style: GoogleFonts.montserrat(
                              textStyle: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500))),
                      const SizedBox(
                        height: 32,
                      ),
                      CustomButton(
                          isLoading: isBlockLoading,
                          postIcon: Icons.arrow_forward,
                          visiblepostIcon: true,
                          postIconColor: Colors.white,
                          postIconSize: 18.h,
                          labelText: "BLOCK USER  ",
                          sizelabelText: 16.h,
                          onTap: () async {
                            setState(() {
                              isBlockLoading = true;
                            });
                            await blockService.blockUser(widget.userPigeonId, widget.blockPigeonId);
                            Navigator.pop(context);
                            Navigator.pop(context);
                            setState(() {
                              isBlockLoading = false;
                            });
                          },
                          containerColor: Colors.black)
                    ],
                  ))));
    }));
  }
}
