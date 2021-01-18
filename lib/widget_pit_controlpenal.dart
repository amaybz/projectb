import 'package:flutter/material.dart';
import 'package:projectb/class_pitdata.dart';
import 'package:projectb/widget_counter.dart';
import 'package:projectb/widget_headingmain.dart';
import 'package:projectb/widget_row_heading.dart';


class PitControlPanel extends StatefulWidget {

  PitControlPanel({
    Key key,
    @required this.pitData,
    this.styleFontSize = 16,
    this.styleFontSizeHeadings = 18,
    this.styleFieldPanelSensorMaxWidth = 300,
    this.onChanged,
    this.txPanelSensor,
  }) : super(key: key);

  final PitData pitData;
  final double styleFontSize;
  final double styleFontSizeHeadings;
  final double styleFieldPanelSensorMaxWidth;
  final ValueChanged<PitData> onChanged;
  final TextEditingController txPanelSensor;

  @override
  _PitControlPanelState createState() => _PitControlPanelState();
}

class _PitControlPanelState extends State<PitControlPanel> {
  @override
  Widget build(BuildContext context) {
    if (widget.pitData.flPanel == false) {
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
                headingText: "Control Panel",
                //backGroundColor: Colors.green,
              ),
              RowHeading(
                styleFontSize: widget.styleFontSize,
                text: "Can manipulate control panel?",
                value: widget.pitData.flPanel,
                onChange: (bool value) {
                  setState(() {
                    widget.pitData.flPanel = value;
                    widget.onChanged(widget.pitData);
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
                headingText: "Control Panel",
                //backGroundColor: Colors.green,
              ),
              RowHeading(
                styleFontSize: widget.styleFontSize,
                text: "Can manipulate control panel?",
                value: widget.pitData.flPanel,
                styleBackGroundColor: Colors.green,
                onChange: (bool value) {
                  setState(() {
                    widget.pitData.flPanel = value;
                    widget.onChanged(widget.pitData);
                  });
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Brakes?:",
                    style: TextStyle(fontSize: widget.styleFontSize),
                  ),
                  Switch(
                    value: widget.pitData.flPanelBrake,
                    onChanged: (bool value) {
                      setState(() {
                        widget.pitData.flPanelBrake = value;
                        widget.onChanged(widget.pitData);
                      });
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Rotation Control?:",
                    style: TextStyle(fontSize: widget.styleFontSize),
                  ),
                  Switch(
                    value: widget.pitData.flPanelRotation,
                    onChanged: (bool value) {
                      setState(() {
                        widget.pitData.flPanelRotation = value;
                        widget.onChanged(widget.pitData);
                      });
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Position Control?:",
                    style: TextStyle(fontSize: widget.styleFontSize),
                  ),
                  Switch(
                    value: widget.pitData.flPanelPos,
                    onChanged: (bool value) {
                      setState(() {
                        widget.pitData.flPanelPos = value;
                        widget.onChanged(widget.pitData);
                      });
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Sensor?:",
                    style: TextStyle(fontSize: widget.styleFontSize),
                  ),
                  Switch(
                    value: widget.pitData.flPanelSensor,
                    onChanged: (bool value) {
                      setState(() {
                        widget.pitData.flPanelSensor = value;
                        widget.onChanged(widget.pitData);
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
                          maxWidth: widget.styleFieldPanelSensorMaxWidth),
                      child: TextField(
                        controller: widget.txPanelSensor,
                        decoration: InputDecoration(
                            hintText: 'What kind of sensor etc'),
                        onChanged: (String text) {
                          setState(() {
                            widget.pitData.txClimb = text;
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
