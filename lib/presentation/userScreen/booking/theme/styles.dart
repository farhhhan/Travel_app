// booking_styles.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BookingStyles {
  static TextStyle get appBarSubtitleStyle => TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: Colors.white,
      );

  static TextStyle get appBarTitleStyle => TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      );
  static TextStyle getTitleTextStyle([Color? color]) {
    return GoogleFonts.aBeeZee(
      fontSize: 18,
      color:color?? Colors.black,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle getSubtitleTextStyle() {
    return GoogleFonts.aBeeZee(
      fontSize: 14,
      color: Colors.grey,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle getTravellerNameTextStyle() {
    return GoogleFonts.aBeeZee(
      color: Colors.black,
      fontSize: 16,
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle getTravellerInfoTextStyle() {
    return GoogleFonts.aBeeZee(
      color: Colors.black,
      fontSize: 14,
      fontWeight: FontWeight.w200,
    );
  }

  static BoxDecoration getCardDecoration(BuildContext context) {
    return BoxDecoration(
      color: Theme.of(context).primaryColor,
    );
  }

  static TextStyle getTotalAmountTextStyle() {
    return TextStyle(
      letterSpacing: 2,
      color: Colors.white,
      fontSize: 26,
      fontWeight: FontWeight.w800,
    );
  }

  static TextStyle getTotalAmountSubtitleTextStyle() {
    return TextStyle(
      letterSpacing: 2,
      color: Colors.grey,
      fontSize: 12,
      fontWeight: FontWeight.w800,
    );
  }
}
