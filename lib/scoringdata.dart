import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:projectb/localdb.dart';
import 'dart:async';
import 'package:projectb/displayqrcode.dart';

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
  LocalDB localDB = LocalDB.instance;
  List unitMemberList;
  List<MatchScoutingData> dataList;

  _getScoringData() async {
    List<MatchScoutingData> list = await localDB.listScoringData();
    setState(() {
      dataList = list;
    });
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
              )),
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
    return ListTile(
      title: Text(
        item.id.toString() + ". Match: " + item.matchNumber.toString(),
      ),
      subtitle: Text("Team: " + item.team),
      trailing: Icon(Icons.share),
      onTap: () {
        _showDialogQRCode(context, item.id.toString());
      },
    );
  }

  _showDialogQRCode(BuildContext context, String matchID) async {
    // set up the buttons

    MatchScoutingData match = await localDB.getScoringDataRecord(int.parse(matchID));
    // set up the AlertDialog
    Dialog dialogQRCodeImage = Dialog(
      child: Container(
      width: 300,
      height: 300,
        child: DisplayQRCode(match: match, styleQRSize: 299.0,),
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
  }
}
