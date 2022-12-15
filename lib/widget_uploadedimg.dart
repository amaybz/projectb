import 'package:flutter/material.dart';

class UploadedImg extends StatefulWidget {
  UploadedImg({Key? key, required this.state, this.text}) : super(key: key);

  final bool state;
  final String? text;
  @override
  _UploadedImgState createState() => _UploadedImgState();
}

class _UploadedImgState extends State<UploadedImg> {
  @override
  Widget build(BuildContext context) {
    if (widget.state == false) {
      return Container();
    } else if (widget.state == true) {
      return Container(
        child: Image.asset(
          'assets/imgs/UploadComplete.png',
          scale: 20,
        ),
      );
    } else {
      return Container(
        child: Text(widget.text!),
      );
    }
  }
}
