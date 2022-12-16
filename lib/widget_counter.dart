import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class CounterWidget extends StatefulWidget {
  CounterWidget({
    Key? key,
    @required this.value,
    @required this.title,
    this.title1,
    this.onIncreaseStateChanged,
    this.onDecreaseStateChanged,
    this.onSetValue,
    this.styleFieldPaddingSides = 10,
    this.styleFieldCellsWidth = 40.0,
    this.styleFieldPadding = 2.0,
    this.styleFontSize = 12,
    this.styleButtonHeight = 25,
    this.styleButtonWidth = 30,
  }) : super(key: key);

  final int? value;
  final String? title;
  final String? title1;
  final ValueChanged<int>? onIncreaseStateChanged;
  final ValueChanged<int>? onDecreaseStateChanged;
  final ValueChanged<int>? onSetValue;
  final double styleFieldCellsWidth;
  final double styleFieldPadding;
  final double styleFieldPaddingSides;
  final double styleFontSize;
  final double styleButtonHeight;
  final double styleButtonWidth;
  final TextEditingController txtCounterValue = TextEditingController();

  @override
  _CounterWidgetState createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  Widget _counter() {
    return Row(children: [
      SizedBox(
        height: widget.styleButtonHeight,
        width: widget.styleButtonWidth,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: Colors.red,
              padding: EdgeInsets.symmetric(vertical: 0.0)),
          child: Text(
            "-",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            widget.onDecreaseStateChanged!(-1);
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
            widget.onSetValue!(newValue);
          },
          decoration: InputDecoration(
            labelStyle: TextStyle(fontSize: widget.styleFontSize),
            border: InputBorder.none,
            isDense: true,
          ),
        ),
      ),
      SizedBox(
        height: widget.styleButtonHeight,
        width: widget.styleButtonWidth,
        child: ElevatedButton(
          //padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 5.0),
          style: ElevatedButton.styleFrom(
              primary: Colors.green,
              padding: EdgeInsets.symmetric(vertical: 0.0)),
          child: Text(
            "+",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          onPressed: () {
            widget.onIncreaseStateChanged!(1);
          },
        ),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    widget.txtCounterValue.text = widget.value.toString();
    if (widget.title1 != null) {
      return Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title!,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              widget.title1!,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            _counter(),
          ]);
    } else if (widget.title != null) {
      return Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title!,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            _counter(),
          ]);
    } else {
      return Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _counter(),
          ]);
    }
  }
}
