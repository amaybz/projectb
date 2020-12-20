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
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        color: Colors.grey,
      ),
      child: Column(children: [
          Text("Power Port"),

        ]),
    ),



    ]),
    );
  }
}
