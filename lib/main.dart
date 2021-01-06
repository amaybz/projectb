import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:projectb/localdb.dart';
import 'dart:async';
import 'package:projectb/scoringdata.dart';
import 'package:projectb/matchscouting.dart';
import 'package:projectb/sharedprefs.dart';
import 'package:projectb/webapi.dart';
import 'package:projectb/loadingwidget.dart';

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
      home: MyHomePage(title: 'Robot Match Scouting'),
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

  LocalDB localDB = LocalDB.instance;
  WebAPI webAPI = new WebAPI();
  MySharedPrefs mySharedPrefs = new MySharedPrefs();

  TextEditingController _txtDeviceName = TextEditingController();
  static int _downloadingData = 0;
  String _downloadingText = "Please select Location and Event to download data";

  String locationDropDown;
  final List<String> _locations = [
    //'Australia',
    'Canada',
    'China',
    //'Chinese Taipei',
    //'Israel',
    'Mexico',
    //'Taiwan',
    //'Turkey',
    'USA',
  ];

  //used to store all events from API
  List<EventData> allEvents;
  //used to store events for a location
  List<EventData> eventsForLocation;
  //used to fill the dropdown box
  List<EventsList> eventsList = [];
  List<DropdownMenuItem<String>> eventListDropDown = [];
  //used to store the current selected event
  EventData selectedEvent;
  LocalEvent selectedLocalEvent;

  List<TeamsList> eventTeams;

  @override
  void initState() {
    super.initState();
    //get events from API
    updateEventsFromAPI();
    //update device name from local db
    getDeviceName();
    setLocalEvent();
  }

  void setLocalEvent() async {
    String savedEventKey = await mySharedPrefs.readStr("currentEvent");
    List<LocalEvent> listSelectedLocalEvents =  await localDB.getEvent(savedEventKey);
    setState(() {
      selectedLocalEvent = listSelectedLocalEvents.first;
    });
    print("LocalEvent: " + selectedLocalEvent.key);
  }

  void downloadData() async {


    //used for testing only
    //TESTING CODE
    ScoringData scoringData = ScoringData(
      id: _counter,
      team: "team " + _counter.toString(),
      scoutName: "Aiden",
    );

    localDB.insertScoringData(scoringData);
    //END TESTING CODE

    setState(() {
      _downloadingData = 1;
      _counter++;
    });
    //add event to local DB
    LocalEvent event = LocalEvent(
      key: selectedEvent.key,
      name: selectedEvent.name,
      shortName: selectedEvent.shortName,
      location: selectedEvent.country,
    );
    localDB.insertEvent(event);
    //Update current Device Name
    updateDeviceName();
    //update Events from API
    await updateEventsFromAPI();
    //update teams if event is selected
    if (selectedEvent.key != null) {
      await getEventTeamsFromAPI(selectedEvent.key);
    }
    //set Downloading status to complete
    setState(() {
      _downloadingData = 2;
    });
  }

  void updateDeviceName() async {
    DeviceName deviceName = DeviceName(
      id: 1,
      name: _txtDeviceName.text,
      location: locationDropDown,
    );
    localDB.updateDeviceDetails(deviceName);
  }

  void getDeviceName() async {
    DeviceName deviceName = await localDB.getDeviceName();
    if (deviceName == null) {
      setState(() {
        _txtDeviceName.text = "";
      });
    } else {
      setState(() {
        _txtDeviceName.text = deviceName.name;
        //locationDropDown = deviceName.location;
      });
    }
  }

  Future<void> updateEventsFromAPI() async {
    //print(await localDB.listEvents());
    //print(await localDB.listScoringData());
    //gets all events from API
    allEvents = await webAPI.getEventsByYear(2021);
    //setEventItems();
  }

  Future<void> getEventTeamsFromAPI(String eventKey) async {
    setState(() {
      _downloadingData = 1;
    });

    eventTeams = await webAPI.getTeamsByEvent(eventKey);
    if (eventTeams == null) {
      setState(() {
        _downloadingData = 0;
        _downloadingText = "Unable to connect to Remote Host";
      });
    } else {
      setState(() {
        _downloadingData = 2;
        _downloadingText = "Please select Location and Event to download data";
      });
    }
  }

  setEventItems() async {
    //clear current selected event and dropdown box
    setState(() {
      selectedEvent = null;
      eventListDropDown.clear();
      _downloadingData = 0;
    });
    //get events based on location
    if (allEvents == null) {
      updateEventsFromAPI();
    }
    eventsForLocation =
        allEvents.where((i) => i.country == locationDropDown).toList();
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
              style: TextStyle(fontSize: 16),
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
          margin: const EdgeInsets.all(5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
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
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
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
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: 100,
                      child: Text("Event: "),
                    ),
                    Expanded(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        hint: Text('Please choose a event'),
                        value: selectedEvent == null ? null : selectedEvent.key,
                        onChanged: (item) {
                          setState(() {
                            selectedEvent = eventsForLocation.firstWhere(
                                (loc) => loc.key == item,
                                orElse: () => eventsForLocation.first);
                          });
                          print("Key: " + selectedEvent.key.toString());
                          getEventTeamsFromAPI(selectedEvent.key);
                        },
                        items: eventListDropDown,
                      ),
                    ),
                  ]),
              LoadingImage(
                state: _downloadingData,
                text: _downloadingText,
              ),
              FractionallySizedBox(
                widthFactor: 0.99,
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 800.0),
                    child: Container(
                      margin: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blueAccent),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                      ),
                      padding: EdgeInsets.all(4.0),
                      child: Column(
                        children: [
                          Text("Current Selected Event:"),
                          Text(selectedLocalEvent == null ? "none" : selectedLocalEvent.shortName)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: FlatButton(
                  child: Text("Set Event"),
                  onPressed: () {
                    updateDeviceName();
                    if (selectedEvent != null) {

                      mySharedPrefs.saveStr("currentEvent", selectedEvent.key);
                      setLocalEvent();

                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: FlatButton(
                  child: Text("Saved Records"),
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
                    if (selectedLocalEvent != null) {
                      _navigateToMatchScoutingScreen(context);
                    }
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
        onPressed: downloadData,
        tooltip: 'Download Data from API',
        child: Icon(Icons.download_outlined),
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

      MaterialPageRoute(
          builder: (context) => MatchScoutingScreen(
                eventName: selectedLocalEvent.shortName,
                eventKey: selectedLocalEvent.key,
                eventTeams: eventTeams,
              )),
    );
  }
}

class EventsList {
  final String key;
  final String name;

  EventsList({this.key, this.name});
}
