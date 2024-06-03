import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homease/core/config/design/typography.dart';

class Header1 extends StatelessWidget {
  String txt;
  int maxline;
  Color? clr;

  Header1({required this.txt, this.maxline = 1, this.clr});

  @override
  Widget build(BuildContext context) {
    // Get the current theme mode using GetX

    // Define the text color based on the theme mode

    // Define the font size based on the typography
    double fontSize = KbcodeTypography.sizeXL;

    return Text(
      txt.tr,
      style: GoogleFonts.poppins(
        color: clr,
        fontSize: fontSize,
        fontWeight: FontWeight.w500,
      ),
      maxLines: maxline,
      overflow: TextOverflow.ellipsis,
    );
  }
}

class Header2 extends StatelessWidget {
  String txt;
  int maxline;
  Color? clr;

  Header2({required this.txt, this.maxline = 1, this.clr});

  @override
  Widget build(BuildContext context) {
    // Get the current theme mode using GetX

    // Define the text color based on the theme mode

    // Define the font size based on the typography
    double fontSize = KbcodeTypography.sizeL;

    return Text(
      txt.tr,
      style: GoogleFonts.poppins(
        color: clr,
        fontSize: fontSize,
        fontWeight: FontWeight.w500,
      ),
      maxLines: maxline,
      overflow: TextOverflow.ellipsis,
    );
  }
}

class Header3 extends StatelessWidget {
  String txt;
  int maxline;
  Color? clr;
  Header3({required this.txt, this.maxline = 1, this.clr});

  @override
  Widget build(BuildContext context) {
    // Get the current theme mode using GetX

    // Define the text color based on the theme mode

    // Define the font size based on the typography
    double fontSize = KbcodeTypography.sizeM;

    return Text(
      txt.tr,
      style: GoogleFonts.poppins(
        color: clr,
        fontSize: fontSize,
        fontWeight: FontWeight.w500,
      ),
      maxLines: maxline,
      overflow: TextOverflow.ellipsis,
    );
  }
}

class Header4 extends StatelessWidget {
  String txt;
  int maxline;
  Color? clr;
  Header4({required this.txt, this.maxline = 1, this.clr});

  @override
  Widget build(BuildContext context) {
    // Get the current theme mode using GetX

    // Define the text color based on the theme mode

    double fontSize = KbcodeTypography.sizeS;

    return Text(
      txt.tr,
      style: GoogleFonts.poppins(
        color: clr,
        fontSize: fontSize,
        fontWeight: FontWeight.w500,
      ),
      maxLines: maxline,
      overflow: TextOverflow.ellipsis,
    );
  }
}

class Paragraph extends StatelessWidget {
  String txt;
  Color? clr;
  Paragraph({required this.txt, this.clr});

  @override
  Widget build(BuildContext context) {
    // Get the current theme mode using GetX

    // Define the text color based on the theme mode

    double fontSize = KbcodeTypography.sizeS;

    return Text(
      txt.tr,
      style: GoogleFonts.poppins(
        color: clr,
        fontSize: fontSize,
      ),
    );
  }
}
