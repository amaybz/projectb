import 'package:flutter/material.dart';
import 'package:projectb/class/class_macthscoutingdata.dart';

import '../widgets/widget_headingmain.dart';

class ChargeStation extends StatefulWidget {
  ChargeStation(
      {Key? key,
      required this.matchScoutingData,
      this.styleFontSize = 16,
      this.styleFontSizeHeadings = 18,
      this.styleFieldTxClimbMaxWidth = 300,
      this.onChanged,
      this.txClimb,
      this.onExpanded})
      : super(key: key);

  final MatchScoutingData matchScoutingData;
  final double styleFontSize;
  final double styleFontSizeHeadings;
  final double styleFieldTxClimbMaxWidth;
  final ValueChanged<MatchScoutingData>? onChanged;
  final ValueChanged<bool>? onExpanded;
  final TextEditingController? txClimb;

  @override
  _ChargeStationState createState() => _ChargeStationState();
}

class _ChargeStationState extends State<ChargeStation> {
  List<DropdownMenuItem<String>> ddsSpeed = [
    DropdownMenuItem(value: "1", child: Text("NA")),
    DropdownMenuItem(value: "2", child: Text("Slow (> 7 Secs)")),
    DropdownMenuItem(value: "3", child: Text("Medium (3-7 Secs)")),
    DropdownMenuItem(value: "4", child: Text("Fast <3 Secs")),
  ];

  List<DropdownMenuItem<String>> ddsPosition = [
    DropdownMenuItem(value: "1", child: Text("NA")),
    DropdownMenuItem(value: "2", child: Text("Failed")),
    DropdownMenuItem(value: "3", child: Text("Docked")),
    DropdownMenuItem(value: "4", child: Text("Engaged")),
  ];

  List<DropdownMenuItem<String>> listSuccessFailNA = [
    DropdownMenuItem(value: "1", child: Text("NA")),
    DropdownMenuItem(value: "2", child: Text("Fail")),
    DropdownMenuItem(value: "3", child: Text("Success")),
  ];

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.99,
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(children: <Widget>[
          HeadingMain(
            styleFontSize: widget.styleFontSizeHeadings,
            headingText: "Charge Station",
            //backGroundColor: Colors.green,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "Charge Station Outcome:",
                style: TextStyle(fontSize: widget.styleFontSize),
              ),
              DropdownButton(
                value: widget.matchScoutingData.autoIdChargeOutcome == null
                    ? null
                    : widget.matchScoutingData.autoIdChargeOutcome,
                items: ddsPosition,
                onChanged: (item) {
                  setState(() {
                    widget.matchScoutingData.autoIdChargeOutcome =
                        item as String?;
                    widget.onChanged!(widget.matchScoutingData);
                  });
                  print("autoIdChargeOutcome: " +
                      widget.matchScoutingData.autoIdChargeOutcome!);
                },
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
