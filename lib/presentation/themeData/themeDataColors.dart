import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeDataColors {
  static TextStyle googleAbl({double? fontsize, Color? colors}) {
    return GoogleFonts.abhayaLibre(
      color: colors ?? Colors.orange,
      fontSize: fontsize ?? 28,
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle buttuns({double? fontsize, Color? colors}) {
    return GoogleFonts.abhayaLibre(
      color: colors ?? Colors.white,
      fontSize: fontsize ?? 28,
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle gbowlbyone({double? fontsize, Color? colors}) {
    return GoogleFonts.bowlbyOne(
      letterSpacing: 2,
      color: colors ?? Colors.white,
      fontSize: fontsize ?? 22,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle normalText({double? fontsize, Color? colors}) {
    return TextStyle(
      color: colors ?? Colors.grey,
      fontSize: fontsize ?? 16,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle roboto({double? fontsize, Color? colors}) {
    return GoogleFonts.roboto(
        letterSpacing: 2,
        color: colors ?? Colors.grey,
        fontSize: fontsize ?? 12,
        fontWeight: FontWeight.w500);
  }
}
