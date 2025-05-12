import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:projectb/take_picture.dart';

class PitImages extends StatefulWidget {
  final CameraDescription camera;
  final File? image;
  final ValueChanged<File>? onCapture;
  final String? title;

  const PitImages({
    Key? key,
    required this.camera,
    this.image,
    this.onCapture,
    this.title,
  }) : super(key: key);

  @override
  _PitImagesState createState() => _PitImagesState();
}

class _PitImagesState extends State<PitImages> {
  TextStyle? styleBodyTextTheme = ThemeData().textTheme.bodyMedium;
  TextStyle? styleTitleTextTheme = ThemeData().textTheme.titleMedium;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (width < 500) {
      setState(() {
        styleBodyTextTheme = Theme.of(context).textTheme.bodyMedium;
        styleTitleTextTheme = Theme.of(context).textTheme.titleMedium;
      });
    }
    if (width < 395) {
      setState(() {
        styleBodyTextTheme = Theme.of(context).textTheme.bodySmall;
        styleTitleTextTheme = Theme.of(context).textTheme.titleSmall;
      });
    }
    if (width >= 600) {
      setState(() {
        styleBodyTextTheme = Theme.of(context).textTheme.bodyLarge;
        styleTitleTextTheme = Theme.of(context).textTheme.titleLarge;
      });
    }

    return Column(
      children: [
        Text(
          widget.title!,
          style: styleBodyTextTheme,
        ),
        loadImage(widget.image),
        ElevatedButton(
          onPressed: () {
            getImageFromCamera(context);
          },
          child: Text(
            "Take Picture",
            style: styleBodyTextTheme,
          ),
        ),
      ],
    );
  }

  Widget loadImage(File? image) {
    if (image == null) {
      return Text("no image");
    } else {
      return Image.file(
        image,
        scale: 0.25,
        width: 100,
        height: 150,
      );
    }
  }

  getImageFromCamera(BuildContext context) async {
    File? image = (await _getImageFromCamera(context));
    widget.onCapture!(image!);
    setState(() {
      widget.onCapture!(image);
    });
  }

  Future<File?> _getImageFromCamera(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    File? image;
    final result = await Navigator.push(
      context,
      // Create the SelectionScreen in the next step.
      MaterialPageRoute(
          builder: (context) => TakePictureScreen(
                camera: widget.camera,
                onCaptureImage: (capturedImage) {
                  image = capturedImage;
                },
              )),
    );
    return image;
  }
}
