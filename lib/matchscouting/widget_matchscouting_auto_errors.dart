import 'package:flutter/material.dart';
import 'package:projectb/class/class_macthscoutingdata.dart';
import '../widgets/widget_headingmain.dart';

class MatchAutoErrors extends StatefulWidget {
  MatchAutoErrors({
    Key? key,
    required this.matchScoutingData,
    this.styleFontSize = 16,
    this.styleFontSizeHeadings = 18,
    this.styleCounterButtonHeight = 25,
    this.styleCounterButtonWidth = 30,
    this.onChanged,
    this.onExpanded,
  }) : super(key: key);

  final MatchScoutingData matchScoutingData;
  final double styleFontSize;
  final double styleFontSizeHeadings;
  final double styleCounterButtonHeight;
  final double styleCounterButtonWidth;
  final ValueChanged<MatchScoutingData>? onChanged;
  final ValueChanged<bool>? onExpanded;

  @override
  _MatchAutoErrorsState createState() => _MatchAutoErrorsState();
}

class _MatchAutoErrorsState extends State<MatchAutoErrors> {
  TextStyle? styleBodyTextTheme = ThemeData().textTheme.bodyMedium;
  TextStyle? styleTitleTextTheme = ThemeData().textTheme.titleMedium;

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
        padding: EdgeInsets.all(4.0),
        margin: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(),
        child: Column(children: <Widget>[
          HeadingMain(
            styleFontSize: styleTitleTextTheme!.fontSize!,
            textColor: Theme.of(context).textTheme.titleLarge!.color!,
            backGroundColor: Theme.of(context).primaryColor,
            headingText: "Errors",
            //backGroundColor: Colors.green,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.all(5.0),
                child: Text(
                  "Foul",
                  style: styleBodyTextTheme,
                ),
              ),
              Switch(
                value: widget.matchScoutingData.autoFlFoul!,
                onChanged: (bool value) {
                  setState(() {
                    widget.matchScoutingData.autoFlFoul = value;
                    widget.onChanged!(widget.matchScoutingData);
                  });
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.all(5.0),
                child: Text(
                  "Hit Robot",
                  style: styleBodyTextTheme,
                ),
              ),
              Switch(
                  value: widget.matchScoutingData.autoFlRobotContact!,
                  onChanged: (bool value) {
                    setState(() {
                      widget.matchScoutingData.autoFlRobotContact = value;
                      widget.onChanged!(widget.matchScoutingData);
                    });
                  }),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.all(5.0),
                child: Text(
                  "Lose Object",
                  style: styleBodyTextTheme,
                ),
              ),
              Switch(
                value: widget.matchScoutingData.autoFlLoseStartObject!,
                onChanged: (bool value) {
                  setState(() {
                    widget.matchScoutingData.autoFlLoseStartObject = value;
                    widget.onChanged!(widget.matchScoutingData);
                  });
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.all(5.0),
                child: Text(
                  "Crash",
                  style: styleBodyTextTheme,
                ),
              ),
              Switch(
                value: widget.matchScoutingData.autoFlFail!,
                onChanged: (bool value) {
                  setState(() {
                    widget.matchScoutingData.autoFlFail = value;
                    widget.onChanged!(widget.matchScoutingData);
                  });
                },
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
