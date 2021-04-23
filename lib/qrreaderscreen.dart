// @dart = 2.7

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:projectb/class_pitdata.dart';
import 'dart:convert';
import 'package:projectb/localdb.dart';


class QRReaderScreen extends StatefulWidget {
  @override
  _QRReaderScreenState createState() => _QRReaderScreenState();
}

class _QRReaderScreenState extends State<QRReaderScreen> {
  LocalDB localDB = LocalDB.instance;

  var barcode = "";
  String status = "";
  PitData pitData;
  MatchScoutingData matchScoutingData;
  @override
  initState() {
    super.initState();
  }

  Future scanPit() async {
    try {
      //var options = ScanOptions(autoEnableFlash: true);
      var barcode = await BarcodeScanner.scan();
      setState(() => this.barcode = barcode.rawContent.toString());
      var jsonString = json.decode(this.barcode);
      pitData = PitData.fromMap(jsonString);
      print("PitData ID: " + pitData.id.toString());
      print("PitData event: " + pitData.txEvent.toString());
      pitData.id = null;
      status = (await localDB.insertPitData(pitData) > 0 )? "Record Saved" : "Failed to Save Record";
      setState(() {

      });
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.cameraAccessDenied) {
        setState(() {
          this.barcode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    } on FormatException {
      setState(() => this.barcode =
      'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }

  Future scanMatchScouting() async {
    try {
      //var options = ScanOptions(autoEnableFlash: true);
      var barcode = await BarcodeScanner.scan();
      setState(() => this.barcode = barcode.rawContent.toString());
      var jsonString = json.decode(this.barcode);
      matchScoutingData = MatchScoutingData.fromMap(jsonString);
      print("matchScoutingData ID: " + matchScoutingData.id.toString());
      print("matchScoutingData Team: " + matchScoutingData.idTeam);
      matchScoutingData.id = null;
      status = (await localDB.insertScoringData(matchScoutingData) > 0 )? "Record Saved" : "Failed to Save Record";
      setState(() {

      });
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.cameraAccessDenied) {
        setState(() {
          this.barcode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    } on FormatException {
      setState(() => this.barcode =
      'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text('QR Code Scanner'),
        ),
        body: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: ElevatedButton(
                    //color: Colors.blue,
                    //textColor: Colors.white,
                    //splashColor: Colors.blueGrey,
                    onPressed: scanMatchScouting,
                    child: const Text('Scan Match Scouting Data')),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: ElevatedButton(
                    //color: Colors.blue,
                    //textColor: Colors.white,
                    //splashColor: Colors.blueGrey,
                    onPressed: scanPit,
                    child: const Text('Scan Pit Data')),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(
                  "Result: " + status,
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(
                  "Data: " + barcode,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ));
  }
}

