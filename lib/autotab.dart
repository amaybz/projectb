import 'package:flutter/material.dart';
import 'package:projectb/widget_performace.dart';
import 'package:projectb/localdb.dart';
import 'package:projectb/widget_counter.dart';


class AutoTab extends StatefulWidget {
  const AutoTab({
    Key key,
    @required this.styleImgFieldMapWidth,
    this.styleImgFieldPerformanceWidth = 150,
    @required this.matchScoutingData,
    this.boolLoseStartObject = false,
    this.boolContactWithRobot = false,
    this.boolCrossSector = false,
    this.boolFoul = false,
    this.boolDoesAuto = false,
    this.boolLeaveLine = false,
    this.onLoseStartObjectChange,
    this.onContactWithRobotChange,
    this.onCrossSectorChange,
    this.onFoulChange,
    this.onDoesAutoChange,
    this.onLeaveLineChange,
    this.onAutoFlInnerChange,
    this.onAutoFlLowerChange,
    this.onAutoFlOuterChange,
    this.onAutoNumCellAttemptChange,
    this.onAutoNumCellSuccessChange,
    this.onChanged,
  }) : super(key: key);

  final MatchScoutingData matchScoutingData;
  final double styleImgFieldMapWidth;
  final double styleImgFieldPerformanceWidth;
  final ValueChanged<int> onAutoNumCellAttemptChange;
  final ValueChanged<int> onAutoNumCellSuccessChange;
  final ValueChanged<bool> onLoseStartObjectChange;
  final ValueChanged<bool> onContactWithRobotChange;
  final ValueChanged<bool> onCrossSectorChange;
  final ValueChanged<bool> onFoulChange;
  final ValueChanged<bool> onDoesAutoChange;
  final ValueChanged<bool> onLeaveLineChange;
  final ValueChanged<bool> onAutoFlOuterChange;
  final ValueChanged<bool> onAutoFlInnerChange;
  final ValueChanged<bool> onAutoFlLowerChange;
  final ValueChanged<MatchScoutingData> onChanged;
  final bool boolLoseStartObject;
  final bool boolContactWithRobot;
  final bool boolCrossSector;
  final bool boolFoul;
  final bool boolDoesAuto;
  final bool boolLeaveLine;

  @override
  _AutoTabState createState() => _AutoTabState();
}

class _AutoTabState extends State<AutoTab> {


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FractionallySizedBox(
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
            child: Column(children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  color: Colors.grey,
                ),
                child: Text(
                  "Driver Position",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              //Image.asset('assets/imgs/field.png'),
              Container(
                decoration: BoxDecoration(
                    //border: Border.all(color: Colors.black),
                    //image: DecorationImage(
                    // image: AssetImage("assets/imgs/field.png"),
                    // fit: BoxFit.cover,
                    //),
                    ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Column(children: <Widget>[
                        Container(
                          margin: const EdgeInsets.all(5.0),
                          padding: EdgeInsets.all(4.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            color: Colors.blue,
                          ),
                          child: Text(
                            "1",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(5.0),
                          padding: EdgeInsets.all(4.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            color: Colors.blue,
                          ),
                          child: Text(
                            "2",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(5.0),
                          padding: EdgeInsets.all(4.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            color: Colors.blue,
                          ),
                          child: Text(
                            "3",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ]),
                      Column(children: <Widget>[
                        SizedBox(
                          width: widget.styleImgFieldMapWidth,
                          height: (widget.styleImgFieldMapWidth * 0.5),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              color: Colors.grey,
                            ),
                            child: Image.asset("assets/imgs/field.png"),
                          ),
                        ),
                      ]),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.all(5.0),
                              padding: EdgeInsets.all(4.0),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                color: Colors.red,
                              ),
                              child: Text(
                                "1",
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.all(5.0),
                              padding: EdgeInsets.all(4.0),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                color: Colors.red,
                              ),
                              child: Text(
                                "2",
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.all(5.0),
                              padding: EdgeInsets.all(4.0),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                color: Colors.red,
                              ),
                              child: Text(
                                "3",
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ]),
                    ]),
              ),
            ]),
          ),
        ),
        FractionallySizedBox(
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
            child: Column(children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  color: Colors.grey,
                ),
                child: Text(
                  "Errors",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.all(5.0),
                    child: Text("Lose Start Object"),
                  ),
                  Switch(
                    value: widget.boolLoseStartObject,
                    onChanged: (bool value) {
                      setState(() {
                        widget.onLoseStartObjectChange(value);
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
                    child: Text("Contact with Robot"),
                  ),
                  Switch(
                      value: widget.boolContactWithRobot,
                      onChanged: (bool value) {
                        setState(() {
                          widget.onContactWithRobotChange(value);
                        });
                      }),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.all(5.0),
                    child: Text("Cross Sector"),
                  ),
                  Switch(
                    value: widget.boolCrossSector,
                      onChanged: (bool value) {
                        setState(() {
                          widget.onCrossSectorChange(value);
                        });
                      }
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.all(5.0),
                    child: Text("Foul"),
                  ),
                  Switch(
                    value: widget.boolFoul,
                      onChanged: (bool value) {
                        setState(() {
                          widget.onFoulChange(value);
                        });
                      },
                  ),
                ],
              ),
            ]),
          ),
        ),
        FractionallySizedBox(
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
            child: Column(children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  color: Colors.grey,
                ),
                child: Text(
                  "Auto",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.all(5.0),
                    child: Text("Does Auto"),
                  ),
                  Switch(
                    value: widget.boolDoesAuto,
                    onChanged: (bool value) {
                      setState(() {
                        widget.onDoesAutoChange(value);
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
                    child: Text("Leave Line"),
                  ),
                  Switch(
                    value: widget.boolLeaveLine,
                    onChanged: (bool value) {
                      setState(() {
                        widget.onLeaveLineChange(value);
                      });
                    },
                  ),
                ],
              ),
            ]),
          ),
        ),
        PerformanceWidget(
          styleImgFieldWidth: widget.styleImgFieldPerformanceWidth,
          numCellAttempt: widget.matchScoutingData.autoNumCellAttempt,
          numCellSuccess: widget.matchScoutingData.autoNumCellSuccess,
          flInner: widget.matchScoutingData.autoFlInner,
          flOuter: widget.matchScoutingData.autoFlOuter,
          flLower: widget.matchScoutingData.autoFlLower,
          onCellAttemptsChanged: (int value) {
            setState(() {
              widget.matchScoutingData.autoNumCellAttempt = value;
              widget.onChanged(widget.matchScoutingData);
            });
          },
          onCellSuccessChanged: (int value) {
            setState(() {
              widget.matchScoutingData.autoNumCellSuccess = value;
              widget.onChanged(widget.matchScoutingData);
            });
          },
          onFlOuterChanged: (bool value) {
            setState(() {
              widget.matchScoutingData.autoFlOuter = value;
              widget.onChanged(widget.matchScoutingData);
            });
          },
          onFlInnerChanged: (bool value) {
            setState(() {
              widget.matchScoutingData.autoFlInner = value;
              widget.onChanged(widget.matchScoutingData);
            });
          },
          onFlLowerChanged: (bool value) {
            setState(() {
              widget.matchScoutingData.autoFlLower = value;
              widget.onChanged(widget.matchScoutingData);
            });
          },
        ),
      ],
    );
  }
}
