import 'package:flutter/material.dart';

class RowHeading extends StatefulWidget {
  const RowHeading(
      {Key? key,
      required this.styleFontSize,
      this.styleBackGroundColor = Colors.yellow,
      this.value,
      this.text,
      this.onChange})
      : super(key: key);

  final double styleFontSize;
  final Color styleBackGroundColor;
  final String? text;
  final bool? value;
  final ValueChanged<bool>? onChange;

  @override
  _RowHeadingState createState() => _RowHeadingState();
}

class _RowHeadingState extends State<RowHeading> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 0.0),
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 1.0),
      decoration: BoxDecoration(
        border: Border.all(color: widget.styleBackGroundColor),
        color: widget.styleBackGroundColor,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(3),
            topRight: Radius.circular(3),
            bottomLeft: Radius.circular(3),
            bottomRight: Radius.circular(3)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.text!,
            style:
                TextStyle(fontSize: widget.styleFontSize, color: Colors.black),
          ),
          Switch(
            value: widget.value!,
            onChanged: (bool value) {
              setState(() {
                widget.onChange!(value);
              });
            },
          ),
        ],
      ),
    );
  }
}
