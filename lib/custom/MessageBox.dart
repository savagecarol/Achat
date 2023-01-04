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
    Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Flexible(
          child: Container(
            margin: const EdgeInsets.only(bottom: 4 , top: 4 , left: 16 , right: 64),
            decoration: BoxDecoration(
              color: randomcolor(),
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
                          color: Colors.black,
                          fontWeight: FontWeight.w400))),
            ),
          ),
        ),
      ],
    ):
    
    Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Flexible(
          child: Container(
            margin: const EdgeInsets.only(bottom: 4 , top: 4 , left: 64 , right: 16),
            decoration: BoxDecoration(
              color: randomcolor(),
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
    );
  }
}
