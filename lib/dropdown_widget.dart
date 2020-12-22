

import 'package:flutter/material.dart';


class DropDownWidget extends StatefulWidget {
  DropDownWidget({
    Key key,
    @required this.value,
    @required this.title,
    @required this.list,
    this.onStateChanged,
    this.styleFieldPaddingSides = 10,
    this.styleFieldWidth = 100.0,
    this.styleFieldPadding = 2.0,
    this.styleFontSize = 12,
  }) : super(key: key);


  final String value;
  final String title;
  final ValueChanged<String> onStateChanged;
  final List<String> list;
  final double styleFieldWidth;
  final double styleFieldPadding;
  final double styleFieldPaddingSides;
  final double styleFontSize;
  final TextEditingController txtCounterValue = TextEditingController();

  @override
  _DropDownWidgetState createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: widget.styleFieldPadding,
          horizontal: widget.styleFieldPaddingSides),
      width: widget.styleFieldWidth,
      height: 58,
      child: DropdownButtonFormField<String>(
//
        isExpanded: true,
        decoration: InputDecoration(
          labelStyle:
          TextStyle(fontSize: widget.styleFontSize),
          labelText: widget.title,
          border: InputBorder.none,
          isDense: true,
        ),
        value: widget.value,
        onChanged: (String newValue) {
          setState(() {
            widget.onStateChanged(newValue);
          });

        },
        items: widget.list.map((value) {
          return DropdownMenuItem(
            child: new Text(
              value,
              style: TextStyle(
                  fontSize: widget.styleFontSize),
            ),
            value: value,
          );
        }).toList(),
      ),
    );
  }
}


