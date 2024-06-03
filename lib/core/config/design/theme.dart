import 'package:flutter/material.dart';

//  ..................................................
//  .██████╗.██████╗.██╗......██████╗.██████╗.███████╗
//  ██╔════╝██╔═══██╗██║.....██╔═══██╗██╔══██╗██╔════╝
//  ██║.....██║...██║██║.....██║...██║██████╔╝███████╗
//  ██║.....██║...██║██║.....██║...██║██╔══██╗╚════██║
//  ╚██████╗╚██████╔╝███████╗╚██████╔╝██║..██║███████║
//  .╚═════╝.╚═════╝.╚══════╝.╚═════╝.╚═╝..╚═╝╚══════╝
//  ..................................................
class AppTheme {
  // use for button and bakground
  static const Color primaryColor = Color(0xff20A090);
  static const Color secondColor = Color(0xffD9D9D9);
  // the green color used in logo and check icons etc
  static const Color secondaryColor = Color(0xff252A32);
  // Color of the filled on the textField and the border
  static const Color textFieledFillColor = Color(0xffF5F5F5);
  static const Color textFieledBorderColor = Color(0xff20A090);
  static const Color circleAvatarBGColor = Color(0xffA0D675);
  static const Color backgroundColor = Color(0xff0C0F14);
  static const Color backgroundColorLight = Color(0xffFAF2EE);
  static const Color greyButton = Color(0xffE5E7EB);
  static const Color darkGrey = Color(0xff6C6C6C);
  static const Color white = Color(0xffF5F5F5);
  static const Color black = Color(0xff0C0F14);

  static const Color secondaryGreyTextColor = Color(0xff9D9D9D);

//Build the material Swatch
  static MaterialColor buildMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map<int, Color> swatch = {};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }
}
