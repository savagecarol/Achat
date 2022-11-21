import 'package:anonymous_chat/custom/CustomButton.dart';
import 'package:anonymous_chat/custom/CustomTextField.dart';
import 'package:anonymous_chat/utils/global.dart';
import 'package:flutter/material.dart';


class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  bool _isPageLoading = false;
  String phoneNumber = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isPageLoading ?
      const Center(
        child: CircularProgressIndicator(
        ),
      ):SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                  height: 64,
                ),
              const Text(
                  "Enter Phone Number",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 16),
                  child: CustomTextField(
                    hintText: "",
                    hintTextSize: 16,
                    initialValue: '',
                    onChanged: (value) {
                      phoneNumber = value!;
                    },
                    onSaved: () {},
                    validator: () {},
                    labelText: '+91',
                  ),
                ),
                CustomButton(
                    postIcon: Icons.arrow_forward_ios,
                    visiblepostIcon: false,
                    labelText: "Send Otp",
                    onTap: () {
                      authService.sendSms(phoneNumber: "+91"+phoneNumber);
                    },
                    containerColor: Colors.orange)
            ],
          ),
        ),
      )
    );
  }
}