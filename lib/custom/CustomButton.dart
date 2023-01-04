import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  final IconData postIcon;
  final bool visiblepostIcon;
  final String labelText;
  final FontWeight labelTextWeight;
  final double sizelabelText;
  final Function onTap;
  final double postIconSize;
  final Color postIconColor;
  final Color containerColor;
  final bool isLoading;

  const CustomButton(
      {required this.postIcon,
      required this.labelText,
      this.visiblepostIcon = false,
      this.sizelabelText = 20,
      this.labelTextWeight = FontWeight.w500,
      required this.onTap,
      this.isLoading = false,
      this.postIconSize = 24,
      this.postIconColor = Colors.black,
      this.containerColor = Colors.greenAccent});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: containerColor,
            boxShadow: const [
              BoxShadow(
                  color: Colors.grey, blurRadius: 10, offset: Offset(2, 4))
            ]),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Center(
            child: (isLoading == false)
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(labelText,
                          style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(fontSize: 16, color: Colors.white , fontWeight: FontWeight.w600))),
                      Container(
                        child: (visiblepostIcon)
                            ? Icon(
                                postIcon,
                                size: postIconSize,
                                color: postIconColor,
                              )
                            : Container(),
                      ),
                    ],
                  )
                : const SizedBox(
                    height: 18.0,
                    width: 18,
                    child: CircularProgressIndicator(color: Colors.white),
                  ),
          ),
        ),
      ),
    );
  }
}