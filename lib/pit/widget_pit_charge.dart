import 'package:flutter/material.dart';
import 'package:projectb/class/class_pitdata.dart';
import 'package:projectb/widgets/widget_counter.dart';
import 'package:projectb/widgets/widget_headingmain.dart';

import '../widgets/widget_row_heading.dart';

class PitCharge extends StatefulWidget {
  PitCharge({
    Key? key,
    required this.pitData,
    this.styleFontSize = 16,
    this.styleFontSizeHeadings = 18,
    this.styleFieldTxShootingMaxWidth = 300,
    this.onChanged,
    this.txChargeNotes,
    this.onExpanded,
  }) : super(key: key);

  final PitData pitData;
  final double styleFontSize;
  final double styleFontSizeHeadings;
  final double styleFieldTxShootingMaxWidth;
  final ValueChanged<PitData>? onChanged;
  final TextEditingController? txChargeNotes;
  final ValueChanged<bool>? onExpanded;

  @override
  _PitChargeState createState() => _PitChargeState();
}

class _PitChargeState extends State<PitCharge> {

  List<DropdownMenuItem<String>> listChargeBalanceType = [
    DropdownMenuItem(value: "1", child: Text("Auto")),
    DropdownMenuItem(value: "2", child: Text("Manual")),
    DropdownMenuItem(value: "3", child: Text("N/A")),
  ];

  @override
  Widget build(BuildContext context) {
    if (widget.pitData.flCharge == false) {
      return FractionallySizedBox(
        widthFactor: 0.99,
        child: Container(
          margin: const EdgeInsets.all(5.0),

          child: Container(
            padding: EdgeInsets.all(5.0),
            child: Column(children: <Widget>[
              HeadingMain(
                styleFontSize: widget.styleFontSize,
                headingText: "Charge Station",
                //backGroundColor: Colors.green,
              ),
              RowHeading(
                styleFontSize: widget.styleFontSize,
                text: "Climb Charge Station:",
                value: widget.pitData.flCharge,
                onChange: (bool value) {
                  setState(() {
                    widget.pitData.flCharge = value;
                    widget.onChanged!(widget.pitData);
                    widget.onExpanded!(true);
                  });
                },
              ),
            ]),
          ),
        ),
      );
    } else {
      return FractionallySizedBox(
        widthFactor: 0.99,
        child: Container(
          margin: const EdgeInsets.all(5.0),
          child: Container(
            padding: EdgeInsets.all(5.0),
            child: Column(children: <Widget>[
              HeadingMain(
                styleFontSize: widget.styleFontSize,
                headingText: "Charge Station",
                //backGroundColor: Colors.green,
              ),
              RowHeading(
                styleFontSize: widget.styleFontSize,
                text: "Climb Charge Station:",
                value: widget.pitData.flCharge,
                styleBackGroundColor: Colors.green,
                onChange: (bool value) {
                  setState(() {
                    widget.pitData.flCharge = value;
                    widget.onChanged!(widget.pitData);
                    widget.onExpanded!(true);
                  });
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Balance Charge Station:",
                    style: TextStyle(fontSize: widget.styleFontSize),
                  ),
                  Switch(
                    value: widget.pitData.flChargeBalance!,
                    onChanged: (bool value) {
                      setState(() {
                        widget.pitData.flChargeBalance = value;
                      });
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Type of Balance:",
                    style: TextStyle(fontSize: widget.styleFontSize),
                  ),
                  DropdownButton(
                    value: widget.pitData.idChargeBalanceType == null
                        ? null
                        : widget.pitData.idChargeBalanceType,
                    items: listChargeBalanceType,
                    onChanged: (item) {
                      setState(() {
                        widget.pitData.idChargeBalanceType = item as String?;
                        widget.onChanged!(widget.pitData);
                      });
                      print("idChargeBalanceType: " + widget.pitData.idChargeBalanceType!);
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Assists another Robot:",
                    style: TextStyle(fontSize: widget.styleFontSize),
                  ),
                  Switch(
                    value: widget.pitData.flChargeAssist!,
                    onChanged: (bool value) {
                      setState(() {
                        widget.pitData.flChargeAssist = value;
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
                    style: TextStyle(fontSize: widget.styleFontSize),
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                        maxWidth: widget.styleFieldTxShootingMaxWidth),
                    child: TextField(
                      controller: widget.txChargeNotes,
                      decoration: InputDecoration(
                          hintText:
                              'Charge Station Notes'),
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
}
