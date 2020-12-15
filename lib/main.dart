import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:projectb/localdb.dart';
import 'dart:async';
import 'package:projectb/scoringdata.dart';
import 'package:projectb/matchscouting.dart';
import 'package:projectb/webapi.dart';

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

        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Project B'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  //String dropdownValue = '';
  LocalDB localDB = new LocalDB();
  WebAPI webAPI = new WebAPI();
  final TextEditingController _txtDeviceName = TextEditingController();

  String locationDropDown;
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

  //used to store all events from API
  List<EventData> allEvents;
  //used to store events for a location
  List<EventData> eventsForLocation;
  //used to fill the dropdown box
  List<EventsList> eventsList = [];
  List<DropdownMenuItem<String>> eventListDropDown = [];
  //used to store the current selected event
  EventData currentEvent;


  void _incrementCounter() {
    //used for testing only
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
      //localDB.insertEvent(event);
      //localDB.insertScoringData(scoringData);

      //needs to be moved to a update button
      updateEventsFromAPI();


    });
  }

  void updateDeviceName() async {
    DeviceName deviceName = DeviceName(
      id: 1,
      name: _txtDeviceName.text,
      location: "Australia",
    );
    //localDB.updateDeviceDetails(deviceName);
  }

  void updateEventsFromAPI() async {
    //print(await localDB.listEvents());
    //print(await localDB.listScoringData());
    //gets all events from API
    allEvents = await webAPI.getEventsByYear(2020);
    setEventItems();
  }

  setEventItems() {
    //clear current selected event and dropdown box
    setState(() {
      currentEvent = null;
      eventListDropDown.clear();
    });
    //get events based on location
    eventsForLocation = allEvents.where((i) => i.country == locationDropDown).toList();
    //clear event list and update it with new events
    eventsList.clear();
    eventsForLocation.forEach((i) {
      eventsList.add(EventsList(name: i.shortName, key: i.key));
    });
    //update dropdown box with the new events
    for (EventsList event in eventsList) {
      setState(() {
        eventListDropDown.add(new DropdownMenuItem(
            value: event.key,
            child: Text(
              event.name,
              style: TextStyle(fontSize: 20),
            )));
      });
    }
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
        child: Container(
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
                    setEventItems();
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
                  isExpanded: true,
                  hint: Text('Please choose a event'),
                  value: currentEvent == null ? null : currentEvent.key,
                  onChanged: (item) {
                    setState(() {
              currentEvent = eventsForLocation.firstWhere(
              (loc) => loc.key == item,
              orElse: () => eventsForLocation.first);
                    });
                  },
                  items: eventListDropDown,
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
                //style: Theme.of(context).textTheme.headline4,
              ),
            ),
          ],
        ),
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

class EventsList {
  final String key;
  final String name;

  EventsList({this.key, this.name});
}
