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
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.99,
      child: Container(
        padding: EdgeInsets.all(1.0),
        child: Column(children: <Widget>[
          HeadingMain(
              headingText: "Human",
              styleFontSize: widget.styleFontSizeHeadings),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              "Spotlight:",
              style: TextStyle(fontSize: widget.styleFontSizeBody),
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
