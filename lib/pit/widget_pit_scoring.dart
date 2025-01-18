import 'package:flutter/material.dart';
import 'package:projectb/class/class_pitdata.dart';
import 'package:projectb/widgets/widget_headingmain.dart';

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
  List<DropdownMenuItem<String>> listNodeType = [
    DropdownMenuItem(value: "1", child: Text("N/A")),
    DropdownMenuItem(value: "2", child: Text("Subwoofer")),
    DropdownMenuItem(value: "3", child: Text("Podium")),
    DropdownMenuItem(value: "4", child: Text("Long")),
    DropdownMenuItem(value: "5", child: Text("All")),
  ];

  getNodeTypeDropDownMenu(TextStyle textStyle) {
    listNodeType.clear();
    listNodeType.addAll([
      DropdownMenuItem(
          value: "1",
          child: Text(
            "N/A",
            style: textStyle,
          )),
      DropdownMenuItem(
          value: "2",
          child: Text(
            "Subwoofer",
            style: textStyle,
          )),
      DropdownMenuItem(
          value: "3",
          child: Text(
            "Podium",
            style: textStyle,
          )),
      DropdownMenuItem(
          value: "4",
          child: Text(
            "Long",
            style: textStyle,
          )),
      DropdownMenuItem(
          value: "5",
          child: Text(
            "All",
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

    getNodeTypeDropDownMenu(styleBodyTextTheme!);

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
              headingText: "Scoring",
              //backGroundColor: Colors.green,
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        HeadingMain(
                          styleFontSize: styleTitleTextTheme!.fontSize!,
                          textColor:
                              Theme.of(context).textTheme.titleLarge!.color!,
                          backGroundColor:
                              Theme.of(context).dialogBackgroundColor,
                          headingText: "Coral",
                          //backGroundColor: Colors.green,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "L1:",
                              style: styleBodyTextTheme,
                            ),
                            Switch(
                              value: widget.pitData.flScoreCoralL1!,
                              onChanged: (bool value) {
                                setState(() {
                                  widget.pitData.flScoreCoralL1 = value;
                                });
                              },
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "L2:",
                              style: styleBodyTextTheme,
                            ),
                            Switch(
                              value: widget.pitData.flScoreCoralL2!,
                              onChanged: (bool value) {
                                setState(() {
                                  widget.pitData.flScoreCoralL2 = value;
                                });
                              },
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "L3:",
                              style: styleBodyTextTheme,
                            ),
                            Switch(
                              value: widget.pitData.flScoreCoralL3!,
                              onChanged: (bool value) {
                                setState(() {
                                  widget.pitData.flScoreCoralL3 = value;
                                });
                              },
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "L4:",
                              style: styleBodyTextTheme,
                            ),
                            Switch(
                              value: widget.pitData.flScoreCoralL4!,
                              onChanged: (bool value) {
                                setState(() {
                                  widget.pitData.flScoreCoralL4 = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ]),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        HeadingMain(
                          styleFontSize: styleTitleTextTheme!.fontSize!,
                          textColor:
                              Theme.of(context).textTheme.titleLarge!.color!,
                          backGroundColor:
                              Theme.of(context).dialogBackgroundColor,
                          headingText: "Algae",
                          //backGroundColor: Colors.green,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Barge:",
                              style: styleBodyTextTheme,
                            ),
                            Switch(
                              value: widget.pitData.flScoreAlgaeBarge!,
                              onChanged: (bool value) {
                                setState(() {
                                  widget.pitData.flScoreAlgaeBarge = value;
                                });
                              },
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Processor:",
                              style: styleBodyTextTheme,
                            ),
                            Switch(
                              value: widget.pitData.flScoreAlgaeProcess!,
                              onChanged: (bool value) {
                                setState(() {
                                  widget.pitData.flScoreAlgaeProcess = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ]),
                ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Notes: ",
                  style: styleBodyTextTheme,
                ),
                ConstrainedBox(
                  constraints:
                      BoxConstraints(maxWidth: widget.styleFieldTextWidth),
                  child: TextField(
                    controller: widget.txScoringNotes,
                    decoration: InputDecoration(
                        hintText: 'Notes on Scoring',
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
