import 'dart:async';
import 'dart:io';
import 'package:gal/gal.dart';
import 'package:path_provider/path_provider.dart';
import 'package:projectb/googleinterface.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

// A screen that allows users to take a picture using a given camera.
class TakePictureScreen extends StatefulWidget {
  final CameraDescription? camera;
  final ValueChanged<File>? onCaptureImage;

  const TakePictureScreen({
    Key? key,
    @required this.camera,
    this.onCaptureImage,
  }) : super(key: key);

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  CameraController? _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    // To display the current output from the Camera,
    // create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera!,
      // Define the resolution to use.
      ResolutionPreset.high,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller!.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Take a picture')),
        // Wait until the controller is initialized before displaying the
        // camera preview. Use a FutureBuilder to display a loading spinner
        // until the controller has finished initializing.
        body: FutureBuilder<void>(
          future: _initializeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              // If the Future is complete, display the preview.
              return CameraPreview(_controller!);
            } else {
              // Otherwise, display a loading indicator.
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              heroTag: null,
              child: Icon(Icons.flash_auto),
              // Provide an onPressed callback.
              onPressed: () async {
                try {
                  await _initializeControllerFuture;
                  await _controller!.setFlashMode(FlashMode.auto);
                } catch (e) {
                  // If an error occurs, log the error to the console.
                  print(e);
                }
              },
            ),
            SizedBox(
              height: 10,
              width: 10,
            ),
            FloatingActionButton(
              heroTag: null,
              child: Icon(Icons.flash_off),
              // Provide an onPressed callback.
              onPressed: () async {
                try {
                  await _initializeControllerFuture;
                  await _controller!.setFlashMode(FlashMode.off);
                } catch (e) {
                  // If an error occurs, log the error to the console.
                  print(e);
                }
              },
            ),
            SizedBox(
              height: 10,
              width: 10,
            ),
            FloatingActionButton(
              heroTag: null,
              child: Icon(Icons.camera_alt),
              // Provide an onPressed callback.
              onPressed: () async {
                // Take the Picture in a try / catch block. If anything goes wrong,
                // catch the error.
                try {
                  // Ensure that the camera is initialized.
                  await _initializeControllerFuture;

                  // Attempt to take a picture and get the file `image`
                  // where it was saved.
                  final image = await _controller!.takePicture();

                  // If the picture was taken, display it on a new screen.
                  widget.onCaptureImage!(File(image.path));
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DisplayPictureScreen(
                        // Pass the automatically generated path to
                        // the DisplayPictureScreen widget.
                        imagePath: image.path,
                      ),
                    ),
                  );
                } catch (e) {
                  // If an error occurs, log the error to the console.
                  print(e);
                }
              },
            )
          ],
        ));
  }
}

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatelessWidget {
  final String? imagePath;

  const DisplayPictureScreen({Key? key, this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Display the Picture')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: ListView(
        children: [
          Image.file(File(imagePath!)),
          ElevatedButton(
            onPressed: () {
              uploadToGoogle(File(imagePath!));
            },
            child: Text("Save to Google"),
          ),
          ElevatedButton(
            onPressed: () {
              saveToDevice(
                  File(imagePath!), "PitPicture" + DateTime.now().toString());
            },
            child: Text("Save to Device"),
          ),
        ],
      ),
    );
  }

  Future<File> saveToDevice(File file, String fileName) async {
    final permissionStatus = await Permission.photos.status;
    if (permissionStatus.isDenied) {
      // Here just ask for the permission for the first time
      await Permission.photos.request();

      // I noticed that sometimes popup won't show after user press deny
      // so I do the check once again but now go straight to appSettings
      if (permissionStatus.isDenied) {
        await openAppSettings();
      }
    } else if (permissionStatus.isPermanentlyDenied) {
      // Here open app settings for user to manually enable permission in case
      // where permission was permanently denied
      await openAppSettings();
    } else {
      // Do stuff that require permission here
    }

    final appDirectory = await getApplicationDocumentsDirectory();
    final appExternalDirectory = await getExternalStorageDirectory();

    final appExternalStorageDirectories = await getExternalStorageDirectories();
    final String newPath = appExternalDirectory!.path + "/" + fileName + ".jpg";
    //final File localImage = await file.copy(newPath);

    print(file.path);
    // print(localImage.path);
    print(appExternalStorageDirectories);
    await Gal.putImage(file.path, album: "Robot Match Scouting");
    return file;
  }

  Future<File> uploadToGoogle(File file) async {
    GoogleInterface googleInterface = GoogleInterface.instance;
    await googleInterface.uploadFile(
        file, "TESTPicture" + DateTime.now().toString(), "jpg");
    print("Upload Complete");
    return file;
  }
}
