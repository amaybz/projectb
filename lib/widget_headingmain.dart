import 'package:flutter/material.dart';

class HeadingMain extends StatelessWidget {
  const HeadingMain(
      {Key key,
        @required this.styleFontSize,
        @required this.headingText,
        this.backGroundColor = Colors.grey
      })
      : super(key: key);

  final double styleFontSize;
  final String headingText;
  final Color backGroundColor;

  @override
  Widget build(BuildContext context) {
    return
      Container(
      padding: EdgeInsets.all(3.0),
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
        style: TextStyle(fontSize: styleFontSize),
      ),
    );
  }
}
