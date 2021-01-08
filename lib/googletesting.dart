import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:google_sign_in/google_sign_in.dart' as signIn;
import 'package:path_provider/path_provider.dart';
import 'package:projectb/googleauthclient.dart';
import 'dart:io';
import 'package:projectb/localdb.dart';
import 'package:projectb/scoringdata.dart';

class GoogleLoginRequest extends StatefulWidget {
  @override
  _GoogleLoginRequestState createState() => _GoogleLoginRequestState();
}

class _GoogleLoginRequestState extends State<GoogleLoginRequest> {

  final googleSignIn =
  signIn.GoogleSignIn.standard(scopes: [drive.DriveApi.DriveFileScope]);
  signIn.GoogleSignInAccount account;

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/test.json');
  }

  Future<File> writeFile(MatchScoutingData matchScoutingData) async {
    final file = await _localFile;
    // Write the file.
    return file.writeAsString(matchScoutingData.toJson().toString());
  }

  Future<MatchScoutingData> readFile() async {
    try {
      final file = await _localFile;
      // Read the file.
      String contents = await file.readAsString();
      print(contents);
      MatchScoutingData matchScoutingData = MatchScoutingData.fromMap(jsonDecode(contents));

      print(matchScoutingData.scoutName);

      return matchScoutingData;
    } catch (e) {
      // If encountering an error, return 0.
      print(e);
      return null;
    }
  }



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
          FlatButton(
            onPressed: () {
              writeFile(MatchScoutingData(id: 1, scoutName: "Aiden", team: "1234 - test", matchNumber: 123, startingCells: 3, driveStation: "red 3"));
            },
            child: Text("write File"),
          ),
          FlatButton(
            onPressed: () {
              readFile();
            },
            child: Text("read File"),
          ),
        ]),
      );
    }

  }
}
