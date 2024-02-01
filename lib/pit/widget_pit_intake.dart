import 'package:flutter/material.dart';
import 'package:projectb/class/class_pitdata.dart';
import 'package:projectb/widgets/widget_headingmain.dart';

class PitIntake extends StatefulWidget {
  PitIntake({
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
  _PitIntakeState createState() => _PitIntakeState();
}

class _PitIntakeState extends State<PitIntake> {
  TextStyle? styleBodyTextTheme = ThemeData().textTheme.bodyMedium;
  TextStyle? styleTitleTextTheme = ThemeData().textTheme.titleMedium;

  List<DropdownMenuItem<String>> listObjectTypes = [
    DropdownMenuItem(value: "1", child: Text("Both")),
    DropdownMenuItem(value: "2", child: Text("Cone")),
    DropdownMenuItem(value: "3", child: Text("Cube")),
    DropdownMenuItem(value: "4", child: Text("N/A")),
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
        margin: const EdgeInsets.all(5.0),
        child: Container(
          padding: EdgeInsets.all(5.0),
          child: Column(children: <Widget>[
            HeadingMain(
              styleFontSize: styleTitleTextTheme!.fontSize!,
              textColor: Theme.of(context).textTheme.titleLarge!.color!,
              backGroundColor: Theme.of(context).primaryColor,
              headingText: "Intake",
              //backGroundColor: Colors.green,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Use Note?:",
                  style: styleBodyTextTheme,
                ),
                Switch(
                  value: widget.pitData.flObject!,
                  onChanged: (bool value) {
                    setState(() {
                      widget.pitData.flObject = value;
                      widget.onChanged!(widget.pitData);
                    });
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Catch:",
                  style: styleBodyTextTheme,
                ),
                Switch(
                  value: widget.pitData.flObjectCatch!,
                  onChanged: (bool value) {
                    setState(() {
                      widget.pitData.flObjectCatch = value;
                    });
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Floor Pickup:",
                  style: styleBodyTextTheme,
                ),
                Switch(
                  value: widget.pitData.flObjectFloor!,
                  onChanged: (bool value) {
                    setState(() {
                      widget.pitData.flObjectFloor = value;
                    });
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Angled Pickup:",
                  style: styleBodyTextTheme,
                ),
                Switch(
                  value: widget.pitData.flObjectAngle!,
                  onChanged: (bool value) {
                    setState(() {
                      widget.pitData.flObjectAngle = value;
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
                    controller: widget.txNotes,
                    style: styleBodyTextTheme,
                    decoration: InputDecoration(
                        hintText: 'Notes on intake system(s)',
                        hintStyle: styleBodyTextTheme),
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
