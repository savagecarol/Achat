import 'package:anonymous_chat/models/MessageDirection.dart';
import 'package:anonymous_chat/utils/global.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class MessageBox extends StatelessWidget {
  MessageDirection messageDirection;
  MessageBox({super.key, required this.messageDirection});
  @override
  Widget build(BuildContext context) {
    Radius r = Radius.circular(8);
    return 
    (messageDirection.isLeft)? 
    Container(
        margin: const EdgeInsets.only(bottom: 4 , top: 4 , left: 16 , right: 64),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                      borderRadius: BorderRadius.only(bottomRight: r ,
                      topRight: r,
                      topLeft: r,),
                     ),
                  child: Padding(
                 padding: const EdgeInsets.symmetric(vertical: 12 , horizontal: 16),
                    child: Text(messageDirection.message.message,
                        style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w400))),
                  ),
                ),
              ),
               Container(
                margin: const EdgeInsets.only(left: 4),
              child: Text(showTime(messageDirection.message.time),
                        style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.w400))),
            ),
            ],
          ),
        ],
      ),
    ):
    Container(
        margin: const EdgeInsets.only(bottom: 4 , top: 4 , left: 64 , right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
        if(messageDirection.message.isSeen) 
          Container(
            margin: const EdgeInsets.only(right: 4),
            child: const Icon(Icons.check , size: 16, color: Colors.teal)),
          Container(
              margin: const EdgeInsets.only(right: 4),
            child: Text(showTime(messageDirection.message.time),
                      style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.w400))),
          ),
          Flexible(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(.5),
                  borderRadius: BorderRadius.only(bottomLeft: r ,
                  topRight: r,
                  topLeft: r,),
                 ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12 , horizontal: 16),
                child: Text(messageDirection.message.message,
                    style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w400))),
              ),
            ),
          ),
        ],
      ),
    );
  }

}
