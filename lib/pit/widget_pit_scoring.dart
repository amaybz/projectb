import 'package:flutter/material.dart';
import 'package:projectb/class/class_pitdata.dart';
import 'package:projectb/widgets/widget_headingmain.dart';

import '../widgets/widget_counter.dart';

class PitScoring extends StatefulWidget {
  PitScoring({
    Key? key,
    required this.pitData,
    required this.txScoringNotes,
    this.styleFontSize = 16,
    this.styleFontSizeHeadings = 18,
    this.styleFieldTextWidth = 300,
    required this.onChanged,
  }) : super(key: key);

  final PitData pitData;
  final double styleFontSize;
  final double styleFontSizeHeadings;
  final ValueChanged<PitData> onChanged;
  final TextEditingController txScoringNotes;
  final double styleFieldTextWidth;

  @override
  _PitScoringState createState() => _PitScoringState();
}

class _PitScoringState extends State<PitScoring> {
  List<DropdownMenuItem<String>> listShooterHeight = [
    DropdownMenuItem(value: "1", child: Text("N/A")),
    DropdownMenuItem(value: "2", child: Text("Bumper")),
    DropdownMenuItem(value: "3", child: Text("Trench ")),
    DropdownMenuItem(value: "4", child: Text("High")),
  ];

  List<DropdownMenuItem<String>> listShooterType = [
    DropdownMenuItem(value: "1", child: Text("N/A")),
    DropdownMenuItem(value: "2", child: Text("Fixed")),
    DropdownMenuItem(value: "3", child: Text("Hood ")),
    DropdownMenuItem(value: "4", child: Text("Turret")),
    DropdownMenuItem(value: "5", child: Text("Both")),
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
                headingText: "Scoring",
                //backGroundColor: Colors.green,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Score Fuel?:", style: styleBodyTextTheme),
                  Switch(
                    value: widget.pitData.pitFlScoreFuel!,
                    onChanged: (bool value) {
                      setState(() {
                        widget.pitData.pitFlScoreFuel = value;
                        widget.onChanged!(widget.pitData);
                      });
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Deliver Fuel?:", style: styleBodyTextTheme),
                  Switch(
                    value: widget.pitData.pitFlDeliverFuel!,
                    onChanged: (bool value) {
                      setState(() {
                        widget.pitData.pitFlDeliverFuel = value;
                        widget.onChanged!(widget.pitData);
                      });
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("#Shooters:", style: styleBodyTextTheme),
                  CounterWidget(
                    title: "",
                    styleFontSize: widget.styleFontSize,
                    value: widget.pitData.pitNumLauncher,
                    onIncreaseStateChanged: (int value) {
                      setState(() {
                        widget.pitData.pitNumLauncher =
                            widget.pitData.pitNumLauncher! + 1;
                        widget.onChanged!(widget.pitData);
                      });
                    },
                    onDecreaseStateChanged: (int value) {
                      setState(() {
                        widget.pitData.pitNumLauncher =
                            widget.pitData.pitNumLauncher! - 1;
                        if (widget.pitData.pitNumLauncher! < 0) {
                          widget.pitData.pitNumLauncher = 0;
                        }
                        widget.onChanged!(widget.pitData);
                      });
                    },
                    onSetValue: (int value) {
                      setState(() {
                        widget.pitData.pitNumLauncher = value;
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
                  Text("Shooter Height:", style: styleBodyTextTheme),
                  DropdownButton(
                    value: widget.pitData.pitIdShooterHeight == null
                        ? null
                        : widget.pitData.pitIdShooterHeight,
                    items: listShooterHeight,
                    style: styleBodyTextTheme,
                    onChanged: (item) {
                      setState(() {
                        widget.pitData.pitIdShooterHeight = item;
                        widget.onChanged!(widget.pitData);
                      });
                      print(
                        "pitIdShooterHeight: " +
                            widget.pitData.pitIdShooterHeight!,
                      );
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text("Shooter Type :", style: styleBodyTextTheme),
                  DropdownButton(
                    value: widget.pitData.pitIdShooterType == null
                        ? null
                        : widget.pitData.pitIdShooterType,
                    items: listShooterType,
                    style: styleBodyTextTheme,
                    onChanged: (item) {
                      setState(() {
                        widget.pitData.pitIdShooterType = item;
                        widget.onChanged!(widget.pitData);
                      });
                      print(
                        "pitIdShooterType: " + widget.pitData.pitIdShooterType!,
                      );
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
                      maxWidth: widget.styleFieldTextWidth,
                    ),
                    child: TextField(
                      controller: widget.txScoringNotes,
                      decoration: InputDecoration(
                        hintText: 'Notes on Scoring',
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
