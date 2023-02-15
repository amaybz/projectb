import 'package:flutter/material.dart';

class ShowAlertDialog {
  ShowAlertDialog(this.context);

  final BuildContext context;

  oKDialog(String heading, String text) {
    // set up the buttons
    Widget okButton = TextButton(
      child: Text("ok"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: Text(text),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
