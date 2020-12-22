import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class CounterWidget extends StatefulWidget {
  CounterWidget({
    Key key,
    @required this.value,
    @required this.title,
    this.onIncreaseStateChanged,
    this.onDecreaseStateChanged,
    this.onSetValue,
    this.styleFieldPaddingSides = 10,
    this.styleFieldCellsWidth = 40.0,
    this.styleFieldPadding = 5.0,
    this.styleFontSize = 12,
  }) : super(key: key);

  final String value;
  final String title;
  final ValueChanged<int> onIncreaseStateChanged;
  final ValueChanged<int> onDecreaseStateChanged;
  final ValueChanged<int> onSetValue;
  final double styleFieldCellsWidth;
  final double styleFieldPadding;
  final double styleFieldPaddingSides;
  final double styleFontSize;
  final TextEditingController txtCounterValue = TextEditingController();

  @override
  _CounterWidgetState createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {


  @override
  Widget build(BuildContext context) {
    widget.txtCounterValue.text = widget.value;
    return Column(children: [
      Text(widget.title),
      Row(children: [
        Padding(
          padding: const EdgeInsets.only(left: 2.0, right: 2.0),
          child: FlatButton(
            child: Text("+"),
            onPressed: () {
              widget.onIncreaseStateChanged(1);
            },
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(
              vertical: widget.styleFieldPadding,
              horizontal: widget.styleFieldPaddingSides),
          width: widget.styleFieldCellsWidth,
          child: TextField(
            style: TextStyle(fontSize: widget.styleFontSize),
            controller: widget.txtCounterValue,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            onChanged: (String value) {
              int newValue = 0;
              if (widget.txtCounterValue.text != "") {
                newValue = int.parse(widget.txtCounterValue.text);
              }
              widget.onSetValue(newValue);},
            decoration: InputDecoration(
//labelText: "Starting Cells",
              labelStyle: TextStyle(fontSize: widget.styleFontSize),
              border: InputBorder.none,
              isDense: true,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 2.0, right: 2.0),
          child: FlatButton(
            child: Text("-"),
            onPressed: () {
              widget.onDecreaseStateChanged(-1);
            },
          ),
        ),
      ]),
    ]);
  }
}
