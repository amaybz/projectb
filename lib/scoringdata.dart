import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:projectb/localdb.dart';
import 'dart:async';

class ScoringDataScreen extends StatefulWidget {
  @override
  _ScoringDataScreenState createState() => _ScoringDataScreenState();
}

class _ScoringDataScreenState extends State<ScoringDataScreen> {
  LocalDB localDB = new LocalDB();
  List unitMemberList;
  List<ScoringData> dataList;

  _getScoringData() async {
    List<ScoringData> list = await localDB.listScoringData();
    setState(() {
      dataList = list;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Match Scores'),
      ),
      body: Column(children: <Widget>[
      FractionallySizedBox(
        widthFactor: 0.9,
      child: Container(
            margin: const EdgeInsets.all(15.0),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.blueAccent)
            ),
            padding: EdgeInsets.all(4.0),
            child: Text(
              "Event Name: ",
              style: TextStyle(fontSize: 18),
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

  Widget _buildRow(dynamic item) {
    return ListTile(
      title: Text(
        item.id.toString(),
      ),
      subtitle: Text(
        item.team + " " + item.scoutName,
      ),
      trailing: Icon(Icons.share),
      onTap: () {},
    );
  }

  @override
  void initState() {
    super.initState();
    // Call the getJSONData() method when the app initializes
    _getScoringData();
  }
}
