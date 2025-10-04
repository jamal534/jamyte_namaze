import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class CustomTextInter extends StatelessWidget {
  final String text;
  final Color? color;
  final double? size;
  final TextAlign? textAlign;
  final FontWeight? fontWeight;
  final int? max;
  final TextOverflow? textOverflow;
  final FontStyle? isItalic;

  const CustomTextInter({
    super.key,
    required this.text,
    this.color,
    this.size,
    this.textAlign,
    this.fontWeight,
    this.max,
    this.textOverflow,
    this.isItalic,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: textOverflow,
      maxLines: max,
      textAlign: textAlign,
      style: GoogleFonts.inter(
        color: color,
        fontSize: size,
        fontWeight: fontWeight,
        decoration: TextDecoration.none,
        fontStyle: isItalic ?? FontStyle.normal,
      ),
    );
  }
}
