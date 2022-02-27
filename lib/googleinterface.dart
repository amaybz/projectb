import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:google_sign_in/google_sign_in.dart' as signIn;
import 'package:path_provider/path_provider.dart';
import 'package:projectb/googleauthclient.dart';
import 'dart:io';

import 'class_macthscoutingdata.dart';
import 'class_pitdata.dart';

class GoogleInterface {
  final googleSignIn =
      signIn.GoogleSignIn.standard(scopes: [drive.DriveApi.driveFileScope]);
  String appFolderID = "";

  // Make this a singleton class.
  GoogleInterface._privateConstructor();
  static final GoogleInterface instance = GoogleInterface._privateConstructor();

  static signIn.GoogleSignInAccount? _account;
  Future<signIn.GoogleSignInAccount?> get account async {
    if (_account != null) return _account;
    _account = await googleSignIn.signIn();

    return _account;
  }

  static drive.DriveApi? _driveApi;
  Future<drive.DriveApi?>? get driveApi async {
    //if (_driveApi != null) return _driveApi;
    final signIn.GoogleSignInAccount? googleAccount = await account;
    final authHeaders = await googleAccount!.authHeaders;
    final authenticateClient = GoogleAuthClient(authHeaders);
    _driveApi = drive.DriveApi(authenticateClient);
    return _driveApi;
  }

  Future<String> getEmail() async {
    //final signIn.GoogleSignInAccount googleAccount  = await account;
    //googleAccount.authHeaders;await account
    await account;
    if (_account != null) return _account!.email;
    return "Unknown";
  }

  Future<bool> isSignedIn() async {
    //print(googleSignIn.scopes.first);
    return googleSignIn.isSignedIn();
  }

  Future<void> doSignIn() async {
    final signIn.GoogleSignInAccount googleAccount = (await account)!;
    print("User account $googleAccount");
    //var test =  await _account.authentication;
    // print(test.idToken);
  }

  Future<void> doSignOut() async {
    _account = await googleSignIn.signOut();
    print("User account $_account");
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/temp.json');
  }

  Future<File> uploadMatchScoutingData(
      MatchScoutingData matchScoutingData) async {
    print("getting file Path");
    final file = await _localFile;
    // Write the file.
    print("write file");
    var dataToWrite = json.encode(matchScoutingData.toMap());
    File newFile = await file.writeAsString(dataToWrite.toString());
    print("JSON: " + dataToWrite);
    await uploadFile(
        newFile,
        "MATCH_" +
            matchScoutingData.numMatch.toString() +
            " " +
            matchScoutingData.idTeam.toString() +
            " - " +
            DateTime.now().toString(),
        "json");
    print("Upload Complete");
    return newFile;
  }

  Future<File> uploadPitData(PitData pitData) async {
    print("get file Path");
    final file = await _localFile;
    // Write the file.
    print("write file");
    var dataToWrite = json.encode(pitData.toMap());
    File newFile = await file.writeAsString(dataToWrite.toString());
    print("JSON: " + dataToWrite);
    await uploadFile(
        newFile,
        "PIT_" + pitData.idTeam.toString() + " - " + DateTime.now().toString(),
        "json");
    print("Upload Complete: JSON");
    await uploadFile(
        pitData.imgTeamUniform,
        "PIT_TeamUniform" +
            pitData.idTeam.toString() +
            DateTime.now().toString(),
        "jpg");
    await uploadFile(
        pitData.imgRobotSide,
        "PIT_RobotSide" + pitData.idTeam.toString() + DateTime.now().toString(),
        "jpg");
    await uploadFile(
        pitData.imgRobotFront,
        "PIT_RobotFront" +
            pitData.idTeam.toString() +
            DateTime.now().toString(),
        "jpg");
    return newFile;
  }

  Future<void> uploadFile(File file, String name, String? type) async {
    if (type == null) {
      type = "json";
    }

    print("check if APP folder exists");
    print(await isSignedIn());
    await _checkIfAppFolderExists();
    if (appFolderID == "") {
      //create folder
      print("Create folder");
      await _createAppFolder();
    }
    print("Setup Drive API");
    //final signIn.GoogleSignInAccount googleAccount  = await account;
    //final authHeaders = await googleAccount.authHeaders;
    //final authenticateClient = GoogleAuthClient(authHeaders);
    final drive.DriveApi gDriveApi = (await driveApi)!;
    googleSignIn.requestScopes([drive.DriveApi.driveFileScope]);
    //Process file
    Stream<List<int>> mediaStream = file.openRead().asBroadcastStream();
    int mediaStreamLength = await file.length();
    //int mediaStreamLength = await mediaStream.length;
    print("get file length to be sent: " + mediaStreamLength.toString());
    var media = new drive.Media(mediaStream, mediaStreamLength);
    var driveFile = new drive.File();
    final List<String> driveAppFolder = [appFolderID];
    driveFile.name = name.toString() + "." + type;
    driveFile.parents = driveAppFolder;
    final result = await gDriveApi.files.create(driveFile, uploadMedia: media);
    print("Upload result: $result");
  }

  Future<void> _checkIfAppFolderExists() async {
    final drive.DriveApi gDriveApi = (await driveApi)!;
    print("Printing list");
    //check folders to see if it has already been created.
    var f = await gDriveApi.files
        .list(q: "mimeType = 'application/vnd.google-apps.folder'");
    f.files!.forEach((f) {
      if (f.name == "FRC-APP") {
        appFolderID = f.id!;
        print("Folder Exists:  " + f.id.toString());
      }

      print(f.name! + ": " + f.id!);
    });
    print("AppFolder: " + appFolderID.toString());
    //print("Result ${f.toJson()}");
  }

  Future<void> _createAppFolder() async {
    final drive.DriveApi gDriveApi = (await driveApi)!;
    print("Creating folder.");
    var driveFolder = new drive.File();
    driveFolder.name = "FRC-APP";
    driveFolder.mimeType = "application/vnd.google-apps.folder";
    final createFolder = await gDriveApi.files.create(driveFolder);
    print("Uploaded Folder: " + createFolder.id.toString());
    appFolderID = createFolder.id!;
  }
}

class GoogleLoginButton extends StatefulWidget {
  const GoogleLoginButton({
    Key? key,
    this.googleLoginState = false,
    this.onLoginPressed,
  }) : super(key: key);

  final bool googleLoginState;
  final ValueChanged<bool>? onLoginPressed;

  @override
  _GoogleLoginButtonState createState() => _GoogleLoginButtonState();
}

class _GoogleLoginButtonState extends State<GoogleLoginButton> {
  @override
  Widget build(BuildContext context) {
    if (widget.googleLoginState == false) {
      return Container(
        child: TextButton(
          onPressed: () {
            widget.onLoginPressed!(true);
          },
          child: Text("Sign into Google"),
        ),
      );
    } else {
      return Container(
        child: TextButton(
          onPressed: () {
            widget.onLoginPressed!(false);
          },
          child: Text("Sign Out of Google"),
        ),
      );
    }
  }
}
