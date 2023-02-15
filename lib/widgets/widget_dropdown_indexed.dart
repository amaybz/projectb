

import 'package:flutter/material.dart';


class DropDownIndexedWidget extends StatefulWidget {
  DropDownIndexedWidget({
    Key? key,
    @required this.value,
    @required this.title,
    @required this.dropDownValues,
    this.onStateChanged,
    this.styleFieldPaddingSides = 2,
    this.styleFieldWidth = 200.0,
    this.styleFieldPadding = 2.0,
    this.styleFontSize = 12,
  }) : super(key: key);


  final String? value;
  final String? title;
  final ValueChanged<String>? onStateChanged;
  final List<DropDownValue>? dropDownValues;
  final double styleFieldWidth;
  final double styleFieldPadding;
  final double styleFieldPaddingSides;
  final double styleFontSize;
  final TextEditingController txtCounterValue = TextEditingController();

  @override
  _DropDownIndexedWidgetState createState() => _DropDownIndexedWidgetState();
}

class _DropDownIndexedWidgetState extends State<DropDownIndexedWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: widget.styleFieldPadding,
          horizontal: widget.styleFieldPaddingSides),
      width: widget.styleFieldWidth,
      height: 58,
      child: DropdownButtonFormField<String>(
        isExpanded: true,
        decoration: InputDecoration(
          labelStyle:
          TextStyle(fontSize: widget.styleFontSize),
          labelText: widget.title,
          border: InputBorder.none,
          isDense: true,
        ),
        value: widget.value,
        onChanged: (String? newValue) {
          setState(() {
            widget.onStateChanged!(newValue!);
          });

        },
        items: widget.dropDownValues!.map((dropDownValue) {
          return DropdownMenuItem(
            child: new Text(
              dropDownValue.value!,
              style: TextStyle(
                  fontSize: widget.styleFontSize),
            ),
            value: dropDownValue.id,
          );
        }).toList(),
      ),
    );
  }
}

class DropDownValue {
  String? id;
  String? value;

  DropDownValue({this.id, this.value});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'value': value,
    };
  }

  DropDownValue.fromMap(Map<dynamic, dynamic> map) {
    id = map['id'];
    value = map['value'];
  }

  @override
  String toString() {
    return 'DropDownValue{id: $id, value: $value}';
  }
}


