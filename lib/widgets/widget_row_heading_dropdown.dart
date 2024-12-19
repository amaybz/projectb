import 'package:flutter/material.dart';
import 'package:projectb/widgets/widget_dropdown_indexed.dart';


class RowHeadingDropDown extends StatefulWidget {
  const RowHeadingDropDown(
      {Key? key,
      @required this.value,
      required this.listValues,
      this.styleFontSize = 11,
      this.styleBackGroundColor = Colors.yellow,
      this.text,
      this.onChange})
      : super(key: key);

  final double styleFontSize;
  final Color styleBackGroundColor;
  final String? text;
  final String? value;
  final ValueChanged<String>? onChange;
  final List<DropDownValue> listValues;

  @override
  _RowHeadingDropDownState createState() => _RowHeadingDropDownState();
}

class _RowHeadingDropDownState extends State<RowHeadingDropDown> {
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
            style: TextStyle(fontSize: widget.styleFontSize),
          ),
          DropDownIndexedWidget(
            title: "",
            value: widget.value!,
            dropDownValues: widget.listValues,
            onStateChanged: (String value) {
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
