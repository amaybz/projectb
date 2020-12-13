import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:projectb/localdb.dart';
import 'dart:async';
import 'package:projectb/scoringdata.dart';
import 'package:projectb/matchscouting.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Project B',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Project B'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  //String dropdownValue = '';
  LocalDB localDB = new LocalDB();
  final TextEditingController _txtDeviceName = TextEditingController();
  final List<String> _locations = [
    'Australia',
    'Canada',
    'China',
    'Chinese Taipei',
    'Israel',
    'Mexico',
    'Taiwan',
    'Turkey'
  ];
  String locationDropDown;

  void _incrementCounter() {
    setState(() {
      _counter++;
      Event event = Event(
        id: _counter,
        name: "test event" + _counter.toString(),
        location: "Australia",
      );
      ScoringData scoringData = ScoringData(
        id: _counter,
        team: "team " + _counter.toString(),
        scoutName: "Aiden",
      );
      localDB.insertEvent(event);
      localDB.insertScoringData(scoringData);
      printEvents();
    });
  }

  void updateDeviceName() async {
    DeviceName deviceName = DeviceName(
      id: 1,
      name: _txtDeviceName.text,
      location: "Australia",
    );
    localDB.updateDeviceDetails(deviceName);
  }

  void printEvents() async {
    print(await localDB.listEvents());
    print(await localDB.listScoringData());
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
              SizedBox(
                width: 100,
                child: Text("Device Name: "),
              ),
              Expanded(
                child: TextField(
                  controller: _txtDeviceName,
                ),
              ),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
              SizedBox(
                width: 100,
                child: Text("Location: "),
              ),
              Expanded(
                child: DropdownButton<String>(
                  hint: Text('Please choose a location'),
                  value: locationDropDown,
                  onChanged: (String newValue) {
                    setState(() {
                      locationDropDown = newValue;
                    });
                  },
                  items: _locations.map((location) {
                    return DropdownMenuItem(
                      child: new Text(location),
                      value: location,
                    );
                  }).toList(),
                ),
              ),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
              SizedBox(
                width: 100,
                child: Text("Event: "),
              ),
              Expanded(
                child: DropdownButton<String>(
                  hint: Text('Please choose a event'),
                  value: locationDropDown,
                  onChanged: (String newValue) {
                    setState(() {
                      locationDropDown = newValue;
                    });
                  },
                  items: _locations.map((location) {
                    return DropdownMenuItem(
                      child: new Text(location),
                      value: location,
                    );
                  }).toList(),
                ),
              ),
            ]),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: FlatButton(
                child: Text("Submit"),
                onPressed: () {
                  updateDeviceName();
                  _navigateToStoredData(context);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: FlatButton(
                child: Text("Match Scouting"),
                onPressed: () {
                  updateDeviceName();
                  _navigateToMatchScoutingScreen(context);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Text(
                '$_counter',
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  _navigateToStoredData(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.push(
      context,
      // Create the SelectionScreen in the next step.
      MaterialPageRoute(builder: (context) => ScoringDataScreen()),
    );
  }
  _navigateToMatchScoutingScreen(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.push(
      context,
      // Create the SelectionScreen in the next step.
      MaterialPageRoute(builder: (context) => MatchScoutingScreen()),
    );
  }
}
