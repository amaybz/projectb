import 'package:flutter/material.dart';
import 'package:projectb/class/class_pitdata.dart';
import 'package:projectb/widgets/widget_headingmain.dart';

import '../widgets/widget_row_heading.dart';

class PitClimb extends StatefulWidget {
  PitClimb({
    Key? key,
    required this.pitData,
    this.styleFontSize = 16,
    this.styleFontSizeHeadings = 18,
    this.styleFieldTxShootingMaxWidth = 300,
    this.onChanged,
    this.txNotes,
    this.onExpanded,
  }) : super(key: key);

  final PitData pitData;
  final double styleFontSize;
  final double styleFontSizeHeadings;
  final double styleFieldTxShootingMaxWidth;
  final ValueChanged<PitData>? onChanged;
  final TextEditingController? txNotes;
  final ValueChanged<bool>? onExpanded;

  @override
  _PitClimbState createState() => _PitClimbState();
}

class _PitClimbState extends State<PitClimb> {
  List<DropdownMenuItem<String>> listClimbHeight = [
    DropdownMenuItem(value: "1", child: Text("N/A")),
    DropdownMenuItem(value: "2", child: Text("Lvl 1")),
    DropdownMenuItem(value: "3", child: Text("Lvl 2")),
    DropdownMenuItem(value: "4", child: Text("Lvl 3")),
  ];

  List<DropdownMenuItem<String>> listClimbPos = [
    DropdownMenuItem(value: "1", child: Text("N/A")),
    DropdownMenuItem(value: "2", child: Text("Left")),
    DropdownMenuItem(value: "3", child: Text("Center")),
    DropdownMenuItem(value: "4", child: Text("Right")),
    DropdownMenuItem(value: "5", child: Text("Any")),
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

    if (widget.pitData.pitFlClimb == false) {
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
                  headingText: "Climb",
                  //backGroundColor: Colors.green,
                ),
                RowHeading(
                  styleFontSize: widget.styleFontSize,
                  text: "Climb?:",
                  value: widget.pitData.pitFlClimb,
                  onChange: (bool value) {
                    setState(() {
                      widget.pitData.pitFlClimb = value;
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
                  headingText: "Climb",
                  //backGroundColor: Colors.green,
                ),
                RowHeading(
                  styleFontSize: styleBodyTextTheme!.fontSize!,
                  text: "Climb?:",
                  value: widget.pitData.pitFlClimb,
                  styleBackGroundColor: Colors.green,
                  onChange: (bool value) {
                    setState(() {
                      widget.pitData.pitFlClimb = value;
                      widget.onChanged!(widget.pitData);
                      widget.onExpanded!(true);
                    });
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text("Climb Position:", style: styleBodyTextTheme),
                    DropdownButton(
                      value: widget.pitData.pitIdClimbPos == null
                          ? 1
                          : widget.pitData.pitIdClimbPos,
                      items: listClimbPos,
                      style: styleBodyTextTheme,
                      onChanged: (item) {
                        setState(() {
                          widget.pitData.pitIdClimbPos = item as String?;
                          widget.onChanged!(widget.pitData);
                        });
                        print("idClimbPos: " + widget.pitData.pitIdClimbPos!);
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text("Max Climb Height:", style: styleBodyTextTheme),
                    DropdownButton(
                      value: widget.pitData.pitIdClimbHeightMax == null
                          ? 1
                          : widget.pitData.pitIdClimbHeightMax,
                      items: listClimbHeight,
                      style: styleBodyTextTheme,
                      onChanged: (item) {
                        setState(() {
                          widget.pitData.pitIdClimbHeightMax = item as String?;
                          widget.onChanged!(widget.pitData);
                        });
                        print(
                          "pitIdClimbHeightMax: " +
                              widget.pitData.pitIdClimbHeightMax!,
                        );
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text("Pref. Climb Height:", style: styleBodyTextTheme),
                    DropdownButton(
                      value: widget.pitData.pitIdClimbHeightPref == null
                          ? 1
                          : widget.pitData.pitIdClimbHeightPref,
                      items: listClimbHeight,
                      style: styleBodyTextTheme,
                      onChanged: (item) {
                        setState(() {
                          widget.pitData.pitIdClimbHeightPref = item as String?;
                          widget.onChanged!(widget.pitData);
                        });
                        print(
                          "pitIdClimbHeightPref: " +
                              widget.pitData.pitIdClimbHeightPref!,
                        );
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Climb Release:", style: styleBodyTextTheme),
                    Switch(
                      value: widget.pitData.pitFlClimbRelease!,
                      onChanged: (bool value) {
                        setState(() {
                          widget.pitData.pitFlClimbRelease = value;
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
                      constraints: BoxConstraints(
                        maxWidth: widget.styleFieldTxShootingMaxWidth,
                      ),
                      child: TextField(
                        controller: widget.txNotes,
                        decoration: InputDecoration(
                          hintText: 'Climb Notes',
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
