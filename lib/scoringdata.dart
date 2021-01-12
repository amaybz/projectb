import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:path_provider/path_provider.dart';
import 'package:projectb/localdb.dart';
import 'dart:async';
import 'package:projectb/displayqrcode.dart';
import 'package:projectb/googleinterface.dart';
import 'dart:io';

class ScoringDataScreen extends StatefulWidget {
  ScoringDataScreen({
    Key key,
    @required this.eventName,
    @required this.eventKey,
  }) : super(key: key);

  final String eventName;
  final String eventKey;

  @override
  _ScoringDataScreenState createState() => _ScoringDataScreenState();
}

class _ScoringDataScreenState extends State<ScoringDataScreen> {
  GoogleInterface googleInterface = GoogleInterface.instance;
  LocalDB localDB = LocalDB.instance;
  List unitMemberList;
  List<MatchScoutingData> dataList;
  String googleEmail = "Not Signed In";
  bool isSignedInToGoogle = false;

  showAlertOKDialog(BuildContext context, String heading, String text) {
    // set up the buttons
    Widget okButton = FlatButton(
      child: Text("ok"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(heading),
      content: Text(text),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  _getScoringData() async {
    List<MatchScoutingData> list = await localDB.listScoringData();
    setState(() {
      dataList = list;
    });
  }

  _updateGoogleEmail() async {
    String email = await googleInterface.getEmail();
    setState(() {
      googleEmail = email;
    });
  }

  _signOutOfGoogle() async {
    await googleInterface.doSignOut();
    _updateGoogleEmail();
    checkIsSignedInToGoogle();
    setState(() {});
  }

  _signInToGoogle() async {
    await googleInterface.doSignIn();
    _updateGoogleEmail();
    checkIsSignedInToGoogle();
    setState(() {});
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/temp.json');
  }

  Future<File> writeFileAndUploadToGoogle(
      MatchScoutingData matchScoutingData) async {
    print("get file Path");
    final file = await _localFile;
    // Write the file.
    print("write file");
    File newFile =
        await file.writeAsString(matchScoutingData.toJson().toString());
    print("JSON: " + matchScoutingData.toJson().toString());
    await googleInterface.uploadFile(
        newFile,
        matchScoutingData.matchNumber.toString() +
            " " +
            matchScoutingData.team.toString());
    print("Upload Complete");
    checkIsSignedInToGoogle();
    showAlertOKDialog(context, "Upload", "Result uploaded to Google");
    return newFile;
  }

  checkIsSignedInToGoogle() async {
    isSignedInToGoogle = await googleInterface.isSignedIn();
    googleEmail = await googleInterface.getEmail();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Match Scouting'),
      ),
      body: Column(children: <Widget>[
        FractionallySizedBox(
          widthFactor: 0.9,
          child: Container(
            margin: const EdgeInsets.all(15.0),
            decoration:
                BoxDecoration(border: Border.all(color: Colors.blueAccent)),
            padding: EdgeInsets.all(4.0),
            child: Text(
              "Event Name: " + widget.eventName,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
        FractionallySizedBox(
          widthFactor: 0.9,
          child: Container(
            margin: const EdgeInsets.all(15.0),
            decoration:
                BoxDecoration(border: Border.all(color: Colors.blueAccent)),
            padding: EdgeInsets.all(4.0),
            child: Column(
              children: [
                Text(
                  "Google Account: " + googleEmail,
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  "Press and hold a result to upload to google",
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
        ),
        GoogleLoginButton(
          googleLoginState: isSignedInToGoogle,
          onLoginPressed: (bool value) {
            if (value == true) {
              _signInToGoogle();
            } else {
              _signOutOfGoogle();
            }
          },
        ),
        Expanded(
          child: _buildListView(),
        )
      ]),
    );
  }

  Widget _buildListView() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: dataList == null ? 0 : dataList.length,
        itemBuilder: (context, index) {
          return _buildRow(dataList[index]);
        });
  }

  Widget _buildRow(MatchScoutingData item) {
    //print(item.defenceRating);
    return ListTile(
      title: Text(
        item.id.toString() + ". Match: " + item.matchNumber.toString(),
      ),
      subtitle: Text("Team: " + item.team),
      trailing: Icon(Icons.share),
      onTap: () {
        _showDialogQRCode(context, item.id.toString());
      },
      onLongPress: () {
        writeFileAndUploadToGoogle(item);
      },
    );
  }

  _showDialogQRCode(BuildContext context, String matchID) async {
    // set up the buttons

    MatchScoutingData match =
        await localDB.getScoringDataRecord(int.parse(matchID));
    // set up the AlertDialog
    Dialog dialogQRCodeImage = Dialog(
      child: Container(
        width: 300,
        height: 300,
        child: DisplayQRCode(
          match: match,
          styleQRSize: 299.0,
        ),
      ),
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return dialogQRCodeImage;
      },
    );
  }

  @override
  void initState() {
    super.initState();
    // Call the getJSONData() method when the app initializes
    _getScoringData();
    _updateGoogleEmail();
    checkIsSignedInToGoogle();
  }
}
