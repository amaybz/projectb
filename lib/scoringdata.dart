import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:projectb/localdb.dart';
import 'dart:async';
import 'package:projectb/displayqrcode.dart';
import 'package:projectb/googleinterface.dart';
import 'dart:io';
import 'package:projectb/class/class_pitdata.dart';
import 'package:projectb/class/class_macthscoutingdata.dart';
import 'package:projectb/widgets/widget_headingmain.dart';
import 'package:projectb/widgets/widget_loading_popup.dart';
import 'package:projectb/widgets/widget_uploadedimg.dart';
import 'package:permission_handler/permission_handler.dart';

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
  double styleQRSize = 320;
  bool sort = false;

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
      dataList?.sort((a, b) => b.id!.compareTo(a.id!));
    });
  }

  _getPitData() async {
    List<PitData> list = await localDB.listPitData();
    setState(() {
      listPitData = list;
      listPitData?.sort((a, b) => b.id!.compareTo(a.id!));
    });
  }

  _sortList() {
    if (_selectedTab == 0) {
      if (sort == true) {
        dataList?.sort((a, b) => b.id!.compareTo(a.id!));
        setState(() {
          dataList = dataList;
          sort = false;
        });
      } else {
        dataList?.sort((a, b) => a.id!.compareTo(b.id!));
        setState(() {
          dataList = dataList;
          sort = true;
        });
      }
    }
    if (_selectedTab == 1) {
      if (sort == true) {
        listPitData?.sort((a, b) => b.id!.compareTo(a.id!));
        setState(() {
          listPitData = listPitData;
          sort = false;
        });
      } else {
        listPitData?.sort((a, b) => a.id!.compareTo(b.id!));
        setState(() {
          listPitData = listPitData;
          sort = true;
        });
      }
    }
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

  Future<String?> get _externalPath async {
    final directory =
        await Directory("/storage/emulated/0/Download/RobotMatchScouting/")
            .create(recursive: true);
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/temp.json');
  }

  Future<File> writeMatchFileToDownloads(
      MatchScoutingData matchScoutingData) async {
    Permission.manageExternalStorage.request();
    DialogBuilder(context).showLoadingIndicator('Saving Match JSON');
    print("get file Path");
    final file = await _localFile;
    final exFilepath = await _externalPath;
    print("External File Path: " + exFilepath!);
    // Write the file.
    print("writing to file");
    var dataToWrite = json.encode(matchScoutingData.toMap());
    File newFile = await file.writeAsString(dataToWrite.toString());

    newFile.copy(exFilepath +
        "/MATCH " +
        matchScoutingData.numMatch.toString() +
        " " +
        matchScoutingData.idTeam.toString() +
        ".json");

    print("JSON: " + dataToWrite);
    print("Save Complete");
    DialogBuilder(context).hideOpenDialog();
    showAlertOKDialog(context, "Download", "Result Downloaded");
    return newFile;
  }

  Future<File> writeMatchFileAndUploadToGoogle(
      MatchScoutingData matchScoutingData) async {
    Permission.manageExternalStorage.request();
    DialogBuilder(context).showLoadingIndicator('Uploading Match JSON');
    print("get file Path");
    final file = await _localFile;
    final exFilepath = await _externalPath;
    print("External File Path: " + exFilepath!);
    // Write the file.
    print("writing to file");
    var dataToWrite = json.encode(matchScoutingData.toMap());
    File newFile = await file.writeAsString(dataToWrite.toString());

    newFile.copy(exFilepath! +
        "/MATCH " +
        matchScoutingData.numMatch.toString() +
        " " +
        matchScoutingData.idTeam.toString() +
        ".json");

    print("JSON: " + dataToWrite);
    await googleInterface.uploadFile(
        newFile,
        "MATCH_" +
            matchScoutingData.numMatch.toString() +
            " " +
            matchScoutingData.idTeam.toString() +
            " - " +
            DateTime.now().toString(),
        ".json");
    print("Upload Complete");
    setState(() {
      matchScoutingData.flUploaded = true;
    });
    localDB.insertScoringData(matchScoutingData);

    DialogBuilder(context).hideOpenDialog();
    checkIsSignedInToGoogle();
    showAlertOKDialog(context, "Upload", "Result uploaded to Google");

    return newFile;
  }

  Future<File> writePitFileToDownloads(PitData pitData) async {
    bool fileExists;
    DialogBuilder(context).showLoadingIndicator('Saving PIT JSON');
    print("get file Path");
    final file = await _localFile;
    final exFilepath = await _externalPath;
    print("External File Path: " + exFilepath!);
    // Write the file.
    print("write file");
    var dataToWrite = json.encode(pitData.toMap());
    File newFile = await file.writeAsString(dataToWrite.toString());
    print("JSON: " + dataToWrite);

    newFile.copy(exFilepath + "PIT_" + pitData.idTeam.toString() + ".json");

    if (pitData.imgTeamUniform != null) {
      fileExists = await File(pitData.imgTeamUniform!.path).exists();
    } else {
      fileExists = false;
    }
    if (fileExists == true) {
      pitData.imgTeamUniform!.copy(exFilepath +
          pitData.idTeam.toString() +
          " PIT_TeamUniform" +
          pitData.idTeam.toString() +
          ".jpg");
    }

    if (pitData.imgRobotSide != null) {
      fileExists = await File(pitData.imgRobotSide!.path).exists();
    } else {
      fileExists = false;
    }
    if (fileExists == true) {
      pitData.imgRobotSide!.copy(exFilepath +
          pitData.idTeam.toString() +
          " PIT_RobotSide" +
          pitData.idTeam.toString() +
          ".jpg");
    }

    if (pitData.imgRobotFront != null) {
      fileExists = await File(pitData.imgRobotFront!.path).exists();
    } else {
      fileExists = false;
    }
    if (fileExists == true) {
      pitData.imgRobotFront!.copy(exFilepath +
          pitData.idTeam.toString() +
          " PIT_RobotFront" +
          pitData.idTeam.toString() +
          ".jpg");
    }

    DialogBuilder(context).hideOpenDialog();
    showAlertOKDialog(context, "Download", "Result Downloaded to Device");

    return newFile;
  }

  Future<File> writePitFileAndUploadToGoogle(PitData pitData) async {
    bool fileExists;
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
    setState(() {
      pitData.uploaded = true;
    });
    localDB.insertPitData(pitData);
    DialogBuilder(context).hideOpenDialog();
    showAlertOKDialog(context, "Upload",
        "Result uploaded to Google, images are still uploading");
    checkIsSignedInToGoogle();

    if (pitData.imgTeamUniform != null) {
      fileExists = await File(pitData.imgTeamUniform!.path).exists();
    } else {
      fileExists = false;
    }
    if (fileExists == true) {
      googleInterface.uploadFile(
          pitData.imgTeamUniform!,
          pitData.idTeam.toString() +
              " PIT_TeamUniform" +
              pitData.idTeam.toString() +
              DateTime.now().toString(),
          "jpg");
    }

    if (pitData.imgRobotSide != null) {
      fileExists = await File(pitData.imgRobotSide!.path).exists();
    } else {
      fileExists = false;
    }
    if (fileExists == true) {
      googleInterface.uploadFile(
          pitData.imgRobotSide!,
          pitData.idTeam.toString() +
              " PIT_RobotSide" +
              pitData.idTeam.toString() +
              DateTime.now().toString(),
          "jpg");
    }

    if (pitData.imgRobotFront != null) {
      fileExists = await File(pitData.imgRobotFront!.path).exists();
    } else {
      fileExists = false;
    }
    if (fileExists == true) {
      googleInterface.uploadFile(
          pitData.imgRobotFront!,
          pitData.idTeam.toString() +
              " PIT_RobotFront" +
              pitData.idTeam.toString() +
              DateTime.now().toString(),
          "jpg");
    }

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
    if (width < 393) {
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

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Theme.of(context).splashColor,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          'Saved Match Scouting',
          style: styleTitleTextTheme,
        ),
      ),
      body: Column(children: <Widget>[
        FractionallySizedBox(
          widthFactor: 0.9,
          child: Container(
            margin: const EdgeInsets.all(15.0),
            decoration: BoxDecoration(
              //border: Border.all(color: Colors.blueAccent),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
            ),
            padding: EdgeInsets.all(4.0),
            child: Column(
              children: [
                Text(
                  "Google Account: " + googleEmail,
                  style: styleBodyTextTheme,
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
              ],
            ),
          ),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          HeadingMain(
            styleFontSize: styleTitleTextTheme!.fontSize!,
            headingText: "Saved Records",
            backGroundColor: Theme.of(context).primaryColor,
          ),
          ElevatedButton(
            onPressed: () {
              _sortList();
            },
            child: Image.asset(
              'assets/imgs/sort.png',
              scale: 20,
            ),
          ),
        ]),

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
        padding: const EdgeInsets.all(5.0),
        itemCount: dataList == null ? 0 : dataList!.length,
        itemBuilder: (context, index) {
          return _buildRowMatchData(dataList![index]);
        });
  }

  Widget _buildRowMatchData(MatchScoutingData item) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              children: [
                Text(
                  item.id.toString() + ". Match: " + item.numMatch.toString(),
                  style: styleBodyTextTheme,
                ),
                Text(
                  "Team: " + item.idTeam.toString(),
                  style: styleBodyTextTheme,
                )
              ],
            ),
            Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 2.5),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Theme.of(context).primaryColorDark, // background
                      foregroundColor:
                          Theme.of(context).splashColor, // foreground
                    ),
                    onPressed: () {
                      _showDialogMatchQRCode(context, item.id.toString());
                    },
                    child: Text('QR'),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 2.5),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).primaryColorDark, // background
                        foregroundColor:
                            Theme.of(context).splashColor, // foreground
                      ),
                      onPressed: () {
                        writeMatchFileAndUploadToGoogle(item);
                      },
                      child: UploadedImg(state: item.flUploaded!)),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 2.5),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Theme.of(context).primaryColorDark, // background
                      foregroundColor:
                          Theme.of(context).splashColor, // foreground
                    ),
                    onPressed: () {
                      writeMatchFileToDownloads(item);
                    },
                    child: Image.asset(
                      'assets/imgs/download.png',
                      scale: 2,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 2.5),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red, // background
                      foregroundColor: Colors.white, // foreground
                    ),
                    onPressed: () {
                      deleteMatchRecord(context, item.id!);

                      setState(() {});
                    },
                    child: Image.asset(
                      'assets/imgs/delete.png',
                      scale: 2,
                    ),
                  ),
                ),
              ]),
            ]),
          ]),
    );

    //print(item.defenceRating);
    //return ListTile(
    //  title: Text(
    //    item.id.toString() + ". Match: " + item.numMatch.toString(),
    //   ),
    //   subtitle: Text("Team: " + item.idTeam!),
    //   trailing: Icon(Icons.share),
    //   onTap: () {
    //     _showDialogMatchQRCode(context, item.id.toString());
    //   },
    //   onLongPress: () {
    //     writeMatchFileAndUploadToGoogle(item);
    //   },
    //);
  }

  deleteMatchRecord(BuildContext context, int id) {
    // set up the buttons
    Widget cancelButton = ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green, // background
        foregroundColor: Colors.white, // foreground
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: Text('Cancel'),
    );
    Widget continueButton = ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red, // background
        foregroundColor: Colors.white, // foreground
      ),
      onPressed: () {
        Navigator.of(context).pop();
        localDB.deleteMatchData(id);
        _getScoringData();
      },
      child: Text('Delete'),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("WARNING"),
      content: Text("Are you sure you want to delete this record?"),
      actions: [
        cancelButton,
        continueButton,
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

  Widget _buildListViewPitData() {
    return ListView.builder(
        padding: const EdgeInsets.all(5.0),
        itemCount: listPitData == null ? 0 : listPitData!.length,
        itemBuilder: (context, index) {
          return _buildRowPitData(listPitData![index]);
        });
  }

  Widget _buildRowPitData(PitData item) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              children: [
                Text(
                  item.id.toString() + ". PIT: " + item.idTeam.toString(),
                  style: styleBodyTextTheme,
                ),
                Text(
                  "Scout: " + item.txScoutName!,
                  style: styleBodyTextTheme,
                ),
              ],
            ),
            Column(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 2.5),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context)
                                .primaryColorDark, // background
                            foregroundColor:
                                Theme.of(context).splashColor, // foreground
                          ),
                          onPressed: () {
                            _showDialogPitQRCode(context, item.id.toString());
                          },
                          child: Text('QR'),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 2.5),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context)
                                  .primaryColorDark, // background
                              foregroundColor:
                                  Theme.of(context).splashColor, // foreground
                            ),
                            onPressed: () {
                              writePitFileAndUploadToGoogle(item);
                            },
                            child: UploadedImg(state: item.uploaded!)),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 2.5),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context)
                                .primaryColorDark, // background
                            foregroundColor:
                                Theme.of(context).splashColor, // foreground
                          ),
                          onPressed: () {
                            writePitFileToDownloads(item);
                          },
                          child: Image.asset(
                            'assets/imgs/download.png',
                            scale: 2,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 2.5),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red, // background
                            foregroundColor: Colors.white, // foreground
                          ),
                          onPressed: () {
                            deletePitRecord(context, item.id!);

                            setState(() {});
                          },
                          child: Image.asset(
                            'assets/imgs/delete.png',
                            scale: 2,
                          ),
                        ),
                      ),
                    ]),
              ],
            ),
          ]),
    );
  }

  deletePitRecord(BuildContext context, int id) {
    // set up the buttons
    Widget cancelButton = ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green, // background
        foregroundColor: Colors.white, // foreground
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: Text('Cancel'),
    );
    Widget continueButton = ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red, // background
        foregroundColor: Colors.white, // foreground
      ),
      onPressed: () {
        Navigator.of(context).pop();
        localDB.deletePitData(id);
        _getPitData();
      },
      child: Text('Delete'),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("WARNING"),
      content: Text("Are you sure you want to delete this record?"),
      actions: [
        cancelButton,
        continueButton,
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

    double width = MediaQuery.of(context).size.width;
    print("Screen Size: " + width.toString());

    if (width < 600) {
      setState(() {
        styleQRSize = 380;
      });
    }
    if (width < 500) {
      setState(() {
        styleQRSize = 360;
      });
    }
    if (width < 450) {
      setState(() {
        styleQRSize = 325;
      });
    }
    if (width < 393) {
      setState(() {
        styleQRSize = 320;
      });
    }
    if (width >= 600) {
      setState(() {
        styleQRSize = 400;
      });
    }

    print("QR Size: " + styleQRSize.toString());

    MatchScoutingData match =
        await localDB.getScoringDataRecord(int.parse(matchID));
    var barcodeData = json.encode(match.toMap());
    // set up the AlertDialog
    Dialog dialogQRCodeImage = Dialog(
      child: Container(
        width: styleQRSize,
        height: styleQRSize,
        child: DisplayQRCode(
          data: barcodeData.toString(),
          styleQRSize: styleQRSize - 15,
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
    double width = MediaQuery.of(context).size.width;
    print("Screen Size: " + width.toString());
    if (width < 600) {
      setState(() {
        styleQRSize = 380;
      });
    }
    if (width < 500) {
      setState(() {
        styleQRSize = 350;
      });
    }
    if (width < 450) {
      setState(() {
        styleQRSize = 325;
      });
    }
    if (width < 393) {
      setState(() {
        styleQRSize = 320;
      });
    }
    if (width >= 600) {
      setState(() {
        styleQRSize = 400;
      });
    }
    print("QR PIT Size: " + styleQRSize.toString());
    PitData pit = await localDB.getPitDataRecord(int.parse(pitID));
    var jsonString = json.encode(pit.toMap());
    // set up the AlertDialog
    Dialog dialogQRCodeImage = Dialog(
      child: Container(
        width: styleQRSize,
        height: styleQRSize,
        child: DisplayQRCode(
          data: jsonString.toString(),
          styleQRSize: styleQRSize - 15,
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
