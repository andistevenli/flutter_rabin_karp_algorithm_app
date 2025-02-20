import 'package:flutter/material.dart';
import 'package:flutter_rabin_karp_algorithm_app/resources/unit_manager.dart';
import 'package:flutter_rabin_karp_algorithm_app/utils/text_hierarchy.dart';
import 'package:google_fonts/google_fonts.dart';

class MyText extends StatelessWidget {
  final TextHierarchy textHierarchy;
  final String text;
  final Color color;
  final TextAlign textAlign;
  final FontWeight fontWeight;

  const MyText({
    super.key,
    required this.text,
    required this.color,
    required this.textHierarchy,
    required this.fontWeight,
    required this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: GoogleFonts.inter(
        textStyle: TextStyle(
          fontSize: setFontSize(),
          color: color,
          fontWeight: fontWeight,
        ),
      ),
    );
  }

  double? setFontSize() {
    if (textHierarchy == TextHierarchy.display) {
      return UnitManager.DISPLAY_SIZE;
    } else if (textHierarchy == TextHierarchy.header) {
      return UnitManager.HEADER_SIZE;
    } else if (textHierarchy == TextHierarchy.bodyLarge) {
      return UnitManager.BODY_LARGE;
    } else if (textHierarchy == TextHierarchy.bodyMedium) {
      return UnitManager.BODY_MEDIUM;
    } else {
      return UnitManager.BODY_SMALL;
    }
  }
}
