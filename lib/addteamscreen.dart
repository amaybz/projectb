import 'package:flutter/material.dart';
import 'package:projectb/localdb.dart';

class AddTeam extends StatefulWidget {
  @override
  _AddTeamState createState() => _AddTeamState();
}

class _AddTeamState extends State<AddTeam> {
  final txTeamID = TextEditingController();
  final txTeamName = TextEditingController();

  LocalDB localDB = LocalDB.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Local Team'), actions: <Widget>[]),
      body: Container(
        child: ListView(children: [
          FractionallySizedBox(
            widthFactor: 0.95,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              width: 200,
              //height: 100,
              child: Text(
                  "Note: Local teams added here will be cleared if the event is changed or if team data is downloaded from the API"),
            ),
          ),
          FractionallySizedBox(
            widthFactor: 0.95,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              width: 200,
              //height: 100,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Team ID: ",
                      style: TextStyle(fontSize: 12),
                    ),
                    Expanded(
                      child: TextField(
                        controller: txTeamID,
                        style: TextStyle(fontSize: 12),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'ID number for the Team',
                        ),
                      ),
                    ),
                  ]),
            ),
          ),
          FractionallySizedBox(
            widthFactor: 0.95,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              width: 200,
              //height: 100,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Team Name: ",
                      style: TextStyle(fontSize: 12),
                    ),
                    Expanded(
                      child: TextField(
                        controller: txTeamName,
                        style: TextStyle(fontSize: 12),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Name of the Team',
                        ),
                      ),
                    ),
                  ]),
            ),
          ),
          FractionallySizedBox(
            widthFactor: 0.95,
            child: ElevatedButton(
                child: Text("Add Team"),
                onPressed: () {
                  LocalTeam localTeam = LocalTeam(
                      key: txTeamID.text,
                      name: txTeamName.text,
                      nickName: txTeamName.text,
                      teamNumber: txTeamID.text);
                  var insertID = localDB.insertLocalTeam(localTeam);
                  print(insertID);
                }),
          ),
        ]),
      ),
    );
  }
}
