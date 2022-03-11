import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:projectb/localdb.dart';
import 'dart:async';
import 'package:projectb/displayqrcode.dart';
import 'package:projectb/googleinterface.dart';
import 'dart:io';
import 'package:projectb/class_pitdata.dart';
import 'package:projectb/widget_headingmain.dart';
import 'package:projectb/class_macthscoutingdata.dart';
import 'package:projectb/widget_loading_popup.dart';

class ScoringDataScreen extends StatefulWidget {
  ScoringDataScreen({
    Key? key,
    @required this.eventName,
    @required this.eventKey,
  }) : super(key: key);

  final String? eventName;
  final String? eventKey;

  @override
  _ScoringDataScreenState createState() => _ScoringDataScreenState();
}

class _ScoringDataScreenState extends State<ScoringDataScreen> {
  GoogleInterface googleInterface = GoogleInterface.instance;
  LocalDB localDB = LocalDB.instance;
  List? unitMemberList;
  List<MatchScoutingData>? dataList;
  List<PitData>? listPitData;
  String googleEmail = "...";
  bool isSignedInToGoogle = false;
  int _selectedTab = 0;

  showAlertOKDialog(BuildContext context, String heading, String text) {
    // set up the buttons
    Widget okButton = TextButton(
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

  _getPitData() async {
    List<PitData> list = await localDB.listPitData();
    setState(() {
      listPitData = list;
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

  Future<File> writeMatchFileAndUploadToGoogle(
      MatchScoutingData matchScoutingData) async {
    DialogBuilder(context).showLoadingIndicator('Uploading Match JSON');
    print("get file Path");
    final file = await _localFile;
    // Write the file.
    print("write file");
    var dataToWrite = json.encode(matchScoutingData.toMap());
    File newFile = await file.writeAsString(dataToWrite.toString());
    print("JSON: " + dataToWrite);
    await googleInterface.uploadFile(
        newFile,
        "MATCH_" +
            matchScoutingData.numMatch.toString() +
            " " +
            matchScoutingData.idTeam.toString() +
            " - " +
            DateTime.now().toString(),
        "json");
    print("Upload Complete");
    DialogBuilder(context).hideOpenDialog();
    checkIsSignedInToGoogle();
    showAlertOKDialog(context, "Upload", "Result uploaded to Google");

    return newFile;
  }

  Future<File> writePitFileAndUploadToGoogle(PitData pitData) async {
    DialogBuilder(context).showLoadingIndicator('Uploading PIT JSON');
    print("getting file Path");
    final file = await _localFile;
    // Write the file.
    print("write file");
    var dataToWrite = json.encode(pitData.toMap());
    File newFile = await file.writeAsString(dataToWrite.toString());
    print("JSON: " + dataToWrite);
    await googleInterface.uploadFile(
        newFile,
        "PIT_" + pitData.idTeam.toString() + " - " + DateTime.now().toString(),
        "json");
    print("Upload Complete: JSON");
    DialogBuilder(context).hideOpenDialog();
    DialogBuilder(context).showLoadingIndicator('Uploading Uniform Image');
    await googleInterface.uploadFile(
        pitData.imgTeamUniform,
        "PIT_TeamUniform" +
            pitData.idTeam.toString() +
            DateTime.now().toString(),
        "jpg");
    DialogBuilder(context).hideOpenDialog();
    DialogBuilder(context).showLoadingIndicator('Uploading Robot Side Image');
    await googleInterface.uploadFile(
        pitData.imgRobotSide,
        "PIT_RobotSide" + pitData.idTeam.toString() + DateTime.now().toString(),
        "jpg");
    DialogBuilder(context).hideOpenDialog();
    DialogBuilder(context).showLoadingIndicator('Uploading Robot Front Image');
    await googleInterface.uploadFile(
        pitData.imgRobotFront,
        "PIT_RobotFront" +
            pitData.idTeam.toString() +
            DateTime.now().toString(),
        "jpg");
    DialogBuilder(context).hideOpenDialog();
    checkIsSignedInToGoogle();
    showAlertOKDialog(context, "Upload", "Result uploaded to Google");
    return newFile;
  }

  checkIsSignedInToGoogle() async {
    isSignedInToGoogle = await googleInterface.isSignedIn();
    googleEmail = await googleInterface.getEmail();
    setState(() {
      googleEmail = googleEmail;
    });
  }

  //style
  double styleFontSizeHeadings = 18;

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
              "Event Name: " + widget.eventName!,
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
        HeadingMain(
          styleFontSize: styleFontSizeHeadings,
          headingText: "Saved Data",
          //backGroundColor: Colors.green,
        ),
        _showTab(_selectedTab)
        //Expanded(
        //   child: _buildListViewMatchData(),
        // ),
        //Text("Saved Pits"),
        //Expanded(
        //  child: _buildListViewPitData(),
        //),
      ]),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.blue,
          selectedItemColor: Colors.white,
          currentIndex: _selectedTab,
          // th
          onTap: (value) {
            setState(() => _selectedTab = value);
          },
          // is will be set when a new tab is tapped
          items: [
            BottomNavigationBarItem(
              icon: new Icon(Icons.settings_remote_outlined),
              label: 'Match Scouting',
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.car_repair),
              label: 'Pits',
            ),
          ]),
    );
  }

  Widget _buildListViewMatchData() {
    return ListView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: dataList == null ? 0 : dataList!.length,
        itemBuilder: (context, index) {
          return _buildRowMatchData(dataList![index]);
        });
  }

  Widget _buildRowMatchData(MatchScoutingData item) {
    //print(item.defenceRating);
    return ListTile(
      title: Text(
        item.id.toString() + ". Match: " + item.numMatch.toString(),
      ),
      subtitle: Text("Team: " + item.idTeam!),
      trailing: Icon(Icons.share),
      onTap: () {
        _showDialogMatchQRCode(context, item.id.toString());
      },
      onLongPress: () {
        writeMatchFileAndUploadToGoogle(item);
      },
    );
  }

  Widget _buildListViewPitData() {
    return ListView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: listPitData == null ? 0 : listPitData!.length,
        itemBuilder: (context, index) {
          return _buildRowPitData(listPitData![index]);
        });
  }

  Widget _buildRowPitData(PitData item) {
    //print(item.defenceRating);
    return ListTile(
      title: Text(
        item.id.toString() + ". PIT: " + item.idTeam.toString(),
      ),
      subtitle: Text("Scout: " + item.txScoutName),
      trailing: Icon(Icons.share),
      onTap: () {
        _showDialogPitQRCode(context, item.id.toString());
      },
      onLongPress: () {
        writePitFileAndUploadToGoogle(item);
      },
    );
  }

  Widget _showTab(int index) {
    if (index == 0) {
      setState(() {});
      return Expanded(
        child: _buildListViewMatchData(),
      );
    } else if (index == 1) {
      setState(() {});
      return Expanded(
        child: _buildListViewPitData(),
      );
    } else {
      return Container(
        child: Text(
          "HOW did you get HERE?????",
          style: TextStyle(fontSize: 18),
        ),
      );
    }
  }

  _showDialogMatchQRCode(BuildContext context, String matchID) async {
    // set up the buttons

    MatchScoutingData match =
        await localDB.getScoringDataRecord(int.parse(matchID));
    var barcodeData = json.encode(match.toMap());
    // set up the AlertDialog
    Dialog dialogQRCodeImage = Dialog(
      child: Container(
        width: 320,
        height: 320,
        child: DisplayQRCode(
          data: barcodeData.toString(),
          styleQRSize: 305.0,
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

  _showDialogPitQRCode(BuildContext context, String pitID) async {
    // set up the buttons

    PitData pit = await localDB.getPitDataRecord(int.parse(pitID));
    var jsonString = json.encode(pit.toMap());
    // set up the AlertDialog
    Dialog dialogQRCodeImage = Dialog(
      child: Container(
        width: 315,
        height: 315,
        child: DisplayQRCode(
          data: jsonString.toString(),
          styleQRSize: 305.0,
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
    _getPitData();
    checkIsSignedInToGoogle();
    _updateGoogleEmail();
  }
}
