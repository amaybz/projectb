import 'package:flutter/material.dart';

class HeadingMain extends StatelessWidget {
  const HeadingMain(
      {Key? key,
      required this.styleFontSize,
      required this.headingText,
      this.textColor = const Color(0xffFBF8BE),
      this.backGroundColor = const Color(0xff234E70)})
      : super(key: key);

  final double styleFontSize;
  final String headingText;
  final Color backGroundColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 3.0, horizontal: 25.0),
      decoration: BoxDecoration(
        border: Border.all(color: backGroundColor),
        color: backGroundColor,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(5),
            topRight: Radius.circular(5),
            bottomLeft: Radius.circular(5),
            bottomRight: Radius.circular(5)),
      ),
      child: Text(
        headingText,
        style: TextStyle(
          fontSize: styleFontSize,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
    );
  }
}
