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
            "Shallow",
            style: textStyle,
          )),
      DropdownMenuItem(
          value: "3",
          child: Text(
            "Deep",
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

    if (widget.pitData.flClimb == false) {
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
                headingText: "Climb",
                //backGroundColor: Colors.green,
              ),
              RowHeading(
                styleFontSize: widget.styleFontSize,
                text: "Climb?:",
                value: widget.pitData.flClimb,
                onChange: (bool value) {
                  setState(() {
                    widget.pitData.flClimb = value;
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
                headingText: "Climb",
                //backGroundColor: Colors.green,
              ),
              RowHeading(
                styleFontSize: styleBodyTextTheme!.fontSize!,
                text: "Climb?:",
                value: widget.pitData.flClimb,
                styleBackGroundColor: Colors.green,
                onChange: (bool value) {
                  setState(() {
                    widget.pitData.flClimb = value;
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
                    value: widget.pitData.idClimbPos == null
                        ? null
                        : widget.pitData.idClimbPos,
                    items: listClimbPos,
                    onChanged: (item) {
                      setState(() {
                        widget.pitData.idClimbPos = item as String?;
                        widget.onChanged!(widget.pitData);
                      });
                      print("idClimbPos: " + widget.pitData.idClimbPos!);
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
                      controller: widget.txNotes,
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
