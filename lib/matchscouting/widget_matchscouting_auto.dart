import 'package:flutter/material.dart';
import 'package:projectb/class/class_macthscoutingdata.dart';
import 'package:projectb/widgets/widget_counter.dart';

import '../widgets/widget_headingmain.dart';
import '../widgets/widget_row_heading.dart';

class MatchAuto extends StatefulWidget {
  MatchAuto({
    Key? key,
    required this.matchScoutingData,
    this.styleFontSize = 16,
    this.styleFontSizeHeadings = 18,
    this.styleCounterButtonHeight = 25,
    this.styleCounterButtonWidth = 30,
    this.onChanged,
    this.onExpanded,
  }) : super(key: key);

  final MatchScoutingData matchScoutingData;
  final double styleFontSize;
  final double styleFontSizeHeadings;
  final double styleCounterButtonHeight;
  final double styleCounterButtonWidth;
  final ValueChanged<MatchScoutingData>? onChanged;
  final ValueChanged<bool>? onExpanded;

  @override
  _MatchAutoState createState() => _MatchAutoState();
}

class _MatchAutoState extends State<MatchAuto> {
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.99,
      child: Container(
        margin: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(),
        child: Container(
          padding: EdgeInsets.all(5.0),
          child: Column(children: <Widget>[
            HeadingMain(
              styleFontSize: Theme.of(context).textTheme.titleLarge!.fontSize!,
              textColor: Theme.of(context).textTheme.titleLarge!.color!,
              backGroundColor: Theme.of(context).primaryColor,
              headingText: "Auto",
              //backGroundColor: Colors.green,
            ),
            RowHeading(
              styleFontSize: widget.styleFontSize,
              text: "Does Auto?",
              value: widget.matchScoutingData.autoFlStart,
              styleBackGroundColor: Colors.yellow,
              onChange: (bool value) {
                setState(() {
                  widget.matchScoutingData.autoFlStart = value;
                  widget.onChanged!(widget.matchScoutingData);
                });
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Leave?",
                  style: TextStyle(fontSize: widget.styleFontSize),
                ),
                Switch(
                  value: widget.matchScoutingData.autoFlBaseLine!,
                  onChanged: (bool value) {
                    setState(() {
                      widget.matchScoutingData.autoFlBaseLine = value;
                      widget.onChanged!(widget.matchScoutingData);
                    });
                  },
                ),
              ],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text("#Pickup new Objects?:"),
              CounterWidget(
                styleButtonHeight: widget.styleCounterButtonHeight,
                styleButtonWidth: widget.styleCounterButtonWidth,
                title: "",
                value: widget.matchScoutingData.autoNumCellLoad,
                onIncreaseStateChanged: (int value) {
                  setState(() {
                    widget.matchScoutingData.autoNumCellLoad =
                        widget.matchScoutingData.autoNumCellLoad! + 1;
                    widget.onChanged!(widget.matchScoutingData);
                  });
                },
                onDecreaseStateChanged: (int value) {
                  setState(() {
                    widget.matchScoutingData.autoNumCellLoad =
                        widget.matchScoutingData.autoNumCellLoad! - 1;
                    if (widget.matchScoutingData.autoNumCellLoad! < 0) {
                      widget.matchScoutingData.autoNumCellLoad = 0;
                    }
                    widget.onChanged!(widget.matchScoutingData);
                  });
                },
                onSetValue: (int value) {
                  setState(() {
                    widget.matchScoutingData.autoNumCellLoad = value;
                    widget.onChanged!(widget.matchScoutingData);
                  });
                },
              ),
            ]),
          ]),
        ),
      ),
    );
  }
}
