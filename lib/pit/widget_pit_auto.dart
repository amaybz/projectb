import 'package:flutter/material.dart';
import 'package:projectb/class/class_pitdata.dart';
import 'package:projectb/widgets/widget_headingmain.dart';
import 'package:projectb/widgets/widget_counter.dart';

import '../widgets/widget_row_heading.dart';

class PitAuto extends StatefulWidget {
  PitAuto(
      {Key? key,
      required this.pitData,
      this.styleFontSize = 16,
      this.styleFontSizeHeadings = 18,
      this.onChanged,
      this.onExpanded,
      this.txAutoNotes,
      this.strWeight = "lbs",
      this.strDistance = "inches"})
      : super(key: key);

  final PitData pitData;
  final double styleFontSize;
  final double styleFontSizeHeadings;
  final ValueChanged<PitData>? onChanged;
  final ValueChanged<bool>? onExpanded;
  final String strWeight;
  final String strDistance;
  final TextEditingController? txAutoNotes;

  @override
  _PitAutoState createState() => _PitAutoState();
}

class _PitAutoState extends State<PitAuto> {
  List<DropdownMenuItem<String>> listAutoScore = [
    DropdownMenuItem(value: "1", child: Text("N/A")),
  ];

  getAutoScoreDropDownMenu(TextStyle textStyle) {
    listAutoScore.clear();
    listAutoScore.addAll([
      DropdownMenuItem(
          value: "1",
          child: Text(
            "N/A",
            style: textStyle,
          )),
      DropdownMenuItem(
          value: "2",
          child: Text(
            "Amp",
            style: textStyle,
          )),
      DropdownMenuItem(
          value: "3",
          child: Text(
            "Speaker",
            style: textStyle,
          )),
      DropdownMenuItem(
          value: "4",
          child: Text(
            "All",
            style: textStyle,
          )),
    ]);
  }

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

    getAutoScoreDropDownMenu(styleBodyTextTheme!);

    if (widget.pitData.flAuto == false) {
      return FractionallySizedBox(
        widthFactor: 0.99,
        child: Container(
          margin: const EdgeInsets.all(5.0),
          child: Container(
            padding: EdgeInsets.all(5.0),
            child: Column(children: <Widget>[
              HeadingMain(
                styleFontSize: styleTitleTextTheme!.fontSize!,
                textColor: Theme.of(context).textTheme.titleLarge!.color!,
                backGroundColor: Theme.of(context).primaryColor,
                headingText: "Auto",
                //backGroundColor: Colors.green,
              ),
              RowHeading(
                styleFontSize: styleBodyTextTheme!.fontSize!,
                text: "Does Auto?",
                value: widget.pitData.flAuto,
                onChange: (bool value) {
                  setState(() {
                    widget.pitData.flAuto = value;
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
                styleFontSize: styleTitleTextTheme!.fontSize!,
                textColor: Theme.of(context).textTheme.titleLarge!.color!,
                backGroundColor: Theme.of(context).primaryColor,
                headingText: "Auto",
                //backGroundColor: Colors.green,
              ),
              RowHeading(
                styleFontSize: styleBodyTextTheme!.fontSize!,
                text: "Does Auto?",
                value: widget.pitData.flAuto,
                styleBackGroundColor: Colors.green,
                onChange: (bool value) {
                  setState(() {
                    widget.pitData.flAuto = value;
                    widget.onChanged!(widget.pitData);
                  });
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Leaves Line:",
                    style: styleBodyTextTheme,
                  ),
                  Switch(
                    value: widget.pitData.flAutoLine!,
                    onChanged: (bool value) {
                      setState(() {
                        widget.pitData.flAutoLine = value;
                        widget.onChanged!(widget.pitData);
                      });
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Score Coral:",
                    style: styleBodyTextTheme,
                  ),
                  Switch(
                    value: widget.pitData.flAutoScoreCoral!,
                    onChanged: (bool value) {
                      setState(() {
                        widget.pitData.flAutoScoreCoral = value;
                        widget.onChanged!(widget.pitData);
                      });
                    },
                  ),
                ],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                  "#Coral L1:",
                  style: styleBodyTextTheme,
                ),
                CounterWidget(
                  title: "",
                  styleFontSize: widget.styleFontSize,
                  value: widget.pitData.numAutoScoreCoralL1,
                  onIncreaseStateChanged: (int value) {
                    setState(() {
                      widget.pitData.numAutoScoreCoralL1 =
                          widget.pitData.numAutoScoreCoralL1! + 1;
                      widget.onChanged!(widget.pitData);
                    });
                  },
                  onDecreaseStateChanged: (int value) {
                    setState(() {
                      widget.pitData.numAutoScoreCoralL1 =
                          widget.pitData.numAutoScoreCoralL1! - 1;
                      if (widget.pitData.numAutoScoreCoralL1! < 0) {
                        widget.pitData.numAutoScoreCoralL1 = 0;
                      }
                      widget.onChanged!(widget.pitData);
                    });
                  },
                  onSetValue: (int value) {
                    setState(() {
                      widget.pitData.numAutoScoreCoralL1 = value;
                      widget.onChanged!(widget.pitData);
                    });
                  },
                ),
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                  "#Coral L2:",
                  style: styleBodyTextTheme,
                ),
                CounterWidget(
                  title: "",
                  styleFontSize: widget.styleFontSize,
                  value: widget.pitData.numAutoScoreCoralL2,
                  onIncreaseStateChanged: (int value) {
                    setState(() {
                      widget.pitData.numAutoScoreCoralL2 =
                          widget.pitData.numAutoScoreCoralL2! + 1;
                      widget.onChanged!(widget.pitData);
                    });
                  },
                  onDecreaseStateChanged: (int value) {
                    setState(() {
                      widget.pitData.numAutoScoreCoralL2 =
                          widget.pitData.numAutoScoreCoralL2! - 1;
                      if (widget.pitData.numAutoScoreCoralL2! < 0) {
                        widget.pitData.numAutoScoreCoralL2 = 0;
                      }
                      widget.onChanged!(widget.pitData);
                    });
                  },
                  onSetValue: (int value) {
                    setState(() {
                      widget.pitData.numAutoScoreCoralL2 = value;
                      widget.onChanged!(widget.pitData);
                    });
                  },
                ),
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                  "#Coral L3:",
                  style: styleBodyTextTheme,
                ),
                CounterWidget(
                  title: "",
                  styleFontSize: widget.styleFontSize,
                  value: widget.pitData.numAutoScoreCoralL3,
                  onIncreaseStateChanged: (int value) {
                    setState(() {
                      widget.pitData.numAutoScoreCoralL3 =
                          widget.pitData.numAutoScoreCoralL3! + 1;
                      widget.onChanged!(widget.pitData);
                    });
                  },
                  onDecreaseStateChanged: (int value) {
                    setState(() {
                      widget.pitData.numAutoScoreCoralL3 =
                          widget.pitData.numAutoScoreCoralL3! - 1;
                      if (widget.pitData.numAutoScoreCoralL3! < 0) {
                        widget.pitData.numAutoScoreCoralL3 = 0;
                      }
                      widget.onChanged!(widget.pitData);
                    });
                  },
                  onSetValue: (int value) {
                    setState(() {
                      widget.pitData.numAutoScoreCoralL3 = value;
                      widget.onChanged!(widget.pitData);
                    });
                  },
                ),
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                  "#Coral L4:",
                  style: styleBodyTextTheme,
                ),
                CounterWidget(
                  title: "",
                  styleFontSize: widget.styleFontSize,
                  value: widget.pitData.numAutoScoreCoralL4,
                  onIncreaseStateChanged: (int value) {
                    setState(() {
                      widget.pitData.numAutoScoreCoralL4 =
                          widget.pitData.numAutoScoreCoralL4! + 1;
                      widget.onChanged!(widget.pitData);
                    });
                  },
                  onDecreaseStateChanged: (int value) {
                    setState(() {
                      widget.pitData.numAutoScoreCoralL4 =
                          widget.pitData.numAutoScoreCoralL4! - 1;
                      if (widget.pitData.numAutoScoreCoralL4! < 0) {
                        widget.pitData.numAutoScoreCoralL4 = 0;
                      }
                      widget.onChanged!(widget.pitData);
                    });
                  },
                  onSetValue: (int value) {
                    setState(() {
                      widget.pitData.numAutoScoreCoralL4 = value;
                      widget.onChanged!(widget.pitData);
                    });
                  },
                ),
              ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Score Algae:",
                    style: styleBodyTextTheme,
                  ),
                  Switch(
                    value: widget.pitData.flAutoScoreAlgae!,
                    onChanged: (bool value) {
                      setState(() {
                        widget.pitData.flAutoScoreAlgae = value;
                        widget.onChanged!(widget.pitData);
                      });
                    },
                  ),
                ],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                  "#Remove L2:",
                  style: styleBodyTextTheme,
                ),
                CounterWidget(
                  title: "",
                  styleFontSize: widget.styleFontSize,
                  value: widget.pitData.numAutoScoreAlgaeL2,
                  onIncreaseStateChanged: (int value) {
                    setState(() {
                      widget.pitData.numAutoScoreAlgaeL2 =
                          widget.pitData.numAutoScoreAlgaeL2! + 1;
                      widget.onChanged!(widget.pitData);
                    });
                  },
                  onDecreaseStateChanged: (int value) {
                    setState(() {
                      widget.pitData.numAutoScoreAlgaeL2 =
                          widget.pitData.numAutoScoreAlgaeL2! - 1;
                      if (widget.pitData.numAutoScoreAlgaeL2! < 0) {
                        widget.pitData.numAutoScoreAlgaeL2 = 0;
                      }
                      widget.onChanged!(widget.pitData);
                    });
                  },
                  onSetValue: (int value) {
                    setState(() {
                      widget.pitData.numAutoScoreAlgaeL2 = value;
                      widget.onChanged!(widget.pitData);
                    });
                  },
                ),
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                  "#Remove L3:",
                  style: styleBodyTextTheme,
                ),
                CounterWidget(
                  title: "",
                  styleFontSize: widget.styleFontSize,
                  value: widget.pitData.numAutoScoreAlgaeL3,
                  onIncreaseStateChanged: (int value) {
                    setState(() {
                      widget.pitData.numAutoScoreAlgaeL3 =
                          widget.pitData.numAutoScoreAlgaeL3! + 1;
                      widget.onChanged!(widget.pitData);
                    });
                  },
                  onDecreaseStateChanged: (int value) {
                    setState(() {
                      widget.pitData.numAutoScoreAlgaeL3 =
                          widget.pitData.numAutoScoreAlgaeL3! - 1;
                      if (widget.pitData.numAutoScoreAlgaeL3! < 0) {
                        widget.pitData.numAutoScoreAlgaeL3 = 0;
                      }
                      widget.onChanged!(widget.pitData);
                    });
                  },
                  onSetValue: (int value) {
                    setState(() {
                      widget.pitData.numAutoScoreAlgaeL3 = value;
                      widget.onChanged!(widget.pitData);
                    });
                  },
                ),
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                  "#Ground Pickup:",
                  style: styleBodyTextTheme,
                ),
                CounterWidget(
                  title: "",
                  styleFontSize: widget.styleFontSize,
                  value: widget.pitData.numAutoScoreAlgaeGround,
                  onIncreaseStateChanged: (int value) {
                    setState(() {
                      widget.pitData.numAutoScoreAlgaeGround =
                          widget.pitData.numAutoScoreAlgaeGround! + 1;
                      widget.onChanged!(widget.pitData);
                    });
                  },
                  onDecreaseStateChanged: (int value) {
                    setState(() {
                      widget.pitData.numAutoScoreAlgaeGround =
                          widget.pitData.numAutoScoreAlgaeGround! - 1;
                      if (widget.pitData.numAutoScoreAlgaeGround! < 0) {
                        widget.pitData.numAutoScoreAlgaeGround = 0;
                      }
                      widget.onChanged!(widget.pitData);
                    });
                  },
                  onSetValue: (int value) {
                    setState(() {
                      widget.pitData.numAutoScoreAlgaeGround = value;
                      widget.onChanged!(widget.pitData);
                    });
                  },
                ),
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                  "#Barge:",
                  style: styleBodyTextTheme,
                ),
                CounterWidget(
                  title: "",
                  styleFontSize: widget.styleFontSize,
                  value: widget.pitData.numAutoScoreAlgaeBarge,
                  onIncreaseStateChanged: (int value) {
                    setState(() {
                      widget.pitData.numAutoScoreAlgaeBarge =
                          widget.pitData.numAutoScoreAlgaeBarge! + 1;
                      widget.onChanged!(widget.pitData);
                    });
                  },
                  onDecreaseStateChanged: (int value) {
                    setState(() {
                      widget.pitData.numAutoScoreAlgaeBarge =
                          widget.pitData.numAutoScoreAlgaeBarge! - 1;
                      if (widget.pitData.numAutoScoreAlgaeBarge! < 0) {
                        widget.pitData.numAutoScoreAlgaeBarge = 0;
                      }
                      widget.onChanged!(widget.pitData);
                    });
                  },
                  onSetValue: (int value) {
                    setState(() {
                      widget.pitData.numAutoScoreAlgaeBarge = value;
                      widget.onChanged!(widget.pitData);
                    });
                  },
                ),
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                  "#Processor:",
                  style: styleBodyTextTheme,
                ),
                CounterWidget(
                  title: "",
                  styleFontSize: widget.styleFontSize,
                  value: widget.pitData.numAutoScoreAlgaeProcess,
                  onIncreaseStateChanged: (int value) {
                    setState(() {
                      widget.pitData.numAutoScoreAlgaeProcess =
                          widget.pitData.numAutoScoreAlgaeProcess! + 1;
                      widget.onChanged!(widget.pitData);
                    });
                  },
                  onDecreaseStateChanged: (int value) {
                    setState(() {
                      widget.pitData.numAutoScoreAlgaeProcess =
                          widget.pitData.numAutoScoreAlgaeProcess! - 1;
                      if (widget.pitData.numAutoScoreAlgaeProcess! < 0) {
                        widget.pitData.numAutoScoreAlgaeProcess = 0;
                      }
                      widget.onChanged!(widget.pitData);
                    });
                  },
                  onSetValue: (int value) {
                    setState(() {
                      widget.pitData.numAutoScoreAlgaeProcess = value;
                      widget.onChanged!(widget.pitData);
                    });
                  },
                ),
              ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Notes: ",
                    style: styleBodyTextTheme,
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 300),
                    child: TextField(
                      controller: widget.txAutoNotes,
                      decoration: InputDecoration(
                          hintText: 'Auto Notes',
                          hintStyle:
                              styleBodyTextTheme?.copyWith(color: Colors.grey)),
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
