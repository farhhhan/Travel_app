import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class custom_orangeText extends StatelessWidget {
   custom_orangeText({
    super.key,
    required this.contents
  });
  String contents;
  @override
  Widget build(BuildContext context) {
    return Text(
      contents,
      style: GoogleFonts.abhayaLibre(
        color: Colors.orange,
        fontSize: 28,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

class custom_startText extends StatelessWidget {
   custom_startText({
    super.key,
    required this.contents
  });
String contents;
  @override
  Widget build(BuildContext context) {
    return Text(
      contents,
      style: GoogleFonts.abhayaLibre(
        fontSize: 28,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

class custom_commenMsg extends StatelessWidget {
  const custom_commenMsg({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      '''        To get the  best  of adaventure yo just 
   need to leave and go where you like,we are
                                waiting for you''',
      style: GoogleFonts.abhayaLibre(
        fontSize: 16,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
