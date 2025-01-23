import 'package:flutter/material.dart';
import 'package:projectb/class/class_macthscoutingdata.dart';
import 'package:projectb/matchscouting/widget_matchscouting_human.dart';
import 'package:projectb/widgets/widget_dropdown_indexed.dart';
import 'package:projectb/widgets/widget_headingmain.dart';

import '../localdb.dart';

class RatingsTab extends StatefulWidget {
  const RatingsTab(
      {Key? key,
      required this.styleFontSize,
      required this.styleFontSizeHeadings,
      required this.matchScoutingData,
      this.styleCounterButtonHeight = 25,
      this.styleCounterButtonWidth = 30,
      this.onCommentsChanged,
      required this.eventTeamsListDropDown,
      required this.eventTeams,
      required this.onChange})
      : super(key: key);

  final double styleFontSize;
  final double styleFontSizeHeadings;
  final MatchScoutingData matchScoutingData;
  final ValueChanged<String>? onCommentsChanged;
  final ValueChanged<MatchScoutingData>? onChange;
  final double styleCounterButtonHeight;
  final double styleCounterButtonWidth;
  final List<DropdownMenuItem<String>> eventTeamsListDropDown;
  final List<LocalTeam>? eventTeams;

  @override
  _RatingsTabState createState() => _RatingsTabState();
}

class _RatingsTabState extends State<RatingsTab> {
  //lists
  final List<DropDownValue> listRatings = [
    DropDownValue(id: "1", value: "N/A"),
    DropDownValue(id: "2", value: "Terrible"),
    DropDownValue(id: "3", value: "Average"),
    DropDownValue(id: "4", value: "Good"),
    DropDownValue(id: "5", value: "Amazing"),
  ];

  final List<DropDownValue> listRatingsDefence = [
    DropDownValue(id: "1", value: "N/A"),
    DropDownValue(id: "2", value: "Weak"),
    DropDownValue(id: "3", value: "Harassment"),
    DropDownValue(id: "4", value: "Game Changing"),
  ];

  final List<DropDownValue> listDefenceType = [
    DropDownValue(id: "1", value: "N/A"),
    DropDownValue(id: "2", value: "Block Station"),
    DropDownValue(id: "3", value: "Block Scoring"),
    DropDownValue(id: "4", value: "Mobile"),
    DropDownValue(id: "5", value: "All"),
  ];

  final List<DropDownValue> listTraction = [
    DropDownValue(id: "1", value: "N/A"),
    DropDownValue(id: "2", value: "No Traction"),
    DropDownValue(id: "3", value: "Slips"),
    DropDownValue(id: "4", value: "Grip"),
  ];

  final TextEditingController? _txtComments = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Call the getJSONData() method when the app initializes
    //_getScoringData();
    updateValues();
  }

  updateValues() {
    if (widget.matchScoutingData.commTxNotes != null) {
      setState(() {
        _txtComments?.text = widget.matchScoutingData.commTxNotes!.toString();
      });
    }
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

    return Column(
      children: [
        FractionallySizedBox(
          widthFactor: 0.99,
          child: Container(
            margin: const EdgeInsets.all(5.0),
            child: Container(
              padding: EdgeInsets.all(5.0),
              child: Column(children: <Widget>[
                HumanWidget(
                  matchScoutingData: widget.matchScoutingData,
                  styleCounterButtonHeight: widget.styleCounterButtonHeight,
                  styleCounterButtonWidth: widget.styleCounterButtonWidth,
                  eventTeams: widget.eventTeams,
                  eventTeamsListDropDown: widget.eventTeamsListDropDown,
                  onChange: (matchScoutingData) {
                    setState(() {
                      widget.onChange!(matchScoutingData);
                    });
                  },
                ),
                HeadingMain(
                  styleFontSize: styleTitleTextTheme!.fontSize!,
                  textColor: Theme.of(context).textTheme.titleLarge!.color!,
                  backGroundColor: Theme.of(context).primaryColor,
                  headingText: "Drive",
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Drive Ability:",
                      style: styleBodyTextTheme,
                    ),
                    DropDownIndexedWidget(
                      value: widget.matchScoutingData.commIdDriveRating,
                      title: null,
                      dropDownValues: listRatings,
                      onStateChanged: (String value) {
                        setState(
                          () {
                            widget.matchScoutingData.commIdDriveRating = value;
                            widget.onChange!(widget.matchScoutingData);
                          },
                        );
                      },
                    ),
                  ],
                ),
                HeadingMain(
                  styleFontSize: styleTitleTextTheme!.fontSize!,
                  textColor: Theme.of(context).textTheme.titleLarge!.color!,
                  backGroundColor: Theme.of(context).primaryColor,
                  headingText: "Defence",
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Defence Rating:",
                      style: styleBodyTextTheme,
                    ),
                    DropDownIndexedWidget(
                      value: widget.matchScoutingData.commIdDefenceRating,
                      title: null,
                      dropDownValues: listRatingsDefence,
                      onStateChanged: (String value) {
                        setState(
                          () {
                            widget.matchScoutingData.commIdDefenceRating =
                                value;
                            widget.onChange!(widget.matchScoutingData);
                          },
                        );
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Defence Type:",
                      style: styleBodyTextTheme,
                    ),
                    DropDownIndexedWidget(
                      value: widget.matchScoutingData.commIdDefenceType,
                      title: null,
                      dropDownValues: listDefenceType,
                      onStateChanged: (String value) {
                        setState(
                          () {
                            widget.matchScoutingData.commIdDefenceType = value;
                            widget.onChange!(widget.matchScoutingData);
                          },
                        );
                      },
                    ),
                  ],
                ),
                HeadingMain(
                  styleFontSize: styleTitleTextTheme!.fontSize!,
                  textColor: Theme.of(context).textTheme.titleLarge!.color!,
                  backGroundColor: Theme.of(context).primaryColor,
                  headingText: "Quick Ratings",
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Worked to a Strategy:",
                      style: styleBodyTextTheme,
                    ),
                    Switch(
                      value: widget.matchScoutingData.commFlStrategy!,
                      onChanged: (bool value) {
                        setState(() {
                          widget.matchScoutingData.commFlStrategy = value;
                          widget.onChange!(widget.matchScoutingData);
                        });
                      },
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Shuttle:",
                      style: styleBodyTextTheme,
                    ),
                    Switch(
                      value: widget.matchScoutingData.commFlShuttle!,
                      onChanged: (bool value) {
                        setState(() {
                          widget.matchScoutingData.commFlShuttle = value;
                          widget.onChange!(widget.matchScoutingData);
                        });
                      },
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Crash Recovery:",
                      style: styleBodyTextTheme,
                    ),
                    Switch(
                      value: widget.matchScoutingData.commFlRecovery!,
                      onChanged: (bool value) {
                        setState(() {
                          widget.matchScoutingData.commFlRecovery = value;
                          widget.onChange!(widget.matchScoutingData);
                        });
                      },
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "System Failure:",
                      style: styleBodyTextTheme,
                    ),
                    Switch(
                      value: widget.matchScoutingData.commFlFailure!,
                      onChanged: (bool value) {
                        setState(() {
                          widget.matchScoutingData.commFlFailure = value;
                          widget.onChange!(widget.matchScoutingData);
                        });
                      },
                    )
                  ],
                ),
                HeadingMain(
                  styleFontSize: styleTitleTextTheme!.fontSize!,
                  textColor: Theme.of(context).textTheme.titleLarge!.color!,
                  backGroundColor: Theme.of(context).primaryColor,
                  headingText: "Advice",
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Warning:",
                          style: styleBodyTextTheme,
                        ),
                        Text(
                          "(Scout Team Futher before Considering)",
                          style: TextStyle(fontSize: 10),
                        ),
                      ],
                    ),
                    Switch(
                      value: widget.matchScoutingData.commFlWarning!,
                      onChanged: (bool value) {
                        setState(() {
                          widget.matchScoutingData.commFlWarning = value;
                          widget.onChange!(widget.matchScoutingData);
                        });
                      },
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Highlight Team:",
                          style: styleBodyTextTheme,
                        ),
                        Text(
                          "(Consider Regardless of performance)",
                          style: TextStyle(fontSize: 10),
                        ),
                      ],
                    ),
                    Switch(
                      value: widget.matchScoutingData.commFlHighlight!,
                      onChanged: (bool value) {
                        setState(() {
                          widget.matchScoutingData.commFlHighlight = value;
                          widget.onChange!(widget.matchScoutingData);
                        });
                      },
                    ),
                  ],
                ),
              ]),
            ),
          ),
        ),
        FractionallySizedBox(
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
                  headingText: "Load Type",
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Intake Coral from Ground:",
                      style: styleBodyTextTheme,
                    ),
                    Switch(
                      value: widget.matchScoutingData.commFlIntakeGroundCoral!,
                      onChanged: (bool value) {
                        setState(() {
                          widget.matchScoutingData.commFlIntakeGroundCoral =
                              value;
                          widget.onChange!(widget.matchScoutingData);
                        });
                      },
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Intake from Station:",
                      style: styleBodyTextTheme,
                    ),
                    Switch(
                      value: widget.matchScoutingData.commFlIntakeStation!,
                      onChanged: (bool value) {
                        setState(() {
                          widget.matchScoutingData.commFlIntakeStation = value;
                          widget.onChange!(widget.matchScoutingData);
                        });
                      },
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Intake Algae from Ground:",
                      style: styleBodyTextTheme,
                    ),
                    Switch(
                      value: widget.matchScoutingData.commFlIntakeGroundAlgae!,
                      onChanged: (bool value) {
                        setState(() {
                          widget.matchScoutingData.commFlIntakeGroundAlgae =
                              value;
                          widget.onChange!(widget.matchScoutingData);
                        });
                      },
                    )
                  ],
                ),
              ]),
            ),
          ),
        ),
        FractionallySizedBox(
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
                    headingText: "Comments",
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(""),
                      Expanded(
                        child: TextField(
                          controller: _txtComments,
                          decoration: InputDecoration(
                            labelText: "Comments on Performance:",
                            //border: InputBorder.none,
                            isDense: true,
                            labelStyle: styleBodyTextTheme,
                          ),
                          onChanged: (String value) {
                            widget.matchScoutingData.commTxNotes = value;
                            widget.onChange!(widget.matchScoutingData);
                          },
                        ),
                      ),
                    ],
                  ),
                ]),
              ),
            )),
      ],
    );
  }
}
