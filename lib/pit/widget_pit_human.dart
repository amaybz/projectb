import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projectb/class_pitdata.dart';
import 'package:projectb/widget_headingmain.dart';
import 'package:projectb/widget_row_heading.dart';

class PitHuman extends StatefulWidget {
  PitHuman({
    Key? key,
    required this.pitData,
    required this.numHumanAccuracy,
    this.styleFontSize = 16,
    this.styleFontSizeHeadings = 18,
    required this.onChanged,
    required this.onExpanded,
  }) : super(key: key);

  final PitData pitData;
  final double styleFontSize;
  final double styleFontSizeHeadings;
  final ValueChanged<PitData> onChanged;
  final ValueChanged<bool> onExpanded;
  final TextEditingController numHumanAccuracy;

  @override
  _PitHumanState createState() => _PitHumanState();
}

class _PitHumanState extends State<PitHuman> {
  @override
  Widget build(BuildContext context) {
    if (widget.pitData.flHuman == false) {
      return FractionallySizedBox(
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
                headingText: "Human Player",
                //backGroundColor: Colors.green,
              ),
              RowHeading(
                styleFontSize: widget.styleFontSize,
                text: "Trained Human Player?",
                value: widget.pitData.flHuman,
                onChange: (bool value) {
                  setState(() {
                    widget.pitData.flHuman = value;
                    widget.onChanged(widget.pitData);
                    widget.onExpanded(true);
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
                headingText: "Human Player",
                //backGroundColor: Colors.green,
              ),
              RowHeading(
                styleFontSize: widget.styleFontSize,
                text: "Trained Human Player?",
                value: widget.pitData.flHuman,
                styleBackGroundColor: Colors.green,
                onChange: (bool value) {
                  setState(() {
                    widget.pitData.flHuman = value;
                    widget.onChanged(widget.pitData);
                  });
                },
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text("Accuracy? (%):"),
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 60),
                  child: TextField(
                    controller: widget.numHumanAccuracy,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(hintText: '%'),
                    onChanged: (String text) {
                      setState(() {
                        try {
                          widget.pitData.intHumanAccuracy = int.parse(text);
                        } catch (e) {
                          widget.pitData.intHumanAccuracy = 0;
                          print("Error Converting numHumanAccuracy: " +
                              e.toString());
                        }
                        widget.onChanged(widget.pitData);
                      });
                    },
                  ),
                ),
              ]),
            ]),
          ),
        ),
      );
    }
  }
}
