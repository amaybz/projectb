import 'package:flutter/material.dart';
import 'package:projectb/class/class_macthscoutingdata.dart';
import '../widgets/widget_headingmain.dart';
import '../widgets/widget_row_heading.dart';

class AutoClimb extends StatefulWidget {
  AutoClimb({
    Key? key,
    required this.matchScoutingData,
    this.styleFontSize = 16,
    this.styleFontSizeHeadings = 18,
    this.styleFieldTxClimbMaxWidth = 300,
    this.styleCounterButtonHeight = 25,
    this.styleCounterButtonWidth = 30,
    this.onChanged,
    this.txClimb,
    this.onExpanded,
  }) : super(key: key);

  final MatchScoutingData matchScoutingData;
  final double styleFontSize;
  final double styleFontSizeHeadings;
  final double styleFieldTxClimbMaxWidth;
  final double styleCounterButtonHeight;
  final double styleCounterButtonWidth;
  final ValueChanged<MatchScoutingData>? onChanged;
  final ValueChanged<bool>? onExpanded;
  final TextEditingController? txClimb;

  @override
  _AutoClimbState createState() => _AutoClimbState();
}

class _AutoClimbState extends State<AutoClimb> {
  TextStyle? styleBodyTextTheme = ThemeData().textTheme.bodyMedium;
  TextStyle? styleTitleTextTheme = ThemeData().textTheme.titleMedium;

  List<DropdownMenuItem<String>> ddsSpeed = [
    DropdownMenuItem(value: "1", child: Text("N/A")),
    DropdownMenuItem(value: "2", child: Text("Slow (> 7 Secs)")),
    DropdownMenuItem(value: "3", child: Text("Medium (3-7 Secs)")),
    DropdownMenuItem(value: "4", child: Text("Fast <3 Secs")),
  ];

  List<DropdownMenuItem<String>> listFailedSuccess = [
    DropdownMenuItem(value: "1", child: Text("N/A")),
    DropdownMenuItem(value: "2", child: Text("Failed")),
    DropdownMenuItem(value: "3", child: Text("Success")),
  ];

  List<DropdownMenuItem<String>> listClimbType = [
    DropdownMenuItem(value: "1", child: Text("N/A")),
    DropdownMenuItem(value: "2", child: Text("Left")),
    DropdownMenuItem(value: "3", child: Text("Center")),
    DropdownMenuItem(value: "4", child: Text("Right")),
  ];

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
        padding: EdgeInsets.all(1.0),
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
              text: "Auto Climb?",
              value: widget.matchScoutingData.autoFlClimb,
              styleBackGroundColor: Colors.yellow,
              onChange: (bool value) {
                setState(() {
                  widget.matchScoutingData.autoFlClimb = value;
                });

                if (widget.matchScoutingData.autoFlClimb! == false) ;
                {
                  setState(() {
                    widget.matchScoutingData.autoIdClimbOutcome = "1";
                    widget.matchScoutingData.autoIdClimbPos = "1";
                    widget.matchScoutingData.autoIdStageClimbSpeed = "1";
                  });
                }
                widget.onChanged!(widget.matchScoutingData);
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text("Climb Outcome:", style: styleBodyTextTheme),
                DropdownButton(
                  value: widget.matchScoutingData.autoIdClimbOutcome == null
                      ? null
                      : widget.matchScoutingData.autoIdClimbOutcome,
                  items: listFailedSuccess,
                  style: styleBodyTextTheme,
                  onChanged: (item) {
                    setState(() {
                      widget.matchScoutingData.autoIdClimbOutcome = item;
                      widget.onChanged!(widget.matchScoutingData);
                    });
                    print(
                      "autoIdClimbOutcome: " +
                          widget.matchScoutingData.autoIdClimbOutcome!,
                    );
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text("Climb Position:", style: styleBodyTextTheme),
                DropdownButton(
                  value: widget.matchScoutingData.autoIdClimbPos == null
                      ? null
                      : widget.matchScoutingData.autoIdClimbPos,
                  items: listClimbType,
                  style: styleBodyTextTheme,
                  onChanged: (item) {
                    setState(() {
                      widget.matchScoutingData.autoIdClimbPos = item;
                      widget.onChanged!(widget.matchScoutingData);
                    });
                    print(
                      "autoIdClimbPos: " +
                          widget.matchScoutingData.autoIdClimbPos!,
                    );
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text("Speed:", style: styleBodyTextTheme),
                DropdownButton(
                  value: widget.matchScoutingData.autoIdStageClimbSpeed == null
                      ? null
                      : widget.matchScoutingData.autoIdStageClimbSpeed,
                  items: ddsSpeed,
                  style: styleBodyTextTheme,
                  onChanged: (item) {
                    setState(() {
                      widget.matchScoutingData.autoIdStageClimbSpeed = item;
                      widget.onChanged!(widget.matchScoutingData);
                    });
                    print(
                      "autoIdStageClimbSpeed: " +
                          widget.matchScoutingData.autoIdStageClimbSpeed!,
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
