import 'package:anonymous_chat/presentation/ContactPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {



  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(builder: ((context, child) {
      return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          child: const Icon(Icons.contacts),
          onPressed: () {
              Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ContactPage()),
            );
          },
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(32),
            child: Column(
              children: [
                  
              ],
            ),
          ),
        ),
      );
    }));
  }
}
