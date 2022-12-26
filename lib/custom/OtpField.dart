import 'package:anonymous_chat/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class OtpField extends StatelessWidget {
  Function(String) otpFunction = (x){};
  OtpField({super.key, required otpFunction});

  @override
  Widget build(BuildContext context) {
    TextStyle? createTextStyle(Color color) {
      ThemeData theme = Theme.of(context);
      return theme.textTheme.headlineSmall?.copyWith(color: color);
    }

    List<TextStyle?> otpTextStyles = [
      createTextStyle(accentPurpleColor),
      createTextStyle(accentYellowColor),
      createTextStyle(accentDarkGreenColor),
      createTextStyle(accentOrangeColor),
      createTextStyle(accentPinkColor),
      createTextStyle(accentPurpleColor),
    ];
    return OtpTextField(
      numberOfFields: 6,
      borderColor: accentPurpleColor,
      focusedBorderColor: accentPurpleColor,
      styles: otpTextStyles,
      showFieldAsBox: false,
      borderWidth: 4.0,
      keyboardType: TextInputType.number,
      onSubmit: (String verificationCode) {
        otpFunction(verificationCode);
      },
    );
  }
}
