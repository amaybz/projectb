import 'package:flutter/material.dart';
import 'package:projectb/class/class_macthscoutingdata.dart';
import 'package:projectb/widgets/widget_dropdown_indexed.dart';
import 'package:projectb/widgets/widget_headingmain.dart';

class RatingsTab extends StatefulWidget {
  const RatingsTab(
      {Key? key,
      required this.styleFontSize,
      required this.styleFontSizeHeadings,
      required this.matchScoutingData,
      this.onCommentsChanged,
      required this.onChange})
      : super(key: key);

  final double styleFontSize;
  final double styleFontSizeHeadings;
  final MatchScoutingData matchScoutingData;
  final ValueChanged<String>? onCommentsChanged;
  final ValueChanged<MatchScoutingData>? onChange;

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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FractionallySizedBox(
          widthFactor: 0.99,
          child: Container(
            margin: const EdgeInsets.all(5.0),
            child: Container(
              padding: EdgeInsets.all(5.0),
              child: Column(children: <Widget>[
                HeadingMain(
                  styleFontSize:
                      Theme.of(context).textTheme.titleLarge!.fontSize!,
                  textColor: Theme.of(context).textTheme.titleLarge!.color!,
                  backGroundColor: Theme.of(context).primaryColor,
                  headingText: "Drive",
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Drive Ability:",
                      style: TextStyle(fontSize: widget.styleFontSize),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Defence Rating:",
                      style: TextStyle(fontSize: widget.styleFontSize),
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
                HeadingMain(
                  styleFontSize:
                      Theme.of(context).textTheme.titleLarge!.fontSize!,
                  textColor: Theme.of(context).textTheme.titleLarge!.color!,
                  backGroundColor: Theme.of(context).primaryColor,
                  headingText: "Quick Ratings",
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Worked to a Strategy:",
                      style: TextStyle(fontSize: widget.styleFontSize),
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
                      "Assisted Robots:",
                      style: TextStyle(fontSize: widget.styleFontSize),
                    ),
                    Switch(
                      value: widget.matchScoutingData.commFlAssist!,
                      onChanged: (bool value) {
                        setState(() {
                          widget.matchScoutingData.commFlAssist = value;
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
                      "Shuttle Rings:",
                      style: TextStyle(fontSize: widget.styleFontSize),
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
                      "Recovered:",
                      style: TextStyle(fontSize: widget.styleFontSize),
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
                      style: TextStyle(fontSize: widget.styleFontSize),
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
                  styleFontSize:
                      Theme.of(context).textTheme.titleLarge!.fontSize!,
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
                          style: TextStyle(fontSize: widget.styleFontSize),
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
                          style: TextStyle(fontSize: widget.styleFontSize),
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
                  styleFontSize:
                      Theme.of(context).textTheme.titleLarge!.fontSize!,
                  textColor: Theme.of(context).textTheme.titleLarge!.color!,
                  backGroundColor: Theme.of(context).primaryColor,
                  headingText: "Load Type",
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Intake from Ground:",
                      style: TextStyle(fontSize: widget.styleFontSize),
                    ),
                    Switch(
                      value: widget.matchScoutingData.commFlIntakeGround!,
                      onChanged: (bool value) {
                        setState(() {
                          widget.matchScoutingData.commFlIntakeGround = value;
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
                      "Intake from Chute:",
                      style: TextStyle(fontSize: widget.styleFontSize),
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
                    styleFontSize:
                        Theme.of(context).textTheme.titleLarge!.fontSize!,
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
                            labelText: "Comments on Performance",
                            border: InputBorder.none,
                            isDense: true,
                            labelStyle:
                                TextStyle(fontSize: widget.styleFontSize),
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
