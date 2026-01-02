import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:google_sign_in/google_sign_in.dart' as signIn;

import 'package:google_sign_in_platform_interface/google_sign_in_platform_interface.dart';
import 'package:google_sign_in_android/google_sign_in_android.dart';
import 'package:path_provider/path_provider.dart';
import 'package:projectb/googleauthclient.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

import 'package:projectb/class/class_macthscoutingdata.dart';
import 'package:projectb/class/class_pitdata.dart';

const List<String> _scopes = <String>[
  'https://www.googleapis.com/auth/drive.file',
];

class GoogleInterface {
  GoogleSignInUserData? _currentUser;
  bool _isAuthorized = false;
  String _contactText = '';
  String _errorMessage = '';

  GoogleInterface._internal();

  static final GoogleInterface instance = GoogleInterface._internal();

  // Future that completes when `init` has completed on the sign in instance.
  Future<void>? _initialization;

  Future<void> _ensureInitialized() {
    print(drive.DriveApi.driveFileScope.toString());
    // The example app uses the parsing of values from google-services.json
    // to provide the serverClientId, otherwise it would be required here.
    return _initialization ??=
        GoogleSignInPlatform.instance.init(const InitParameters())
          ..catchError((dynamic _) {
            _initialization = null;
          });
  }

  void _setUser(GoogleSignInUserData? user) {
    _currentUser = user;
    if (user != null) {
      // Try getting contacts, in case authorization is already granted.
      //_handleGetContact(user);
    }
  }

  Future<void> _signIn() async {
    await _ensureInitialized();
    try {
      final AuthenticationResults? result = await GoogleSignInPlatform.instance
          .attemptLightweightAuthentication(
            const AttemptLightweightAuthenticationParameters(),
          );
      _setUser(result?.user);
    } on GoogleSignInException catch (e) {
      _errorMessage = e.code == GoogleSignInExceptionCode.canceled
          ? ''
          : 'GoogleSignInException ${e.code}: ${e.description}';
    }
  }

  Future<void> _handleAuthorizeScopes(GoogleSignInUserData user) async {
    try {
      final ClientAuthorizationTokenData? tokens = await GoogleSignInPlatform
          .instance
          .clientAuthorizationTokensForScopes(
            ClientAuthorizationTokensForScopesParameters(
              request: AuthorizationRequestDetails(
                scopes: _scopes,
                userId: user.id,
                email: user.email,
                promptIfUnauthorized: true,
              ),
            ),
          );

      _isAuthorized = tokens != null;
      _errorMessage = '';
    } on GoogleSignInException catch (e) {
      _errorMessage = 'GoogleSignInException ${e.code}: ${e.description}';
    }
  }

  Future<Map<String, String>?> _getAuthHeaders(
    GoogleSignInUserData user,
  ) async {
    final ClientAuthorizationTokenData? tokens = await GoogleSignInPlatform
        .instance
        .clientAuthorizationTokensForScopes(
          ClientAuthorizationTokensForScopesParameters(
            request: AuthorizationRequestDetails(
              scopes: _scopes,
              userId: user.id,
              email: user.email,
              promptIfUnauthorized: false,
            ),
          ),
        );
    if (tokens == null) {
      return null;
    }

    return <String, String>{
      'Authorization': 'Bearer ${tokens.accessToken}',
      // TODO(kevmoo): Use the correct value once it's available.
      // See https://github.com/flutter/flutter/issues/80905
      'X-Goog-AuthUser': '0',
    };
  }

  Future<void> _handleSignIn() async {
    try {
      await _ensureInitialized();
      final AuthenticationResults result = await GoogleSignInPlatform.instance
          .authenticate(const AuthenticateParameters());
      _setUser(result.user);
    } on GoogleSignInException catch (e) {
      _errorMessage = e.code == GoogleSignInExceptionCode.canceled
          ? ''
          : 'GoogleSignInException ${e.code}: ${e.description}';
      print("GoogleSignInException:" + _errorMessage);
    }
  }

  Future<void> _handleSignOut() async {
    await _ensureInitialized();
    await GoogleSignInPlatform.instance.disconnect(const DisconnectParams());
  }

  //----------------------------

  String appFolderID = "";

  static drive.DriveApi? _driveApi;

  Future<drive.DriveApi?> get driveApi async {
    if (_driveApi != null) return _driveApi;

    final Map<String, String>? headers = await _getAuthHeaders(_currentUser!);
    final authenticateClient = GoogleAuthClient(headers!);

    _driveApi = drive.DriveApi(authenticateClient);
    return _driveApi;
  }

  Future<String> getEmail() async {
    //final signIn.GoogleSignInAccount googleAccount  = await account;
    //googleAccount.authHeaders;await account
    await _currentUser;
    if (_currentUser != null) return _currentUser!.email;
    _handleSignIn();
    return "Unknown";
  }

  Future<bool> isSignedIn() async {
    print("Auth:" + _isAuthorized.toString());
    return _isAuthorized;
  }

  Future<void> doSignIn() async {
    //final signIn.GoogleSignInAccount googleAccount = (await account)!;
    if (await isSignedIn()) {
      print(isSignedIn());
    } else {
      await _signIn();
    }
    //print("User account:" + _currentUser!.email?.toString());
    //var test =  await _account.authentication;
    // print(test.idToken);
  }

  Future<void> doSignOut() async {
    _handleSignOut();
    print("User account:" + _currentUser!.email);
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
    MatchScoutingData matchScoutingData,
  ) async {
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
      "json",
    );
    print("Upload Complete");
    return newFile;
  }

  Future<File> uploadPitData(PitData pitData) async {
    bool fileExists;
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
      "json",
    );
    print("Upload Complete: JSON");
    if (pitData.imgTeamUniform != null) {
      fileExists = await File(pitData.imgTeamUniform!.path).exists();
    } else {
      fileExists = false;
    }
    if (fileExists == true) {
      await uploadFile(
        pitData.imgTeamUniform!,
        pitData.idTeam.toString() +
            " PIT_TeamUniform" +
            pitData.idTeam.toString() +
            DateTime.now().toString(),
        "jpg",
      );
    }
    if (pitData.imgRobotSide != null) {
      fileExists = await File(pitData.imgRobotSide!.path).exists();
    } else {
      fileExists = false;
    }
    if (fileExists == true) {
      await uploadFile(
        pitData.imgRobotSide!,
        pitData.idTeam.toString() +
            " PIT_RobotSide" +
            pitData.idTeam.toString() +
            DateTime.now().toString(),
        "jpg",
      );
    }
    if (pitData.imgRobotFront != null) {
      fileExists = await File(pitData.imgRobotFront!.path).exists();
    } else {
      fileExists = false;
    }

    if (fileExists == true) {
      await uploadFile(
        pitData.imgRobotFront!,
        pitData.idTeam.toString() +
            " PIT_RobotFront" +
            pitData.idTeam.toString() +
            DateTime.now().toString(),
        "jpg",
      );
    }
    return newFile;
  }

  Future<void> uploadFile(File file, String name, String? type) async {
    await doSignIn();
    await _handleAuthorizeScopes(_currentUser!);
    if (type == null) {
      type = "json";
    }

    print(await isSignedIn());
    print("check if APP folder exists");
    await _checkIfAppFolderExists();
    if (appFolderID == "") {
      //create folder
      print("Create folder");
      await _createAppFolder();
    }
    print("Connect to Drive API");
    //final signIn.GoogleSignInAccount googleAccount  = await account;
    //final authHeaders = await googleAccount.authHeaders;
    //final authenticateClient = GoogleAuthClient(authHeaders);
    final drive.DriveApi gDriveApi = (await driveApi)!;
    final Map<String, String>? headers = await _getAuthHeaders(_currentUser!);
    _isAuthorized = headers != null;
    if (headers == null) {
      return;
    }
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
    var f = await gDriveApi.files.list(
      q: "mimeType = 'application/vnd.google-apps.folder'",
    );
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
    print("Created Folder: " + createFolder.id.toString());
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
