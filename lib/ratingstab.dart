import 'package:flutter/material.dart';
import 'package:projectb/dropdown_widget.dart';

class RatingsTab extends StatefulWidget {
  const RatingsTab({
    Key key,
    //@required this.styleImgFieldWidth,
    this.assistOtherRobot = false,
    this.workedWithAlliance = false,
    this.workedToStrategy = false,
    this.noTeamWork = false,
    this.recovered = false,
    this.highIntake = false,
    this.groundIntake = false,
    this.otherRobot = false,
    this.shootingWall = false,
    this.shootingNearZone = false,
    this.shootingMidZone = false,
    this.shootingFarZone = false,
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
    this.selectedDriveRating,
    this.selectedDefenceRating,
  }) : super(key: key);

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
  final ValueChanged<String> onSelectedDriveRatingChanged;
  final ValueChanged<String> onSelectedDefenceRatingChanged;
  final bool assistOtherRobot;
  final bool shootingWall;
  final bool shootingNearZone;
  final bool shootingMidZone;
  final bool shootingFarZone;
  final bool workedWithAlliance;
  final bool workedToStrategy;
  final bool noTeamWork;
  final bool recovered;
  final bool groundIntake;
  final bool highIntake;
  final bool otherRobot;
  final String selectedDriveRating;
  final String selectedDefenceRating;

  @override
  _RatingsTabState createState() => _RatingsTabState();
}

class _RatingsTabState extends State<RatingsTab> {
  //lists
  final List<String> listRatings = [
    'Poor',
    'Average',
    'Good',
    'Amazing',
  ];

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
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    color: Colors.grey,
                  ),
                  child: Text(
                    "Quick Ratings",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Drive Rating:"),
                    DropDownWidget(
                      value: widget.selectedDriveRating,
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
                    Text("Defence Rating:"),
                    DropDownWidget(
                      value: widget.selectedDefenceRating,
                      title: null,
                      list: listRatings,
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
                    Text("Assist Other Robot:"),
                    Switch(
                      value: widget.assistOtherRobot,
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
                    Text("Worked with Alliance:"),
                    Switch(
                      value: widget.workedWithAlliance,
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
                    Text("Worked to a Strategy:"),
                    Switch(
                      value: widget.workedToStrategy,
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
                    Text("Recovered:"),
                    Switch(
                      value: widget.recovered,
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
                    Text("No Teamwork:"),
                    Switch(
                      value: widget.noTeamWork,
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
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      color: Colors.grey,
                    ),
                    child: Text(
                      "Intake",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Ground Intake:"),
                      Switch(
                        value: widget.groundIntake,
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
                      Text("High Intake:"),
                      Switch(
                        value: widget.highIntake,
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
                      Text("Other Robot:"),
                      Switch(
                        value: widget.otherRobot,
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
            ),),
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
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      color: Colors.grey,
                    ),
                    child: Text(
                      "Shooting",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Wall:"),
                      Switch(
                        value: widget.shootingWall,
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
                      Text("Near Zone:"),
                      Switch(
                        value: widget.shootingNearZone,
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
                      Text("Mid Zone:"),
                      Switch(
                        value: widget.shootingMidZone,
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
                      Text("Far Zone:"),
                      Switch(
                        value: widget.shootingFarZone,
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
      ],
    );
  }
}