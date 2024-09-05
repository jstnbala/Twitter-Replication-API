import 'package:flutter/material.dart';
import '../utils/constants.dart';

const CircularProgressIndicator genericLoading = CircularProgressIndicator(
  valueColor: AlwaysStoppedAnimation<Color>(TWITTER_WHITE),
); // Circular Progress Indicator

class InterFont extends StatelessWidget {
  const InterFont({
    Key? key,
    required this.text,
    required this.fontSize,
    required this.color,
    this.fontWeight = FontWeight.normal,
    this.textAlign = TextAlign.left,
    this.letterSpacing = 0,
  }) : super(key: key);

  final String text;
  final double fontSize, letterSpacing;
  final Color color;
  final FontWeight fontWeight;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: TextOverflow.ellipsis,
      maxLines: 4,
      softWrap: false,
      style: TextStyle(
        fontFamily: 'Inter',
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
        letterSpacing: letterSpacing,
      ), // TextStyle
    ); // Text
  }
}
