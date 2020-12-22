import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projectb/sharedprefs.dart';
import 'package:projectb/counter_widget.dart';

class TeleOpScreen extends StatefulWidget {
  @override
  _TeleOpScreenState createState() => _TeleOpScreenState();
}

class _TeleOpScreenState extends State<TeleOpScreen> {
  final TextEditingController _txtCellAttempts = TextEditingController();
  final TextEditingController _txtCellSuccess = TextEditingController();

  MySharedPrefs mySharedPrefs = new MySharedPrefs();

  @override
  void initState() {
    super.initState();
    //get values from SharedPrefs
    updateValuesFromSP();
  }

  updateValuesFromSP() async {
    intCellAttempts = await mySharedPrefs.readInt("CellAttempts");
    intCellSuccess = await mySharedPrefs.readInt("CellSuccess");
    intPenalAttempts = await mySharedPrefs.readInt("PenalAttempts");
    setState(() {
      _txtCellAttempts.text = intCellAttempts.toString();
      _txtCellSuccess.text = intCellSuccess.toString();
    });
  }

  //counters
  int intCellAttempts = 0;
  int intCellSuccess = 0;
  int intPenalAttempts = 0;

  //style
  double styleFieldCellsWidth = 40.0;
  double styleFieldPadding = 5.0;
  double styleFieldPaddingSides = 10.0;
  double styleFontSizeBody = 12;

  _increaseCellAttempts() async {
    intCellAttempts = intCellAttempts + 1;
    mySharedPrefs.saveInt("CellAttempts", intCellAttempts);
    setState(() {
      _txtCellAttempts.text = intCellAttempts.toString();
    });
  }

  _decreaseCellAttempts() async {
    intCellAttempts = intCellAttempts - 1;
    mySharedPrefs.saveInt("CellAttempts", intCellAttempts);
    setState(() {
      _txtCellAttempts.text = intCellAttempts.toString();
    });
  }

  _updateCellAttempts(int value) {
    intCellAttempts = value;
    mySharedPrefs.saveInt("CellAttempts", intCellAttempts);
  }

  _increaseCellSuccess() async {
    intCellSuccess = intCellSuccess + 1;
    intCellAttempts = intCellAttempts + 1;
    mySharedPrefs.saveInt("CellSuccess", intCellSuccess);
    setState(() {
      _txtCellSuccess.text = intCellSuccess.toString();
      _txtCellAttempts.text = intCellAttempts.toString();
    });
  }

  _decreaseCellSuccess() async {
    intCellSuccess = intCellSuccess - 1;
    mySharedPrefs.saveInt("CellSuccess", intCellSuccess);
    setState(() {
      _txtCellSuccess.text = intCellSuccess.toString();
    });
  }

  _updateCellSuccess(int value) {
    intCellSuccess = value;
    mySharedPrefs.saveInt("CellSuccess", intCellSuccess);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (_txtCellAttempts.text == "") {
      _txtCellAttempts.text = "0";
    }
    if (_txtCellSuccess.text == "") {
      _txtCellSuccess.text = "0";
    }

    if (width < 500) {
      styleFieldCellsWidth = 38.0;
      styleFieldPadding = 3.0;
      styleFieldPaddingSides = 3.0;
      styleFontSizeBody = 12;
    }
    if (width >= 600) {
      styleFieldCellsWidth = 40.0;
      styleFieldPadding = 3.0;
      styleFieldPaddingSides = 5.0;
      styleFontSizeBody = 16;
    }

    return Column(children: [
      FractionallySizedBox(
        widthFactor: 0.99,
        child: Container(
          margin: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            //color: Colors.red,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)),
          ),
          padding: EdgeInsets.all(4.0),
          child: Column(children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                color: Colors.grey,
              ),
              child: Column(children: [
                Text("Power Port"),
              ]),
            ),
            Container(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(children: [
                      CounterWidget(
                        value: intCellAttempts.toString(),
                        title: "Cell Attempts",
                        styleFontSize: styleFontSizeBody,
                        onIncreaseStateChanged: (int increase) {
                          _increaseCellAttempts();
                        },
                        onDecreaseStateChanged: (int decrease) {
                          _decreaseCellAttempts();
                        },
                        onSetValue: (int value) {
                          _updateCellAttempts(value);
                        },
                      ),
                      CounterWidget(
                        value: intCellSuccess.toString(),
                        title: "Cell Success",
                        styleFontSize: styleFontSizeBody,
                        onIncreaseStateChanged: (int increase) {
                          _increaseCellSuccess();
                        },
                        onDecreaseStateChanged: (int decrease) {
                          _decreaseCellSuccess();
                        },
                        onSetValue: (int value) {
                          _updateCellSuccess(value);
                        },
                      ),

                    ]),
                    Column(children: [
                      Row(children: [
                        Text("Picture"),
                      ])
                    ]),
                    Column(children: [
                      Row(children: [
                        Text("Outer"),
                        Text("0"),
                      ]),
                      Row(children: [
                        Text("Inner"),
                        Text("0"),
                      ]),
                      Row(children: [
                        Text("Lower"),
                        Text("0"),
                      ]),
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
            //color: Colors.red,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)),
          ),
          padding: EdgeInsets.all(4.0),
          child: Column(children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                color: Colors.grey,
              ),
              child: Column(children: [
                Text("Control Panel"),
              ]),
            ),
            Container(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(children: [
                      Row(children: [Text("Rotation Control:"), Text("0")]),
                      Row(children: [Text("Time Taken:"), Text("0")]),
                      Text("Panel Attempts"),
                      Row(children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 2.0, right: 2.0),
                          child: FlatButton(
                            child: Text("+"),
                            onPressed: () {
                              _increaseCellSuccess();
                            },
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: styleFieldPadding,
                              horizontal: styleFieldPaddingSides),
                          width: styleFieldCellsWidth,
                          child: TextField(
                            style: TextStyle(fontSize: styleFontSizeBody),
                            controller: _txtCellSuccess,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: InputDecoration(
                              //labelText: "Starting Cells",
                              labelStyle:
                                  TextStyle(fontSize: styleFontSizeBody),
                              border: InputBorder.none,
                              isDense: true,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 2.0, right: 2.0),
                          child: FlatButton(
                            child: Text("-"),
                            onPressed: () {
                              _decreaseCellSuccess();
                            },
                          ),
                        ),
                      ]),
                      CounterWidget(
                        value: intCellAttempts.toString(),
                        title: "Testing Widget",
                        onIncreaseStateChanged: (int increase) {
                          _increaseCellAttempts();
                        },
                        onDecreaseStateChanged: (int decrease) {
                          _decreaseCellAttempts();
                        },
                        onSetValue: (int value) {
                          _updateCellAttempts(value);
                        },
                      )
                    ]),
                    Column(children: [
                      Row(children: [Text("Position Control:"), Text("0")]),
                      Row(children: [Text("Time Taken:"), Text("0")]),
                      Text("PICTURE"),
                    ]),
                  ]),
            ),
          ]),
        ),
      )
    ]);
  }
}
