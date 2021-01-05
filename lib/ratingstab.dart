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
    this.onAssistOtherRobotChanged,
    this.onWorkedWithAllianceChanged,
    this.onWorkedToStrategyChanged,
    this.onSelectedDriveRatingChanged,
    this.onSelectedDefenceRatingChanged,
    this.onNoTeamWorkChanged,
    this.onRecoveredChanged,
    this.selectedDriveRating,
    this.selectedDefenceRating,

  }) : super(key: key);

  final ValueChanged<bool> onAssistOtherRobotChanged;
  final ValueChanged<bool> onWorkedWithAllianceChanged;
  final ValueChanged<bool> onWorkedToStrategyChanged;
  final ValueChanged<bool> onRecoveredChanged;
  final ValueChanged<bool> onNoTeamWorkChanged;
  final ValueChanged<String> onSelectedDriveRatingChanged;
  final ValueChanged<String> onSelectedDefenceRatingChanged;
  final bool assistOtherRobot;
  final bool workedWithAlliance;
  final bool workedToStrategy;
  final bool noTeamWork;
  final bool recovered;
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
      ],
    );
  }
}
