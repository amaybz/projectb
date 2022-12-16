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
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(widget.title!),
        loadImage(widget.image),
        ElevatedButton(
          onPressed: () {
            getImageFromCamera(context);
          },
          child: Text("Take Picture"),
        ),
      ],
    );
  }

  Widget loadImage(File? image) {
    if (image == null) {
      return Text("no image captured");
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
