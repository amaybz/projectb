import 'package:flutter/material.dart';
import 'package:projectb/widget_dropdown.dart';
import 'package:projectb/localdb.dart';
import 'package:projectb/widget_headingmain.dart';

class RatingsTab extends StatefulWidget {
  const RatingsTab(
      {Key key,
      @required this.styleFontSize,
      @required this.styleFontSizeHeadings,
      this.matchScoutingData,
      this.onAssistOtherRobotChanged,
      this.onWorkedWithAllianceChanged,
      this.onWorkedToStrategyChanged,
      this.onSelectedDriveRatingChanged,
      this.onSelectedDefenceRatingChanged,
      this.onGroundIntakeChanged,
      this.onHighIntakeChanged,
      this.onOtherRobotChanged,
      this.onNoTeamWorkChanged,
      this.onRecoveredChanged,
      this.onShootingFarZoneChanged,
      this.onShootingMidZoneChanged,
      this.onShootingNearZoneChanged,
      this.onShootingWallZoneChanged,
      this.onHighlightTeamChanged,
      this.onWarningChanged,
      this.onCommentsChanged})
      : super(key: key);

  final double styleFontSize;
  final double styleFontSizeHeadings;
  final MatchScoutingData matchScoutingData;
  final ValueChanged<bool> onAssistOtherRobotChanged;
  final ValueChanged<bool> onWorkedWithAllianceChanged;
  final ValueChanged<bool> onWorkedToStrategyChanged;
  final ValueChanged<bool> onRecoveredChanged;
  final ValueChanged<bool> onNoTeamWorkChanged;
  final ValueChanged<bool> onGroundIntakeChanged;
  final ValueChanged<bool> onHighIntakeChanged;
  final ValueChanged<bool> onOtherRobotChanged;
  final ValueChanged<bool> onShootingWallZoneChanged;
  final ValueChanged<bool> onShootingNearZoneChanged;
  final ValueChanged<bool> onShootingMidZoneChanged;
  final ValueChanged<bool> onShootingFarZoneChanged;
  final ValueChanged<bool> onHighlightTeamChanged;
  final ValueChanged<bool> onWarningChanged;
  final ValueChanged<String> onSelectedDriveRatingChanged;
  final ValueChanged<String> onSelectedDefenceRatingChanged;
  final ValueChanged<String> onCommentsChanged;

  @override
  _RatingsTabState createState() => _RatingsTabState();
}

class _RatingsTabState extends State<RatingsTab> {
  //lists
  final List<String> listRatings = [
    'Terrible',
    'Average',
    'Good',
    'Amazing',
  ];

  final List<String> listRatingsDefence = [
    'N/A',
    'Weak',
    'Harassment',
    'Game Changing',
  ];

  final TextEditingController _txtComments = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Call the getJSONData() method when the app initializes
    //_getScoringData();
    updateValues();
  }

  updateValues() {
    setState(() {
      _txtComments.text = widget.matchScoutingData.commTxNotes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FractionallySizedBox(
          widthFactor: 0.99,
          child: Container(
            margin: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
            ),
            child: Container(
              padding: EdgeInsets.all(5.0),
              child: Column(children: <Widget>[
                HeadingMain(
                  styleFontSize: widget.styleFontSizeHeadings,
                  headingText: "Quick Ratings",
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Drive Rating:",
                      style: TextStyle(fontSize: widget.styleFontSize),
                    ),
                    DropDownWidget(
                      value: widget.matchScoutingData.commIdDriveRating,
                      title: null,
                      list: listRatings,
                      onStateChanged: (String value) {
                        setState(
                          () {
                            widget.onSelectedDriveRatingChanged(value);
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
                    DropDownWidget(
                      value: widget.matchScoutingData.commIdDefenceRating,
                      title: null,
                      list: listRatingsDefence,
                      onStateChanged: (String value) {
                        setState(
                          () {
                            widget.onSelectedDefenceRatingChanged(value);
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
                      "Assist Other Robot:",
                      style: TextStyle(fontSize: widget.styleFontSize),
                    ),
                    Switch(
                      value: widget.matchScoutingData.commFlAssist,
                      onChanged: (bool value) {
                        setState(() {
                          widget.onAssistOtherRobotChanged(value);
                        });
                      },
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Worked with Alliance:",
                      style: TextStyle(fontSize: widget.styleFontSize),
                    ),
                    Switch(
                      value: widget
                          .matchScoutingData.commFlAlliance,
                      onChanged: (bool value) {
                        setState(() {
                          widget.onWorkedWithAllianceChanged(value);
                        });
                      },
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Worked to a Strategy:",
                      style: TextStyle(fontSize: widget.styleFontSize),
                    ),
                    Switch(
                      value: widget
                          .matchScoutingData.commFlStrategy,
                      onChanged: (bool value) {
                        setState(() {
                          widget.onWorkedToStrategyChanged(value);
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
                      value: widget.matchScoutingData.commFlRecovery,
                      onChanged: (bool value) {
                        setState(() {
                          widget.onRecoveredChanged(value);
                        });
                      },
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "No Teamwork:",
                      style: TextStyle(fontSize: widget.styleFontSize),
                    ),
                    Switch(
                      value: widget.matchScoutingData.commFlOwnThing,
                      onChanged: (bool value) {
                        setState(() {
                          widget.onNoTeamWorkChanged(value);
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
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
            ),
            child: Container(
              padding: EdgeInsets.all(5.0),
              child: Column(children: <Widget>[
                HeadingMain(
                  styleFontSize: widget.styleFontSizeHeadings,
                  headingText: "Intake",
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Ground Intake:",
                      style: TextStyle(fontSize: widget.styleFontSize),
                    ),
                    Switch(
                      value: widget.matchScoutingData.commFlIntakeGround,
                      onChanged: (bool value) {
                        setState(() {
                          widget.onGroundIntakeChanged(value);
                        });
                      },
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "High Intake:",
                      style: TextStyle(fontSize: widget.styleFontSize),
                    ),
                    Switch(
                      value: widget.matchScoutingData.commFlIntakeHigh,
                      onChanged: (bool value) {
                        setState(() {
                          widget.onHighIntakeChanged(value);
                        });
                      },
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Other Robot:",
                      style: TextStyle(fontSize: widget.styleFontSize),
                    ),
                    Switch(
                      value: widget.matchScoutingData.commFlIntakeRobot,
                      onChanged: (bool value) {
                        setState(() {
                          widget.onOtherRobotChanged(value);
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
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
              ),
              child: Container(
                padding: EdgeInsets.all(5.0),
                child: Column(children: <Widget>[
                  HeadingMain(
                    styleFontSize: widget.styleFontSizeHeadings,
                    headingText: "Shooting",
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Wall:",
                        style: TextStyle(fontSize: widget.styleFontSize),
                      ),
                      Switch(
                        value: widget.matchScoutingData.commFlShotWall,
                        onChanged: (bool value) {
                          setState(() {
                            widget.onShootingWallZoneChanged(value);
                          });
                        },
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Near Zone:",
                        style: TextStyle(fontSize: widget.styleFontSize),
                      ),
                      Switch(
                        value: widget.matchScoutingData.commFlShotNear,
                        onChanged: (bool value) {
                          setState(() {
                            widget.onShootingNearZoneChanged(value);
                          });
                        },
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Mid Zone:",
                        style: TextStyle(fontSize: widget.styleFontSize),
                      ),
                      Switch(
                        value: widget.matchScoutingData.commFlShotMid,
                        onChanged: (bool value) {
                          setState(() {
                            widget.onShootingMidZoneChanged(value);
                          });
                        },
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Far Zone:",
                        style: TextStyle(fontSize: widget.styleFontSize),
                      ),
                      Switch(
                        value: widget.matchScoutingData.commFlShotFar,
                        onChanged: (bool value) {
                          setState(() {
                            widget.onShootingFarZoneChanged(value);
                          });
                        },
                      )
                    ],
                  ),
                ]),
              ),
            )),
        FractionallySizedBox(
            widthFactor: 0.99,
            child: Container(
              margin: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
              ),
              child: Container(
                padding: EdgeInsets.all(5.0),
                child: Column(children: <Widget>[
                  HeadingMain(
                    styleFontSize: widget.styleFontSizeHeadings,
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
                            widget.onCommentsChanged(value);
                          },
                        ),
                      ),
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
                      ],),
                      Switch(
                        value: widget.matchScoutingData.commFlHighlight,
                        onChanged: (bool value) {
                          setState(() {
                            widget.onHighlightTeamChanged(value);
                          });
                        },
                      ),
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
                            "Warning:",
                            style: TextStyle(fontSize: widget.styleFontSize),
                          ),
                          Text(
                            "(Scout Team Futher before Considering)",
                            style: TextStyle(fontSize: 10),
                          ),
                        ],),
                      Switch(
                        value: widget.matchScoutingData.commFlWarning,
                        onChanged: (bool value) {
                          setState(() {
                            widget.onWarningChanged(value);
                          });
                        },
                      )
                    ],
                  ),
                ]),
              ),
            )),
      ],
    );
  }
}
