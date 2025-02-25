import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:projectb/class/class_pitdata.dart';
import 'package:projectb/class/class_macthscoutingdata.dart';
import 'package:projectb/localdb.dart';
import 'package:projectb/scanner/mobileScanner.dart';
import 'package:projectb/widgets/widget_ShowAlertDialog.dart';

class QRBarcodeScanner extends StatefulWidget {
  const QRBarcodeScanner({Key? key}) : super(key: key);

  @override
  State<QRBarcodeScanner> createState() => _QRBarcodeScannerState();
}

class _QRBarcodeScannerState extends State<QRBarcodeScanner> {
  String _scanBarcode = 'Unknown';
  MatchScoutingData matchScoutingData = MatchScoutingData();
  PitData pitData = PitData();
  LocalDB localDB = LocalDB.instance;
  String _status = 'No Data';

  @override
  void initState() {
    super.initState();
  }

  Future<void> scanMatchScouting() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    setState(() {
      _status = "none";
    });

    barcodeScanRes = '{none}';

    //convert to Match scouting data
    await Navigator.push(
      context,
      // Create the SelectionScreen in the next step.
      MaterialPageRoute(
          builder: (context) => BarcodeScannerWithOverlay(
                onBarcodeScanned: (barcode) {
                  barcodeScanRes = barcode;
                },
              )),
    );

    try {
      var jsonString = json.decode(barcodeScanRes);
      matchScoutingData = MatchScoutingData.fromMap(jsonString);
      print("matchScoutingData ID: " + matchScoutingData.id.toString());
      print("matchScoutingData Team: " + matchScoutingData.idTeam.toString());
      matchScoutingData.id = null;
      if (matchScoutingData.numMatch != null) {
        _status = ((await localDB.insertScoringData(matchScoutingData))! > 0)
            ? "Record Saved"
            : "Failed to Save Record";
        barcodeScanRes = matchScoutingData.idTeam.toString();
      } else {
        barcodeScanRes = "Invalid Data";
        _status = "Incorrect Format";
      }
    } on Exception {
      barcodeScanRes = "Invalid Data";
      _status = "Incorrect Format";
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
    ShowAlertDialog(context).oKDialog("Scan Data", _status);
    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  Future<void> scanPitData() async {
    String barcodeScanRes;
    setState(() {
      _status = "none";
    });

    barcodeScanRes = '{none}';

    //convert to Match scouting data
    await Navigator.push(
      context,
      // Create the SelectionScreen in the next step.
      MaterialPageRoute(
          builder: (context) => BarcodeScannerWithOverlay(
                onBarcodeScanned: (barcode) {
                  barcodeScanRes = barcode;
                },
              )),
    );

    var jsonString = json.decode(barcodeScanRes);
    pitData = PitData.fromMap(jsonString);
    print("PitData ID: " + pitData.id.toString());
    print("PitData event: " + pitData.txEvent.toString());
    print("PitData Notes: " + pitData.txPitNotes.toString());
    pitData.id = null;
    pitData.uploaded = false;
    if (pitData.txPitNotes != null) {
      _status = ((await localDB.insertPitData(pitData))! > 0)
          ? "Record Saved"
          : "Failed to Save Record";
      barcodeScanRes = pitData.idTeam.toString();
      ShowAlertDialog(context).oKDialog("Scan Data", _status);
    } else {
      barcodeScanRes = "Invalid Data";
      _status = "Incorrect Format";
      ShowAlertDialog(context).oKDialog("Scan Data", _status);
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('QR Barcode Scanner')),
        body: Builder(builder: (BuildContext context) {
          return Container(
              alignment: Alignment.center,
              child: Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 16.0),
                      child: ElevatedButton(
                          onPressed: () => scanMatchScouting(),
                          child: Text('Scan Match Data')),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 16.0),
                      child: ElevatedButton(
                          onPressed: () => scanPitData(),
                          child: Text('Scan Pit Data')),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: Text('Team : $_scanBarcode\n',
                          style: TextStyle(fontSize: 20)),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: Text('Last Status: $_status\n',
                          style: TextStyle(fontSize: 20)),
                    ),
                  ])));
        }));
  }
}
