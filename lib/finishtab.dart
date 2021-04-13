import 'package:flutter/material.dart';

class FinishTab extends StatefulWidget {
  const FinishTab({
    Key key,
    this.onSavePressed,
  }) : super(key: key);

  final ValueChanged<bool> onSavePressed;

  @override
  _FinishTabState createState() => _FinishTabState();
}

class _FinishTabState extends State<FinishTab> {
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
            child: Container(
              padding: EdgeInsets.all(5.0),
              child: Column(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      color: Colors.grey,
                    ),
                    child: Text(
                      "Save",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        widget.onSavePressed(true);
                      },
                      child: Text("Save to local Database")),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
