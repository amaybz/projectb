import 'package:flutter/material.dart';


class TeleOpScreen extends StatefulWidget {
  @override
  _TeleOpScreenState createState() => _TeleOpScreenState();
}

class _TeleOpScreenState extends State<TeleOpScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(child: Column(children: [
    Container(
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
                padding: const EdgeInsets.only(left: 2.0, right:  2.0),
                child: FlatButton(
                  child: Text("+"),
                  onPressed: () {
                  },
                ),
              ),
              Text("0"),
              Padding(
                padding: const EdgeInsets.only(left: 2.0, right:  2.0),
                child: FlatButton(
                  child: Text("-"),
                  onPressed: () {
                  },
                ),
              ),
              ]),
            Text("Cell Success"),
            Row(children: [
              Padding(
                padding: const EdgeInsets.only(left: 2.0, right:  2.0),
                child: FlatButton(
                  child: Text("+"),
                  onPressed: () {
                  },
                ),
              ),
              Text("0"),
              Padding(
                padding: const EdgeInsets.only(left: 2.0, right:  2.0),
                child: FlatButton(
                  child: Text("-"),
                  onPressed: () {
                  },
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



    ]),
    );
  }
}
