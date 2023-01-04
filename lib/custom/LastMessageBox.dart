import 'package:anonymous_chat/models/LastMessage.dart';
import 'package:anonymous_chat/models/LastMessageIcon.dart';
import 'package:anonymous_chat/utils/global.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class LastMessageBox extends StatelessWidget {
  LastMessageIcon lastMessageIcon;

  LastMessageBox({super.key, required this.lastMessageIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 2, color: Colors.grey.shade200),
          ),
        ),  
      child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              lastMessageIcon.isIcon
                      ? Container(
                          height: 42,
                          width: 42,
                          margin: const EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                              color: Colors.black, shape: BoxShape.circle),
                          child: Center(
                            child: Text(lastMessageIcon.lastMessage.displayName[0],
                                style: GoogleFonts.montserrat(
                                    textStyle: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold))),
                          ),
                        )
                      : Container()
              ,
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      child: Text(displayName(lastMessageIcon.lastMessage.displayName),
                          style: GoogleFonts.montserrat(
                              textStyle: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600))),
                    ),
              
                                      const SizedBox(height: 4,),
                  Text(lastMessageIcon.lastMessage.lastMessage,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w400))),
                  ],
                ),
              ),
                   Column(
                     children: [
                       Text(showTime(lastMessageIcon.lastMessage.time),
                  style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w600))),
                      
                    Container(height: 24,)
                     ],
                   ),
            ],
          ),
    );
  }
}
