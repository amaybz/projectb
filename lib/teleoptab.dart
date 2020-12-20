import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TeleOpScreen extends StatefulWidget {
  @override
  _TeleOpScreenState createState() => _TeleOpScreenState();
}

class _TeleOpScreenState extends State<TeleOpScreen> {

  final TextEditingController _txtCellAttempts = TextEditingController();
  final TextEditingController _txtCellSuccess = TextEditingController();

  //style
  double styleFieldCellsWidth = 40.0;
  double styleFieldPadding = 5.0;
  double styleFieldPaddingSides = 10.0;
  double styleFontSizeBody = 12;

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    if (_txtCellAttempts.text == "")
      {_txtCellAttempts.text = "0";}
    if (_txtCellSuccess.text == "")
    {_txtCellSuccess.text = "0";}

    if (width < 500) {
      styleFieldCellsWidth = 25.0;
      styleFieldPadding = 3.0;
      styleFieldPaddingSides = 3.0;
      styleFontSizeBody = 12;
    }
    if (width >= 600) {
      styleFieldCellsWidth = 30.0;
      styleFieldPadding = 3.0;
      styleFieldPaddingSides = 10.0;
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
                      Text("Cell Attempts"),
                      Row(children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 2.0, right: 2.0),
                          child: FlatButton(
                            child: Text("+"),
                            onPressed: () {},
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: styleFieldPadding,
                              horizontal: styleFieldPaddingSides),
                          width: styleFieldCellsWidth,
                          child: TextField(
                            style: TextStyle(fontSize: styleFontSizeBody),
                            controller: _txtCellAttempts,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: InputDecoration(
                              //labelText: "Starting Cells",
                              labelStyle: TextStyle(fontSize: styleFontSizeBody),
                              border: InputBorder.none,
                              isDense: true,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 2.0, right: 2.0),
                          child: FlatButton(
                            child: Text("-"),
                            onPressed: () {},
                          ),
                        ),
                      ]),
                      Text("Cell Success"),
                      Row(children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 2.0, right: 2.0),
                          child: FlatButton(
                            child: Text("+"),
                            onPressed: () {},
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
                              labelStyle: TextStyle(fontSize: styleFontSizeBody),
                              border: InputBorder.none,
                              isDense: true,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 2.0, right: 2.0),
                          child: FlatButton(
                            child: Text("-"),
                            onPressed: () {},
                          ),
                        ),
                      ])
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
    ]);
  }
}
