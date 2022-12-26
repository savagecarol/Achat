import 'package:anonymous_chat/custom/CustomTextField.dart';
import 'package:anonymous_chat/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String message = "";
  @override
  Widget build(BuildContext context) {
     return ScreenUtilInit(builder: ((context, child) {
      return Scaffold(
        body: Column(
        children: <Widget>[ 
         Container(
              padding: EdgeInsets.only(left: 10,bottom: 10,top: 10 , right: 10),
              width: double.infinity,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child:  CustomTextField(
                      hintText: "Write Message ...", 
                      hintTextSize: 16,
                      initialValue: '',
                      onChanged: (value) {
                        message = value!;
                      },
                      maxLine: MAX_INT,
                      onSaved: () {},
                      validator: () {}),
                ),
                  Container(
                    margin: const EdgeInsets.only( left: 8),
                    height: 42.h,
                    child: FloatingActionButton(
                      onPressed: (){},
                      child: Icon(Icons.send,color: Colors.white,size: 18.h,),
                      backgroundColor: Colors.black,
                      elevation: 0,

                    ),
                  ),
                ],      
              ),
            ),
        ],
      )
      );
    }));
  }
}


