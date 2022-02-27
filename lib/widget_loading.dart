import 'package:flutter/material.dart';
import 'package:loading_gifs/loading_gifs.dart';

class LoadingImage extends StatefulWidget {
  LoadingImage({Key? key, required this.state, this.text}) : super(key: key);

  final int state;
  final String? text;
  @override
  _LoadingImageState createState() => _LoadingImageState();
}

class _LoadingImageState extends State<LoadingImage> {
  @override
  Widget build(BuildContext context) {
    if (widget.state == 1) {
      return Container(
        child: CircularProgressIndicator(
          value: null,
          semanticsLabel: 'uploading indicator',
        ),
      );
    } else if (widget.state == 2) {
      return Container(
        child: Image.asset(
          'assets/imgs/greentick.png',
          scale: 10,
        ),
      );
    } else {
      return Container(
        child: Text(widget.text!),
      );
    }
  }
}
