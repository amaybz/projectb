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
    this.txChargeNotes,
    this.onExpanded,
  }) : super(key: key);

  final PitData pitData;
  final double styleFontSize;
  final double styleFontSizeHeadings;
  final double styleFieldTxShootingMaxWidth;
  final ValueChanged<PitData>? onChanged;
  final TextEditingController? txChargeNotes;
  final ValueChanged<bool>? onExpanded;

  @override
  _PitClimbState createState() => _PitClimbState();
}

class _PitClimbState extends State<PitClimb> {
  List<DropdownMenuItem<String>> listClimbType = [
    DropdownMenuItem(value: "1", child: Text("N/A")),
  ];

  List<DropdownMenuItem<String>> listClimbPos = [
    DropdownMenuItem(value: "1", child: Text("N/A")),
  ];

  getClimbTypeDropDownMenu(TextStyle textStyle) {
    listClimbType.clear();
    listClimbType.addAll([
      DropdownMenuItem(
          value: "1",
          child: Text(
            "N/A",
            style: textStyle,
          )),
      DropdownMenuItem(
          value: "2",
          child: Text(
            "Passive",
            style: textStyle,
          )),
      DropdownMenuItem(
          value: "3",
          child: Text(
            "Active",
            style: textStyle,
          )),
    ]);
  }

  getClimbPosDropDownMenu(TextStyle textStyle) {
    listClimbPos.clear();
    listClimbPos.addAll([
      DropdownMenuItem(
          value: "1",
          child: Text(
            "N/A",
            style: textStyle,
          )),
      DropdownMenuItem(
          value: "2",
          child: Text(
            "Middle",
            style: textStyle,
          )),
      DropdownMenuItem(
          value: "3",
          child: Text(
            "High",
            style: textStyle,
          )),
      DropdownMenuItem(
          value: "4",
          child: Text(
            "Any",
            style: textStyle,
          )),
    ]);
  }

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

    getClimbTypeDropDownMenu(styleBodyTextTheme!);
    getClimbPosDropDownMenu(styleBodyTextTheme!);

    if (widget.pitData.flStage == false) {
      return FractionallySizedBox(
        widthFactor: 0.99,
        child: Container(
          margin: const EdgeInsets.all(5.0),
          child: Container(
            padding: EdgeInsets.all(5.0),
            child: Column(children: <Widget>[
              HeadingMain(
                styleFontSize: styleTitleTextTheme!.fontSize!,
                textColor: Theme.of(context).textTheme.titleLarge!.color!,
                backGroundColor: Theme.of(context).primaryColor,
                headingText: "Stage",
                //backGroundColor: Colors.green,
              ),
              RowHeading(
                styleFontSize: widget.styleFontSize,
                text: "Climb Stage:",
                value: widget.pitData.flStage,
                onChange: (bool value) {
                  setState(() {
                    widget.pitData.flStage = value;
                    widget.onChanged!(widget.pitData);
                    widget.onExpanded!(true);
                  });
                },
              ),
            ]),
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
            child: Column(children: <Widget>[
              HeadingMain(
                styleFontSize: styleTitleTextTheme!.fontSize!,
                textColor: Theme.of(context).textTheme.titleLarge!.color!,
                backGroundColor: Theme.of(context).primaryColor,
                headingText: "Stage",
                //backGroundColor: Colors.green,
              ),
              RowHeading(
                styleFontSize: styleBodyTextTheme!.fontSize!,
                text: "Climb Stage:",
                value: widget.pitData.flStage,
                styleBackGroundColor: Colors.green,
                onChange: (bool value) {
                  setState(() {
                    widget.pitData.flStage = value;
                    widget.onChanged!(widget.pitData);
                    widget.onExpanded!(true);
                  });
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Climb Location:",
                    style: styleBodyTextTheme,
                  ),
                  DropdownButton(
                    value: widget.pitData.idStageClimbPos == null
                        ? null
                        : widget.pitData.idStageClimbPos,
                    items: listClimbPos,
                    onChanged: (item) {
                      setState(() {
                        widget.pitData.idStageClimbPos = item as String?;
                        widget.onChanged!(widget.pitData);
                      });
                      print("idStageClimbPos: " +
                          widget.pitData.idStageClimbPos!);
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Climb Type:",
                    style: styleBodyTextTheme,
                  ),
                  DropdownButton(
                    value: widget.pitData.idStageClimbType == null
                        ? null
                        : widget.pitData.idStageClimbType,
                    items: listClimbType,
                    onChanged: (item) {
                      setState(() {
                        widget.pitData.idStageClimbType = item as String?;
                        widget.onChanged!(widget.pitData);
                      });
                      print("idStageClimbType: " +
                          widget.pitData.idStageClimbType!);
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Climb Assist?:",
                    style: styleBodyTextTheme,
                  ),
                  Switch(
                    value: widget.pitData.flStageAssist!,
                    onChanged: (bool value) {
                      setState(() {
                        widget.pitData.flStageAssist = value;
                      });
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Notes: ",
                    style: styleBodyTextTheme,
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                        maxWidth: widget.styleFieldTxShootingMaxWidth),
                    child: TextField(
                      controller: widget.txChargeNotes,
                      decoration: InputDecoration(
                          hintText: 'Climb Notes',
                          hintStyle:
                              styleBodyTextTheme?.copyWith(color: Colors.grey)),
                    ),
                  ),
                ],
              ),
            ]),
          ),
        ),
      );
    }
  }
}
