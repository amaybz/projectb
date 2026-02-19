import 'package:flutter/material.dart';
import 'package:projectb/class/class_pitdata.dart';
import 'package:projectb/widgets/widget_headingmain.dart';
import 'package:projectb/widgets/widget_counter.dart';

import '../widgets/widget_row_heading.dart';

class PitAuto extends StatefulWidget {
  PitAuto({
    Key? key,
    required this.pitData,
    this.styleFontSize = 16,
    this.styleFontSizeHeadings = 18,
    this.onChanged,
    this.onExpanded,
    this.pitTxAutoNotes,
    this.strWeight = "lbs",
    this.strDistance = "inches",
  }) : super(key: key);

  final PitData pitData;
  final double styleFontSize;
  final double styleFontSizeHeadings;
  final ValueChanged<PitData>? onChanged;
  final ValueChanged<bool>? onExpanded;
  final String strWeight;
  final String strDistance;
  final TextEditingController? pitTxAutoNotes;

  @override
  _PitAutoState createState() => _PitAutoState();
}

class _PitAutoState extends State<PitAuto> {
  List<DropdownMenuItem<String>> listReloadPoints = [
    DropdownMenuItem(value: "1", child: Text("N/A")),
    DropdownMenuItem(value: "2", child: Text("Depot")),
    DropdownMenuItem(value: "3", child: Text("Outpost")),
    DropdownMenuItem(value: "4", child: Text("Middle")),
  ];

  TextStyle? styleBodyTextTheme = ThemeData().textTheme.bodyMedium;
  TextStyle? styleTitleTextTheme = ThemeData().textTheme.titleMedium;

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

    //getAutoScoreDropDownMenu(styleBodyTextTheme!);

    if (widget.pitData.pitFlAuto == false) {
      return FractionallySizedBox(
        widthFactor: 0.99,
        child: Container(
          margin: const EdgeInsets.all(5.0),
          child: Container(
            padding: EdgeInsets.all(5.0),
            child: Column(
              children: <Widget>[
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
                  value: widget.pitData.pitFlAuto,
                  onChange: (bool value) {
                    setState(() {
                      widget.pitData.pitFlAuto = value;
                      widget.onChanged!(widget.pitData);
                      widget.onExpanded!(true);
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return FractionallySizedBox(
        widthFactor: 0.99,
        child: Container(
          margin: const EdgeInsets.all(5.0),
          child: Container(
            padding: EdgeInsets.all(5.0),
            child: Column(
              children: <Widget>[
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
                  value: widget.pitData.pitFlAuto,
                  styleBackGroundColor: Colors.green,
                  onChange: (bool value) {
                    setState(() {
                      widget.pitData.pitFlAuto = value;
                      widget.onChanged!(widget.pitData);
                    });
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Score?", style: styleBodyTextTheme),
                    Switch(
                      value: widget.pitData.pitFlAutoScoreFuel!,
                      onChanged: (bool value) {
                        setState(() {
                          widget.pitData.pitFlAutoScoreFuel = value;
                          widget.onChanged!(widget.pitData);
                        });
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("#Fuel Scored:", style: styleBodyTextTheme),
                    CounterWidget(
                      title: "",
                      styleFontSize: widget.styleFontSize,
                      value: widget.pitData.pitNumAutoScore,
                      onIncreaseStateChanged: (int value) {
                        setState(() {
                          widget.pitData.pitNumAutoScore =
                              widget.pitData.pitNumAutoScore! + 1;
                          widget.onChanged!(widget.pitData);
                        });
                      },
                      onDecreaseStateChanged: (int value) {
                        setState(() {
                          widget.pitData.pitNumAutoScore =
                              widget.pitData.pitNumAutoScore! - 1;
                          if (widget.pitData.pitNumAutoScore! < 0) {
                            widget.pitData.pitNumAutoScore = 0;
                          }
                          widget.onChanged!(widget.pitData);
                        });
                      },
                      onSetValue: (int value) {
                        setState(() {
                          widget.pitData.pitNumAutoScore = value;
                          widget.onChanged!(widget.pitData);
                        });
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("#Extra Fuel:", style: styleBodyTextTheme),
                    CounterWidget(
                      title: "",
                      styleFontSize: widget.styleFontSize,
                      value: widget.pitData.pitNumAutoFuel,
                      onIncreaseStateChanged: (int value) {
                        setState(() {
                          widget.pitData.pitNumAutoFuel =
                              widget.pitData.pitNumAutoFuel! + 1;
                          widget.onChanged!(widget.pitData);
                        });
                      },
                      onDecreaseStateChanged: (int value) {
                        setState(() {
                          widget.pitData.pitNumAutoFuel =
                              widget.pitData.pitNumAutoFuel! - 1;
                          if (widget.pitData.pitNumAutoFuel! < 0) {
                            widget.pitData.pitNumAutoFuel = 0;
                          }
                          widget.onChanged!(widget.pitData);
                        });
                      },
                      onSetValue: (int value) {
                        setState(() {
                          widget.pitData.pitNumAutoFuel = value;
                          widget.onChanged!(widget.pitData);
                        });
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text("Reload Points:", style: styleBodyTextTheme),
                    DropdownButton(
                      value: widget.pitData.pitIdAutoReloadPoints == null
                          ? null
                          : widget.pitData.pitIdAutoReloadPoints,
                      items: listReloadPoints,
                      style: styleBodyTextTheme,
                      onChanged: (item) {
                        setState(() {
                          widget.pitData.pitIdAutoReloadPoints = item;
                          widget.onChanged!(widget.pitData);
                        });
                        print(
                          "pitIdAutoReloadPoints: " +
                              widget.pitData.pitIdAutoReloadPoints!,
                        );
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Auto Climb?", style: styleBodyTextTheme),
                    Switch(
                      value: widget.pitData.pitFlAutoClimb!,
                      onChanged: (bool value) {
                        setState(() {
                          widget.pitData.pitFlAutoClimb = value;
                          widget.onChanged!(widget.pitData);
                        });
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Notes: ", style: styleBodyTextTheme),
                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 300),
                      child: TextField(
                        controller: widget.pitTxAutoNotes,
                        decoration: InputDecoration(
                          hintText: 'Auto Notes',
                          hintStyle: styleBodyTextTheme?.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
