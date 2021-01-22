import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:projectb/localdb.dart';
import 'package:projectb/pitscouting.dart';
import 'dart:async';
import 'package:projectb/scoringdata.dart';
import 'package:projectb/matchscouting.dart';
import 'package:projectb/sharedprefs.dart';
import 'package:projectb/webapi.dart';
import 'package:projectb/widget_loading.dart';
//import 'package:permission_handler/permission_handler.dart';
import 'package:projectb/qrreaderscreen.dart';

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
  LocalDB localDB = LocalDB.instance;
  WebAPI webAPI = new WebAPI();
  MySharedPrefs mySharedPrefs = new MySharedPrefs();
  //style
  double styleFontSize;

  TextEditingController _txtDeviceName = TextEditingController();
  static int _downloadingData = 0;
  static int _countOfTeams = 0;
  String _downloadingText = "Please select Location and Event to download data";

  String locationDropDown;
  String selectedYear = "2021";
  final List<String> _locations = [
    'Australia',
    'Canada',
    'China',
    'Chinese Taipei',
    'Israel',
    'Mexico',
    'Taiwan',
    'Turkey',
    'USA',
  ];

  final List<String> _year = ['2020', '2021'];

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
    updateEventsFromAPI(selectedYear);
    //update device name from local db
    getDeviceName();
    setLocalEvent();
  }

  void setLocalEvent() async {
    String savedEventKey = await mySharedPrefs.readStr("currentEvent");
    List<LocalEvent> listSelectedLocalEvents =
        await localDB.getEvent(savedEventKey);
    List<LocalTeam> listSelectedLocalTeams = await localDB.listLocalTeams();

    setState(() {
      selectedLocalEvent = listSelectedLocalEvents.length > 0
          ? listSelectedLocalEvents.first
          : null;
      _countOfTeams =
          listSelectedLocalTeams != null ? listSelectedLocalTeams.length : 0;
    });
    //print("LocalEvent: " + selectedLocalEvent.key);

    if (eventTeams == null) {
      print("No Teams");
    } else {
      localDB.clearLocalTeams();
      for (TeamsList team in eventTeams) {
        LocalTeam insertTeam = LocalTeam(
            key: team.key,
            name: team.name,
            nickName: team.nickname,
            teamNumber: team.teamNumber.toString());
        //print(insertTeam.teamNumber);
        localDB.insertLocalTeam(insertTeam);
      }
    }
  }

  void downloadData() async {
    //if (await Permission.storage.status == PermissionStatus.granted) {
    //  print(await Permission.storage.status);
    //} else {
    //  print(await Permission.storage.status);
    //  await Permission.storage.request();
    //}
    //display downloading icon
    setState(() {
      _downloadingData = 1;
    });
    //Update current Device Name
    updateDeviceName();
    //update Events from API
    await updateEventsFromAPI(selectedYear);
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
      });
    }
  }

  Future<void> updateEventsFromAPI(String year) async {
    //print(await localDB.listEvents());
    //print(await localDB.listScoringData());
    //gets all events from API
    allEvents = await webAPI.getEventsByYear(year);

    //setEventItems();
  }

  Future<void> getEventTeamsFromAPI(String eventKey) async {
    setState(() {
      _downloadingData = 1;
    });

    //add event to local DB
    LocalEvent event = LocalEvent(
      key: selectedEvent.key,
      name: selectedEvent.name,
      shortName: selectedEvent.shortName,
      location: selectedEvent.country,
    );
    localDB.insertEvent(event);

    eventTeams = await webAPI.getTeamsByEvent(eventKey);
    print(eventTeams.length);
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
      localDB.clearLocalTeams();
      for (TeamsList team in eventTeams) {
        LocalTeam insertTeam = LocalTeam(
            key: team.key,
            name: team.name,
            nickName: team.nickname,
            teamNumber: team.teamNumber.toString());
        //print(insertTeam.teamNumber);
        localDB.insertLocalTeam(insertTeam);
      }
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
      updateEventsFromAPI(selectedYear);
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
    //style

    double width = MediaQuery.of(context).size.width;
    print("Screen Size: " + width.toString());

    if (width < 500) {
      setState(() {
        styleFontSize = 14;
      });
    }
    if (width < 393) {
      setState(() {
        styleFontSize = 11;
      });
    }
    if (width >= 600) {
      setState(() {
        styleFontSize = 16;
      });
    }

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Text('Scouting'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Pit Scouting'),
              onTap: () {
                Navigator.pop(context);
                if (selectedLocalEvent != null) {
                  _navigateToPitScoutingScreen(context);
                }
              },
            ),
            ListTile(
              title: Text('Match Scouting'),
              onTap: () {
                Navigator.pop(context);
                if (selectedLocalEvent != null) {
                  _navigateToMatchScoutingScreen(context);
                }
              },
            ),
            ListTile(
              title: Text('Saved Records'),
              onTap: () {
                Navigator.pop(context);
                _navigateToStoredData(context);
              },
            ),
            ListTile(
              title: Text('Read QR Code'),
              onTap: () {
                Navigator.pop(context);
                _navigateToQRReaderScreen(context);
              },
            ),
          ],
        ),
      ),
      body: ListView(
        children: [
          Center(
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
                          child: Text("Year: "),
                        ),
                        Expanded(
                          child: DropdownButton<String>(
                            hint: Text('Please select Year'),
                            value: selectedYear,
                            onChanged: (String newValue) {
                              setState(() {
                                selectedYear = newValue;
                                locationDropDown = null;
                                selectedEvent = null;
                              });
                              updateEventsFromAPI(selectedYear);
                            },
                            items: _year.map((location) {
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
                            value: selectedEvent == null
                                ? null
                                : selectedEvent.key,
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
                              Text("Selected Event:"),
                              //Text(selectedLocalEvent == null ? "none" : selectedLocalEvent.shortName),
                              Text(selectedLocalEvent == null
                                  ? "none"
                                  : selectedLocalEvent.name),
                              Text("Teams Loaded: " + _countOfTeams.toString()),
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
                          mySharedPrefs.saveStr(
                              "currentEvent", selectedEvent.key);
                          setLocalEvent();
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                  ),
                ],
              ),
            ),
          ),
        ],
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
      MaterialPageRoute(
        builder: (context) => ScoringDataScreen(
          eventName: selectedLocalEvent.shortName,
          eventKey: selectedLocalEvent.key,
        ),
      ),
    );
  }

  _navigateToMatchScoutingScreen(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    List<LocalTeam> teams = await localDB.listLocalTeams();
    final result = await Navigator.push(
      context,
      // Create the SelectionScreen in the next step.
      MaterialPageRoute(
          builder: (context) => MatchScoutingScreen(
                eventName: selectedLocalEvent.shortName,
                eventKey: selectedLocalEvent.key,
                eventTeams: teams,
                styleFontSize: this.styleFontSize,
              )),
    );
  }

  _navigateToPitScoutingScreen(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    List<LocalTeam> teams = await localDB.listLocalTeams();
    final result = await Navigator.push(
      context,
      // Create the SelectionScreen in the next step.
      MaterialPageRoute(
          builder: (context) => PitScoutingScreen(
                eventName: selectedLocalEvent.shortName,
                eventKey: selectedLocalEvent.key,
                eventTeams: teams,
                deviceName: _txtDeviceName.text,
              )),
    );
  }

  _navigateToQRReaderScreen(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    //List<LocalTeam> teams = await localDB.listLocalTeams();
    final result = await Navigator.push(
      context,
      // Create the SelectionScreen in the next step.
      MaterialPageRoute(builder: (context) => QRReaderScreen()),
    );
  }
}

class EventsList {
  final String key;
  final String name;

  EventsList({this.key, this.name});
}
