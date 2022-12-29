import 'package:anonymous_chat/models/LastMessage.dart';
import 'package:anonymous_chat/utils/global.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class LastMessageBox extends StatelessWidget {
  LastMessage lastMessage;
  bool isIcon;
  LastMessageBox({super.key, required this.lastMessage , this.isIcon = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
          border: Border(
            // top: BorderSide(width: 2, color: Colors.grey.shade600),
            bottom: BorderSide(width: 2, color: Colors.grey.shade200),
          ),
        ),  
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  isIcon
                      ? Container(
                          height: 32,
                          width: 32,
                          margin: const EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                              color: randomcolor(), shape: BoxShape.circle),
                          child: Center(
                            child: Text(lastMessage.displayName[0],
                                style: GoogleFonts.montserrat(
                                    textStyle: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold))),
                          ),
                        )
                      : Container(),
                  Text(displayName(lastMessage.displayName),
                      style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w600))),
                ],
              ),
              Text(showTime(lastMessage.timeStamp),
                  style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w600))),
            ],
          ),
          const SizedBox(height: 8,),
          Text(lastMessage.lastMessage,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.montserrat(
                  textStyle: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w400))),
        ],
      ),
    );
  }
}
