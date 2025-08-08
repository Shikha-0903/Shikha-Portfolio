import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final TextAlign textAlign;

  const CustomText({
    super.key,
    required this.text,
    required this.fontSize,
    this.fontWeight=FontWeight.normal,
    required this.color,
    this.textAlign=TextAlign.center
  });
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: GoogleFonts.poppins(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color
      ),
    );
  }
}
