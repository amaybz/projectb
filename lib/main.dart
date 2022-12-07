import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:googleapis/cloudsearch/v1.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:projectb/class/eventmatches.dart';
import 'package:projectb/localdb.dart';
import 'package:projectb/pitscouting.dart';
import 'dart:async';
import 'package:projectb/scoringdata.dart';
import 'package:projectb/matchscouting.dart';
import 'package:projectb/sharedprefs.dart';
import 'package:projectb/webapi.dart';
import 'package:projectb/widget_loading.dart';
import 'package:camera/camera.dart';
import 'package:projectb/addteamscreen.dart';
import 'package:projectb/barcodeScanner.dart';

Future<void> main() async {
  // Ensure that plugin services are initialized so that `availableCameras()`
// can be called before `runApp()`
  WidgetsFlutterBinding.ensureInitialized();

  List<CameraDescription>? cameras;
  // Obtain a list of the available cameras on the device.
  try {
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print("no cameras");
  }
  final firstCamera = cameras?.first;
  runApp(MyApp(camera: firstCamera));
}

class MyApp extends StatelessWidget {
  final CameraDescription? camera;

  const MyApp({
    Key? key,
    @required this.camera,
  }) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus!.unfocus();
        }
      },
      child: DarkLightTheme(camera: camera),
    );
  }
}

class DarkLightTheme extends StatefulWidget {
  const DarkLightTheme({
    Key? key,
    required this.camera,
  }) : super(key: key);
  final CameraDescription? camera;

  @override
  State<DarkLightTheme> createState() => _DarkLightThemeState();
}

bool _light = false;

class _DarkLightThemeState extends State<DarkLightTheme> {
  MySharedPrefs mySharedPrefs = new MySharedPrefs();

  ThemeData _darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.blue,
    splashColor: Colors.white,
    textTheme: const TextTheme(
      headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
      bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
    ),
  );

  ThemeData _lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    splashColor: Colors.green,
    textTheme: const TextTheme(
      headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
      bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Project B',
      theme: _light ? _darkTheme : _lightTheme,
      home: MyHomePage(
        title: 'Home',
        camera: widget.camera,
        theme: _light,
        onchangeTheme: (bool state) {
          setState(() {
            _light = state;
            mySharedPrefs.saveBool("DarkMode", state);
          });
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage(
      {Key? key,
      this.title,
      this.camera,
      this.theme = true,
      this.onchangeTheme})
      : super(key: key);

  final CameraDescription? camera;
  final String? title;
  final bool theme;
  final ValueChanged<bool>? onchangeTheme;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  LocalDB localDB = LocalDB.instance;
  WebAPI webAPI = new WebAPI();
  MySharedPrefs mySharedPrefs = new MySharedPrefs();
  //style
  double styleFontSize = 14;
  String versionName = "";
  String versionCode = "";
  String measurements = "kg";

  TextEditingController _txtDeviceName = TextEditingController();
  static int _downloadingData = 0;
  static int _countOfTeams = 0;
  String _downloadingText = "Please select Location and Event to download data";
  String txtEventHelpText = "Please choose a event";
  String? locationDropDown;
  String selectedYear = "2018";
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
    'Local',
  ];

  List<DropdownMenuItem<String>> _years = [
    DropdownMenuItem(child: new Text("2018"), value: "2018")
  ];

  List<DropdownMenuItem<String>> updateYears() {
    DateTime now = DateTime.now();
    int year = now.year;
    List<DropdownMenuItem<String>> years = [];
    years.clear();
    years.add(DropdownMenuItem(
        child: new Text((year - 2).toString()), value: (year - 2).toString()));
    years.add(DropdownMenuItem(
        child: new Text((year - 1).toString()), value: (year - 1).toString()));
    years.add(DropdownMenuItem(
        child: new Text(year.toString()), value: year.toString()));
    years.add(DropdownMenuItem(
        child: new Text((year + 1).toString()), value: (year + 1).toString()));
    setState(() {
      _years = years;
      selectedYear = year.toString();
    });
    return years;
  }

  //used to store all events from API
  List<EventData>? allEvents;
  //used to store events for a location
  List<EventData>? eventsForLocation;
  //used to fill the dropdown box
  List<EventsList> eventsList = [];
  List<EventMatches> eventMatches = [];
  List<DropdownMenuItem<String>> eventListDropDown = [];
  //used to store the current selected event
  EventData? selectedEvent;
  LocalEvent? selectedLocalEvent;

  List<TeamsList>? eventTeams;

  @override
  void initState() {
    super.initState();
    //get events from API
    updateYears();
    updateEventsFromAPI(selectedYear);
    //update device name from local db
    getDeviceName();
    setLocalEvent();
    getVersionInfo();
    getTheme();
  }

  void getTheme() async {
    bool darkMode = await mySharedPrefs.readBool("DarkMode");
    setState(() {
      widget.onchangeTheme!(darkMode);
    });
  }

  void getVersionInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      versionName = packageInfo.version;
      versionCode = packageInfo.buildNumber;
    });
  }

  void refreshLocalTeamsCount() async {
    List<LocalTeam> listSelectedLocalTeams = await localDB.listLocalTeams();
    setState(() {
      _countOfTeams =
          listSelectedLocalTeams != null ? listSelectedLocalTeams.length : 0;
    });
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
      //locationDropDown = selectedLocalEvent?.location;
    });
    //print("LocalEvent: " + selectedLocalEvent.key);

    if (eventTeams == null) {
      print("No Teams");
    } else {
      localDB.clearLocalTeams();
      for (TeamsList team in eventTeams!) {
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

    if (selectedEvent!.key != null) {
      await getEventTeamsFromAPI(selectedEvent!.key!);
      await getMatches(selectedEvent!.key!);
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
        _txtDeviceName.text = deviceName.name!;
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

  Future<List<MatchTeam>> getMatches(String eventKey) async {
    //print(await localDB.listEvents());
    //print(await localDB.listScoringData());
    //gets all events from API
    eventMatches = await webAPI.getEventMatches(eventKey);
    if (!kIsWeb) {
      localDB.clearMatchTeams();
    }
    bool recordExists = false;
    List<MatchTeam> listMatchTeams = [];
    for (EventMatches match in eventMatches) {
      //print(match.matchNumber);
      //print(match.eventKey);
      //print(match.alliances?.blue?.teamKeys);
      //print(match.alliances?.red?.teamKeys);
      if (match.alliances?.blue?.teamKeys != null) {
        MatchTeams listBlueTeams = match.alliances?.blue! as MatchTeams;
        for (String? teamKey in listBlueTeams.teamKeys!) {
          recordExists = false;
          MatchTeam newMatchTeam =
              MatchTeam(matchNum: match.matchNumber, teamKey: teamKey);
          for (MatchTeam team in listMatchTeams) {
            if (team.teamKey == newMatchTeam.teamKey) {
              if (team.matchNum == newMatchTeam.matchNum) {
                recordExists = true;
              }
            }
          }
          if (!recordExists) {
            listMatchTeams.add(newMatchTeam);
            if (!kIsWeb) {
              localDB.insertMatchTeam(newMatchTeam);
            }
          }
        }
      }
      if (match.alliances?.red?.teamKeys != null) {
        MatchTeams listRedTeams = match.alliances?.red! as MatchTeams;
        for (String? teamKey in listRedTeams.teamKeys!) {
          recordExists = false;
          MatchTeam newMatchTeam =
              MatchTeam(matchNum: match.matchNumber, teamKey: teamKey);
          for (MatchTeam team in listMatchTeams) {
            if (team.teamKey == newMatchTeam.teamKey) {
              if (team.matchNum == newMatchTeam.matchNum) {
                recordExists = true;
              }
            }
          }
          if (!recordExists) {
            listMatchTeams.add(newMatchTeam);
            localDB.insertMatchTeam(newMatchTeam);
          }
        }
      }
    }
    return listMatchTeams;
  }

  Future<void> getEventTeamsFromAPI(String eventKey) async {
    setState(() {
      _downloadingData = 1;
    });

    //add event to local DB
    LocalEvent event = LocalEvent(
      key: selectedEvent!.key,
      name: selectedEvent!.name,
      shortName: selectedEvent!.shortName,
      location: selectedEvent!.country,
    );
    localDB.insertEvent(event);

    eventTeams = await webAPI.getTeamsByEvent(eventKey);
    print(eventTeams!.length);
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
      for (TeamsList team in eventTeams!) {
        LocalTeam insertTeam = LocalTeam(
            key: team.key,
            name: team.name,
            nickName: team.nickname,
            teamNumber: team.teamNumber.toString());
        //print(insertTeam.teamNumber);
        localDB.insertLocalTeam(insertTeam);
      }
    }
    await getMatches(selectedEvent!.key!);
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
        allEvents?.where((i) => i.country == locationDropDown).toList();
    //clear event list and update it with new events
    eventsList.clear();
    eventsForLocation!.forEach((i) {
      if (i.shortName != null && i.shortName != "") {
        eventsList.add(EventsList(name: i.shortName, key: i.key));
      } else {
        eventsList.add(EventsList(name: i.name, key: i.key));
      }
    });

    if (eventsList.length == 0) {
      txtEventHelpText = "No Events for this location!";
    } else {
      txtEventHelpText = "Please choose a event";
    }
    //update dropdown box with the new events
    for (EventsList event in eventsList) {
      setState(() {
        eventListDropDown.add(new DropdownMenuItem(
            value: event.key,
            child: Text(
              event.name!,
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
        styleFontSize = 13;
      });
    }
    if (width < 393) {
      setState(() {
        styleFontSize = 11;
      });
    }
    if (width >= 600) {
      setState(() {
        styleFontSize = 15;
      });
    }

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title!),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Robot Scouting'),
                  Text('Version: ' + versionName),
                ],
              ),
              decoration:
                  BoxDecoration(color: Theme.of(context).primaryColorDark),
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
              title: Text('Scan QR Code'),
              onTap: () {
                Navigator.pop(context);
                _navigateToQRBarcodeScanner(context);
              },
            ),
            ListTile(
              title: Text('Add Local Team'),
              onTap: () {
                Navigator.pop(context);
                _navigateToAddTeamScreen(context);
              },
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Row(
                children: [
                  Text('Dark Mode'),
                  Switch(
                      value: widget.theme,
                      onChanged: (toggle) {
                        setState(() {
                          widget.onchangeTheme!(toggle);
                        });
                      })
                ],
              ),
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
                  FractionallySizedBox(
                    widthFactor: 0.99,
                    child: Center(
                      child: ConstrainedBox(
                        constraints:
                            BoxConstraints(maxWidth: 900.0, minWidth: 250.0),
                        child: Container(
                          margin: const EdgeInsets.all(10.0),
                          padding: EdgeInsets.all(4.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 0.0),
                                child: Text(
                                  "Current Event",
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                              ),
                              //Text(selectedLocalEvent == null ? "none" : selectedLocalEvent.shortName),
                              Text(selectedLocalEvent == null
                                  ? "none"
                                  : selectedLocalEvent!.name!),
                              Text(selectedLocalEvent == null
                                  ? ""
                                  : selectedLocalEvent!.location!),
                              Text(selectedLocalEvent == null
                                  ? ""
                                  : selectedYear!),

                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 0.0),
                                child: Text("Teams Loaded: " +
                                    _countOfTeams.toString()),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: Text("Set Event",
                              style: Theme.of(context).textTheme.headline6),
                        ),
                      ]),
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
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedYear = newValue!;
                                locationDropDown = null;
                                selectedEvent = null;
                              });
                              updateEventsFromAPI(selectedYear);
                            },
                            items: _years,
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
                            onChanged: (String? newValue) {
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
                            hint: Text(txtEventHelpText),
                            value: selectedEvent == null
                                ? null
                                : selectedEvent!.key,
                            onChanged: (item) {
                              setState(() {
                                selectedEvent = eventsForLocation!.firstWhere(
                                    (loc) => loc.key == item,
                                    orElse: () => eventsForLocation!.first);
                              });
                              print("Key: " + selectedEvent!.key.toString());
                              getEventTeamsFromAPI(selectedEvent!.key!);
                            },
                            items: eventListDropDown,
                          ),
                        ),
                      ]),
                  LoadingImage(
                    state: _downloadingData,
                    text: _downloadingText,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: ElevatedButton(
                      child: Text("Update Event"),
                      onPressed: () {
                        updateDeviceName();
                        if (selectedEvent != null) {
                          mySharedPrefs.saveStr(
                              "currentEvent", selectedEvent!.key!);
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
    var eventShortName = (selectedLocalEvent == null)
        ? "None Selected"
        : selectedLocalEvent!.shortName;
    var eventKey =
        (selectedLocalEvent == null) ? "NA" : selectedLocalEvent!.key;
    final result = await Navigator.push(
      context,
      // Create the SelectionScreen in the next step.
      MaterialPageRoute(
        builder: (context) => ScoringDataScreen(
          eventName: eventShortName,
          eventKey: eventKey,
        ),
      ),
    );
  }

  _navigateToMatchScoutingScreen(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    List<LocalTeam> teams = await localDB.listLocalTeams();
    String eventName = "";
    if (selectedLocalEvent!.shortName != null &&
        selectedLocalEvent!.shortName != "") {
      eventName = selectedLocalEvent!.shortName!;
    } else {
      eventName = selectedLocalEvent!.name!;
    }
    final result = await Navigator.push(
      context,
      // Create the SelectionScreen in the next step.
      MaterialPageRoute(
          builder: (context) => MatchScoutingScreen(
                eventName: eventName,
                eventKey: selectedLocalEvent!.key,
                eventTeams: teams,
                deviceName: _txtDeviceName.text,
                styleFontSize: this.styleFontSize,
              )),
    );
  }

  _navigateToPitScoutingScreen(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    List<LocalTeam> teams = await localDB.listLocalTeams();
    String eventName = "";
    if (selectedLocalEvent!.shortName != null &&
        selectedLocalEvent!.shortName != "") {
      eventName = selectedLocalEvent!.shortName!;
    } else {
      eventName = selectedLocalEvent!.name!;
    }
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => PitScoutingScreen(
                eventName: eventName,
                eventKey: selectedLocalEvent!.key,
                eventTeams: teams,
                camera: widget.camera,
                deviceName: _txtDeviceName.text,
                styleFontSize: this.styleFontSize,
              )),
    );
  }

  _navigateToQRBarcodeScanner(BuildContext context) async {
    await Navigator.push(
      context,
      // Create the SelectionScreen in the next step.
      MaterialPageRoute(builder: (context) => QRBarcodeScanner()),
    );
  }

  _navigateToAddTeamScreen(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    //List<LocalTeam> teams = await localDB.listLocalTeams();
    final result = await Navigator.push(
      context,
      // Create the SelectionScreen in the next step.
      MaterialPageRoute(builder: (context) => AddTeam()),
    );
    refreshLocalTeamsCount();
  }
}

class EventsList {
  final String? key;
  final String? name;

  EventsList({this.key, this.name});
}
