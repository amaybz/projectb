import 'package:flutter/material.dart';
import 'package:projectb/class/class_pitdata.dart';
import 'package:projectb/widgets/widget_headingmain.dart';

class PitDriveBase extends StatefulWidget {
  PitDriveBase({
    Key? key,
    required this.pitData,
    this.styleFontSize = 16,
    this.styleFontSizeHeadings = 18,
    this.styleFieldCommentWidth = 300,
    required this.txDriveNotes,
    required this.onChanged,
    required this.onExpanded,
  }) : super(key: key);

  final PitData pitData;
  final double styleFontSize;
  final double styleFontSizeHeadings;
  final ValueChanged<PitData> onChanged;
  final ValueChanged<bool> onExpanded;
  final double styleFieldCommentWidth;
  final TextEditingController? txDriveNotes;

  @override
  _PitDriveBaseState createState() => _PitDriveBaseState();
}

class _PitDriveBaseState extends State<PitDriveBase> {
  TextStyle? styleBodyTextTheme = ThemeData().textTheme.bodyMedium;
  TextStyle? styleTitleTextTheme = ThemeData().textTheme.titleMedium;

  List<DropdownMenuItem<String>> listIdFieldAccess = [
    DropdownMenuItem(value: "1", child: Text("N/A")),
    DropdownMenuItem(value: "2", child: Text("Trench")),
    DropdownMenuItem(value: "3", child: Text("Bump")),
    DropdownMenuItem(value: "4", child: Text("Both")),
  ];

  getFieldAccessDropDownMenu(TextStyle textStyle) {
    listIdFieldAccess.clear();
    listIdFieldAccess.addAll([
      DropdownMenuItem(
        value: "1",
        child: Text("N/A", style: textStyle),
      ),
      DropdownMenuItem(
        value: "2",
        child: Text("Trench", style: textStyle),
      ),
      DropdownMenuItem(
        value: "3",
        child: Text("Bump", style: textStyle),
      ),
      DropdownMenuItem(
        value: "4",
        child: Text("Both", style: textStyle),
      ),
    ]);
  }

  List<DropdownMenuItem<String>> listIdDriveType = [
    DropdownMenuItem(value: "1", child: Text("N/A")),
    DropdownMenuItem(value: "2", child: Text("KOP")),
    DropdownMenuItem(value: "3", child: Text("Custom Tank")),
    DropdownMenuItem(value: "4", child: Text("Meccanum")),
    DropdownMenuItem(value: "5", child: Text("Swerve")),
    DropdownMenuItem(value: "6", child: Text("Other")),
  ];

  getDriveBaseDropDownMenu(TextStyle textStyle) {
    listIdDriveType.clear();
    listIdDriveType.addAll([
      DropdownMenuItem(
        value: "1",
        child: Text("N/A", style: textStyle),
      ),
      DropdownMenuItem(
        value: "2",
        child: Text("KOP", style: textStyle),
      ),
      DropdownMenuItem(
        value: "3",
        child: Text("Custom Tank", style: textStyle),
      ),
      DropdownMenuItem(
        value: "4",
        child: Text("Meccanum", style: textStyle),
      ),
      DropdownMenuItem(
        value: "5",
        child: Text("Swerve", style: textStyle),
      ),
      DropdownMenuItem(
        value: "6",
        child: Text("Other", style: textStyle),
      ),
    ]);
  }

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

    //getDriveBaseDropDownMenu(styleBodyTextTheme!);
    //getFieldAccessDropDownMenu(styleBodyTextTheme!);

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
                headingText: "Drivebase",
                //backGroundColor: Colors.green,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text("Driving Type:", style: styleBodyTextTheme),
                  DropdownButton(
                    value: widget.pitData.pitIdDriveType == null
                        ? null
                        : widget.pitData.pitIdDriveType,
                    items: listIdDriveType,
                    style: styleBodyTextTheme,
                    onChanged: (item) {
                      setState(() {
                        widget.pitData.pitIdDriveType = item as String?;
                        widget.onChanged(widget.pitData);
                      });
                      print("idDriveType: " + widget.pitData.pitIdDriveType!);
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text("Field Access:", style: styleBodyTextTheme),
                  DropdownButton(
                    value: widget.pitData.pitIdFieldAccess == null
                        ? null
                        : widget.pitData.pitIdFieldAccess,
                    items: listIdFieldAccess,
                    style: styleBodyTextTheme,
                    onChanged: (item) {
                      setState(() {
                        widget.pitData.pitIdFieldAccess = item as String?;
                        widget.onChanged(widget.pitData);
                      });
                      print(
                        "pitIdFieldAccess: " + widget.pitData.pitIdFieldAccess!,
                      );
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
                      maxWidth: widget.styleFieldCommentWidth,
                    ),
                    child: TextField(
                      controller: widget.txDriveNotes,
                      decoration: InputDecoration(
                        hintText: 'Notes on drive and control system',
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
