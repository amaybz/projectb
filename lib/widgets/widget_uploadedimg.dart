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
      return Container(
        child: Image.asset(
          'assets/imgs/upload.png',
          scale: 2,
        ),
      );
    } else if (widget.state == true) {
      return Container(
        child: Image.asset(
          'assets/imgs/UploadComplete.png',
          scale: 21,
        ),
      );
    } else {
      return Container(
        child: Image.asset(
          'assets/imgs/upload.png',
          scale: 2,
        ),
      );
    }
  }
}
