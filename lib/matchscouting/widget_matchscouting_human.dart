import 'package:flutter/material.dart';
import 'package:projectb/class/class_macthscoutingdata.dart';

import '../localdb.dart';
import '../widgets/widget_counter.dart';
import '../widgets/widget_headingmain.dart';

class HumanWidget extends StatefulWidget {
  const HumanWidget({
    Key? key,
    //onchange
    this.onChange,
    //style
    this.styleFontSizeBody = 16,
    this.styleFontSizeHeadings = 18,
    this.styleImgFieldWidth = 150,
    this.styleCounterButtonHeight = 25,
    this.styleCounterButtonWidth = 30,
    this.styleFieldTeamMaxWidth = 200,
    required this.matchScoutingData,
    required this.eventTeamsListDropDown,
    required this.eventTeams,
  }) : super(key: key);

  final ValueChanged<MatchScoutingData>? onChange;
  final MatchScoutingData matchScoutingData;
  final double styleFontSizeBody;
  final double styleFontSizeHeadings;
  final double styleImgFieldWidth;
  final double styleCounterButtonHeight;
  final double styleCounterButtonWidth;
  final double styleFieldTeamMaxWidth;
  final List<DropdownMenuItem<String>> eventTeamsListDropDown;
  final List<LocalTeam>? eventTeams;

  @override
  _HumanWidgetState createState() => _HumanWidgetState();
}

class _HumanWidgetState extends State<HumanWidget> {
  TextStyle? styleBodyTextTheme = ThemeData().textTheme.bodyMedium;
  TextStyle? styleTitleTextTheme = ThemeData().textTheme.titleMedium;
  LocalTeam? selectedTeam;

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
        child: Column(children: <Widget>[
          HeadingMain(
            headingText: "Human",
            styleFontSize: styleTitleTextTheme!.fontSize!,
            textColor: Theme.of(context).textTheme.titleLarge!.color!,
            backGroundColor: Theme.of(context).primaryColor,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              "Human Team:",
              style: TextStyle(fontSize: styleBodyTextTheme!.fontSize!),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(
                  maxHeight: 200, maxWidth: widget.styleFieldTeamMaxWidth),
              child: DropdownButton(
                isExpanded: true,
                isDense: false,
                style: styleBodyTextTheme,
                value: selectedTeam == null ? null : selectedTeam?.key,
                //title: "Team",
                items: widget.eventTeamsListDropDown,
                onChanged: (item) {
                  setState(() {
                    selectedTeam = widget.eventTeams!.firstWhere(
                        (team) => team.key == item,
                        orElse: () => widget.eventTeams!.first);
                    widget.matchScoutingData.teleHumanIdTeam =
                        selectedTeam?.teamNumber.toString();
                  });
                  print("teleHumanIdTeam: " +
                      widget.matchScoutingData.teleHumanIdTeam!);
                },
              ),
            ),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              "#Algae in Barge?:",
              style: styleBodyTextTheme,
            ),
            CounterWidget(
              styleButtonHeight: widget.styleCounterButtonHeight,
              styleButtonWidth: widget.styleCounterButtonWidth,
              title: "",
              value: widget.matchScoutingData.teleIntAlgaeBarge,
              onIncreaseStateChanged: (int value) {
                setState(() {
                  widget.matchScoutingData.teleIntAlgaeBarge =
                      widget.matchScoutingData.teleIntAlgaeBarge! + 1;
                  widget.onChange!(widget.matchScoutingData);
                });
              },
              onDecreaseStateChanged: (int value) {
                setState(() {
                  widget.matchScoutingData.teleIntAlgaeBarge =
                      widget.matchScoutingData.teleIntAlgaeBarge! - 1;
                  if (widget.matchScoutingData.teleIntAlgaeBarge! < 0) {
                    widget.matchScoutingData.teleIntAlgaeBarge = 0;
                  }
                  widget.onChange!(widget.matchScoutingData);
                });
              },
              onSetValue: (int value) {
                setState(() {
                  widget.matchScoutingData.teleIntAlgaeBarge = value;
                  widget.onChange!(widget.matchScoutingData);
                });
              },
            ),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              "#Algae in Processor?:",
              style: styleBodyTextTheme,
            ),
            CounterWidget(
              styleButtonHeight: widget.styleCounterButtonHeight,
              styleButtonWidth: widget.styleCounterButtonWidth,
              title: "",
              value: widget.matchScoutingData.teleIntAlgaeProcess,
              onIncreaseStateChanged: (int value) {
                setState(() {
                  widget.matchScoutingData.teleIntAlgaeProcess =
                      widget.matchScoutingData.teleIntAlgaeProcess! + 1;
                  widget.onChange!(widget.matchScoutingData);
                });
              },
              onDecreaseStateChanged: (int value) {
                setState(() {
                  widget.matchScoutingData.teleIntAlgaeProcess =
                      widget.matchScoutingData.teleIntAlgaeProcess! - 1;
                  if (widget.matchScoutingData.teleIntAlgaeProcess! < 0) {
                    widget.matchScoutingData.teleIntAlgaeProcess = 0;
                  }
                  widget.onChange!(widget.matchScoutingData);
                });
              },
              onSetValue: (int value) {
                setState(() {
                  widget.matchScoutingData.teleIntAlgaeProcess = value;
                  widget.onChange!(widget.matchScoutingData);
                });
              },
            ),
          ]),
        ]),
      ),
    );
  }
}
