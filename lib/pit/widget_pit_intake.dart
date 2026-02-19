import 'package:flutter/material.dart';
import 'package:projectb/class/class_pitdata.dart';
import 'package:projectb/widgets/widget_headingmain.dart';

class PitIntake extends StatefulWidget {
  PitIntake({
    Key? key,
    required this.pitData,
    this.styleFontSize = 16,
    this.styleFontSizeHeadings = 18,
    this.styleFieldTxShootingMaxWidth = 300,
    this.onChanged,
    this.txNotes,
    this.onExpanded,
  }) : super(key: key);

  final PitData pitData;
  final double styleFontSize;
  final double styleFontSizeHeadings;
  final double styleFieldTxShootingMaxWidth;
  final ValueChanged<PitData>? onChanged;
  final TextEditingController? txNotes;
  final ValueChanged<bool>? onExpanded;

  @override
  _PitIntakeState createState() => _PitIntakeState();
}

class _PitIntakeState extends State<PitIntake> {
  TextStyle? styleBodyTextTheme = ThemeData().textTheme.bodyMedium;
  TextStyle? styleTitleTextTheme = ThemeData().textTheme.titleMedium;

  List<DropdownMenuItem<String>> listCapacity = [
    DropdownMenuItem(value: "1", child: Text("N/A")),
    DropdownMenuItem(value: "2", child: Text("8 or less")),
    DropdownMenuItem(value: "3", child: Text("8-15")),
    DropdownMenuItem(value: "4", child: Text("15-20")),
    DropdownMenuItem(value: "5", child: Text("20-25")),
    DropdownMenuItem(value: "6", child: Text("25-30")),
    DropdownMenuItem(value: "7", child: Text("30-40")),
    DropdownMenuItem(value: "8", child: Text("40-50")),
    DropdownMenuItem(value: "9", child: Text("50+")),
  ];

  List<DropdownMenuItem<String>> listThroughput = [
    DropdownMenuItem(value: "1", child: Text("N/A")),
    DropdownMenuItem(value: "2", child: Text("<1/sec")),
    DropdownMenuItem(value: "3", child: Text("1/sec")),
    DropdownMenuItem(value: "4", child: Text("2-5/sec")),
    DropdownMenuItem(value: "5", child: Text("5+/sec")),
  ];

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
        margin: const EdgeInsets.all(5.0),
        child: Container(
          padding: EdgeInsets.all(5.0),
          child: Column(
            children: <Widget>[
              HeadingMain(
                styleFontSize: styleTitleTextTheme!.fontSize!,
                textColor: Theme.of(context).textTheme.titleLarge!.color!,
                backGroundColor: Theme.of(context).primaryColor,
                headingText: "Intake",
                //backGroundColor: Colors.green,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Use Fuel?:", style: styleBodyTextTheme),
                  Switch(
                    value: widget.pitData.pitFlObject!,
                    onChanged: (bool value) {
                      setState(() {
                        widget.pitData.pitFlObject = value;
                        widget.onChanged!(widget.pitData);
                      });
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Catch?:", style: styleBodyTextTheme),
                  Switch(
                    value: widget.pitData.pitFlObjectCatch!,
                    onChanged: (bool value) {
                      setState(() {
                        widget.pitData.pitFlObjectCatch = value;
                        widget.onChanged!(widget.pitData);
                      });
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Floor Pickup (Fuel):", style: styleBodyTextTheme),
                  Switch(
                    value: widget.pitData.pitFlObjectFloor!,
                    onChanged: (bool value) {
                      setState(() {
                        widget.pitData.pitFlObjectFloor = value;
                      });
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text("Capacity:", style: styleBodyTextTheme),
                  DropdownButton(
                    value: widget.pitData.pitIdCapacity == null
                        ? null
                        : widget.pitData.pitIdCapacity,
                    items: listCapacity,
                    style: styleBodyTextTheme,
                    onChanged: (item) {
                      setState(() {
                        widget.pitData.pitIdCapacity = item;
                        widget.onChanged!(widget.pitData);
                      });
                      print("pitIdCapacity: " + widget.pitData.pitIdCapacity!);
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text("Throughput:", style: styleBodyTextTheme),
                  DropdownButton(
                    value: widget.pitData.pitIdThrough == null
                        ? null
                        : widget.pitData.pitIdThrough,
                    items: listThroughput,
                    style: styleBodyTextTheme,
                    onChanged: (item) {
                      setState(() {
                        widget.pitData.pitIdThrough = item;
                        widget.onChanged!(widget.pitData);
                      });
                      print("pitIdCapacity: " + widget.pitData.pitIdThrough!);
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Notes: ", style: styleBodyTextTheme),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: widget.styleFieldTxShootingMaxWidth,
                    ),
                    child: TextField(
                      controller: widget.txNotes,
                      style: styleBodyTextTheme,
                      decoration: InputDecoration(
                        hintText: 'Notes on intake system(s)',
                        hintStyle: styleBodyTextTheme?.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
