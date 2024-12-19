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
  TextStyle? styleBodyTextTheme = ThemeData().textTheme.bodyMedium;
  TextStyle? styleTitleTextTheme = ThemeData().textTheme.titleMedium;
  bool flAutoSelected = true;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (width < 500) {
      setState(() {
        styleBodyTextTheme = Theme.of(context).textTheme.bodyMedium;
        styleTitleTextTheme = Theme.of(context).textTheme.titleMedium;
      });
    }
    if (width < 393) {
      setState(() {
        styleBodyTextTheme = Theme.of(context).textTheme.bodySmall;
        styleTitleTextTheme = Theme.of(context).textTheme.titleSmall;
      });
    }
    if (width >= 600) {
      setState(() {
        styleBodyTextTheme = Theme.of(context).textTheme.bodyLarge;
        styleTitleTextTheme = Theme.of(context).textTheme.titleLarge;
      });
    }

    return FractionallySizedBox(
      widthFactor: 0.99,
      child: Container(
        margin: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(),
        child: Container(
          padding: EdgeInsets.all(5.0),
          child: Column(children: <Widget>[
            HeadingMain(
              styleFontSize: styleTitleTextTheme!.fontSize!,
              textColor: Theme.of(context).textTheme.titleLarge!.color!,
              backGroundColor: Theme.of(context).primaryColor,
              headingText: "Auto",
              //backGroundColor: Colors.green,
            ),
            RowHeading(
              styleFontSize: styleBodyTextTheme!.fontSize!,
              text: "Does Auto?",
              value: widget.matchScoutingData.autoFlStart,
              styleBackGroundColor: Colors.yellow,
              onChange: (bool value) {
                setState(() {
                  widget.matchScoutingData.autoFlStart = value;
                  flAutoSelected = value;
                  widget.matchScoutingData.autoFlBaseLine = false;
                  widget.matchScoutingData.autoNumCellLoad = 0;
                  widget.onChanged!(widget.matchScoutingData);
                });
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Leave?",
                  style: styleBodyTextTheme,
                ),
                Switch(
                  value: widget.matchScoutingData.autoFlBaseLine!,
                  onChanged: (bool value) {
                    if (flAutoSelected == true) {
                      setState(() {
                        widget.matchScoutingData.autoFlBaseLine = value;
                        widget.onChanged!(widget.matchScoutingData);
                      });
                    }
                  },
                ),
              ],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(
                "#Pickup new Objects?:",
                style: styleBodyTextTheme,
              ),
              CounterWidget(
                styleButtonHeight: widget.styleCounterButtonHeight,
                styleButtonWidth: widget.styleCounterButtonWidth,
                title: "",
                value: widget.matchScoutingData.autoNumCellLoad,
                onIncreaseStateChanged: (int value) {
                  if (flAutoSelected == true) {
                    setState(() {
                      widget.matchScoutingData.autoNumCellLoad =
                          widget.matchScoutingData.autoNumCellLoad! + 1;
                      widget.onChanged!(widget.matchScoutingData);
                    });
                  }
                },
                onDecreaseStateChanged: (int value) {
                  if (flAutoSelected == true) {
                    setState(() {
                      widget.matchScoutingData.autoNumCellLoad =
                          widget.matchScoutingData.autoNumCellLoad! - 1;
                      if (widget.matchScoutingData.autoNumCellLoad! < 0) {
                        widget.matchScoutingData.autoNumCellLoad = 0;
                      }
                      widget.onChanged!(widget.matchScoutingData);
                    });
                  }
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
