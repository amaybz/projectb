import 'package:flutter/material.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:google_sign_in/google_sign_in.dart' as signIn;
import 'package:projectb/googleauthclient.dart';

class GoogleLoginRequest extends StatefulWidget {
  @override
  _GoogleLoginRequestState createState() => _GoogleLoginRequestState();
}

class _GoogleLoginRequestState extends State<GoogleLoginRequest> {

  final googleSignIn =
  signIn.GoogleSignIn.standard(scopes: [drive.DriveApi.DriveFileScope]);
  signIn.GoogleSignInAccount account;


  Future<void> _googleSignOut() async {

    account = await googleSignIn.signOut();
    print("User account $account");
    setState(() {
    });
  }

  Future<void> _googleSignIn() async {
    account = await googleSignIn.signIn();
    print("User account $account");
    //var authHeaders = await googleSignIn.currentUser.authHeaders;
    //print(authHeaders.toString());
    setState(() {
    });
  }

  Future<void> _googleDriveFolders() async {

  final authHeaders = await account.authHeaders;
  final authenticateClient = GoogleAuthClient(authHeaders);
  final driveApi = drive.DriveApi(authenticateClient);
  googleSignIn.requestScopes([drive.DriveApi.DriveFileScope]);
  //print(authenticateClient);

  //create file
  final Stream<List<int>> mediaStream =
  Future.value([104, 105]).asStream().asBroadcastStream();
  var media = new drive.Media(mediaStream, 2);
  var driveFile = new drive.File();
  driveFile.name = "hello_world.txt";
  //final result = await driveApi.files.create(driveFile, uploadMedia: media);
  // print("Upload result: $result");

  //create folder
  var driveFolder = new drive.File();
  driveFolder.name = "FRCAPP";
  driveFolder.mimeType = "application/vnd.google-apps.folder";
  //final createFolder = await driveApi.files.create(driveFolder);
  //print("Upload result: $createFolder");

  //check folders to see if it has already been created.
  var f = await driveApi.files
      .list(q: "mimeType = 'application/vnd.google-apps.folder'");
  f.files.forEach((f) {
  print(f.name + ": " + f.id);
  });
  //print("Result ${f.toJson()}");
}

  @override
  Widget build(BuildContext context) {
    if(account == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Google Drive Testing'),
        ),
        body: Column(children: [
          FlatButton(
            onPressed: () {
              _googleSignIn();
            },
            child: Text("Sign In"),
          ),
        ]),
      );
    }
    else {
      return Scaffold(
        appBar: AppBar(
          title: Text('Google Drive Testing'),
        ),
        body: Column(children: [
          FlatButton(
            onPressed: () {
              _googleSignOut();
            },
            child: Text("Sign Out"),
          ),
          FlatButton(
            onPressed: () {
              _googleDriveFolders();
            },
            child: Text("Print Files to Console"),
          ),
        ]),
      );
    }

  }
}
