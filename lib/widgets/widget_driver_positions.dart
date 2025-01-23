import 'package:flutter/material.dart';

class DriverPositions extends StatefulWidget {
  DriverPositions(
      {Key? key,
      required this.LeftSide,
      this.highLight1 = false,
      this.highLight2 = false,
      this.highLight3 = false,
      this.color = Colors.blue})
      : super(key: key);

  final bool LeftSide;
  final Color color;
  final bool highLight1;
  final bool highLight2;
  final bool highLight3;

  @override
  _DriverPositionsState createState() => _DriverPositionsState();
}

class _DriverPositionsState extends State<DriverPositions> {
  @override
  Widget build(BuildContext context) {
    if (widget.LeftSide == true) {
      return Column(children: <Widget>[
        DriverPos(context, "1", widget.highLight1),
        DriverPos(context, "2", widget.highLight2),
        DriverPos(context, "3", widget.highLight3),
      ]);
    } else if (widget.LeftSide == false) {
      return Column(children: <Widget>[
        DriverPos(context, "3", widget.highLight3),
        DriverPos(context, "2", widget.highLight2),
        DriverPos(context, "1", widget.highLight1),
      ]);
    } else {
      return Container();
    }
  }

  Widget DriverPos(context, String pos, bool highlight) {
    if (highlight == true) {
      return Container(
        margin: const EdgeInsets.all(5.0),
        padding: EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          color: Colors.yellow,
        ),
        child: Text(
          pos,
          style: TextStyle(fontSize: 18),
        ),
      );
    } else {
      return Container(
        margin: const EdgeInsets.all(5.0),
        padding: EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          color: widget.color,
        ),
        child: Text(
          pos,
          style: TextStyle(fontSize: 18),
        ),
      );
    }
  }
}
