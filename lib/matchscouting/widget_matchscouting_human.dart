import 'package:flutter/material.dart';
import 'package:projectb/class/class_macthscoutingdata.dart';

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
    required this.matchScoutingData,
  }) : super(key: key);

  final ValueChanged<MatchScoutingData>? onChange;
  final MatchScoutingData matchScoutingData;
  final double styleFontSizeBody;
  final double styleFontSizeHeadings;
  final double styleImgFieldWidth;

  @override
  _HumanWidgetState createState() => _HumanWidgetState();
}

class _HumanWidgetState extends State<HumanWidget> {
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
              "Spotlight:",
              style: styleBodyTextTheme,
            ),
            Switch(
                value: widget.matchScoutingData.teleFlSpotlight!,
                onChanged: (item) {
                  setState(() {
                    widget.matchScoutingData.teleFlSpotlight = item;
                    widget.onChange!(widget.matchScoutingData);
                  });
                }),
          ]),
        ]),
      ),
    );
  }
}
