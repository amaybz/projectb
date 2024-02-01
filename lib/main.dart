import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:projectb/class/eventmatches.dart';
import 'package:projectb/localdb.dart';
import 'package:projectb/pit/pitscouting.dart';
import 'dart:async';
import 'package:projectb/scoringdata.dart';
import 'package:projectb/matchscouting/matchscouting.dart';
import 'package:projectb/settings.dart';
import 'package:projectb/sharedprefs.dart';
import 'package:projectb/webapi.dart';
import 'package:projectb/widgets/widget_headingmain.dart';
import 'package:projectb/widgets/widget_loading.dart';
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
    print("no cameras" + e.toString());
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
    primaryColor: Color(0xFF6200EE),
    splashColor: Colors.white,
    primaryColorDark: Color(0xFF47247A),
    textTheme: ThemeData.dark().textTheme.copyWith(
          titleLarge:
              TextStyle(color: Color(0xFFFFFFFF), fontWeight: FontWeight.bold),
          titleMedium:
              TextStyle(color: Color(0xFFFFFFFF), fontWeight: FontWeight.bold),
          titleSmall:
              TextStyle(color: Color(0xFFFFFFFF), fontWeight: FontWeight.bold),
          labelMedium: TextStyle(
            fontSize: 16,
            color: Color(0xFFFFFFFF),
            fontWeight: FontWeight.bold,
          ),
        ),
  );

  ThemeData _lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Color(0xFF234E70),
    splashColor: Color(0xFFFBF8BE),
    textTheme: ThemeData.light().textTheme.copyWith(
          titleLarge:
              TextStyle(color: Color(0xFFFBF8BE), fontWeight: FontWeight.bold),
          titleMedium:
              TextStyle(color: Color(0xFFFBF8BE), fontWeight: FontWeight.bold),
          titleSmall:
              TextStyle(color: Color(0xFFFBF8BE), fontWeight: FontWeight.bold),
          labelMedium: TextStyle(
            fontSize: 16,
            color: Color(0xFFFBF8BE),
            fontWeight: FontWeight.bold,
          ),
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
  TextStyle? styleTitleText = ThemeData().textTheme.titleLarge;
  TextStyle? styleMenuText = ThemeData().textTheme.bodyLarge;
  TextStyle? styleBodyTextTheme = ThemeData().textTheme.bodyMedium;
  TextStyle? styleTitleTextTheme = ThemeData().textTheme.bodyMedium;

  String versionName = "";
  String versionCode = "";
  String measurements = "kg";

  TextEditingController _txtDeviceName = TextEditingController();
  static int _downloadingData = 0;
  static int _countOfTeams = 0;
  String _downloadingText = "Please select Location and Event to download data";
  String txtEventHelpText = "Please choose a event";
  String? locationDropDown;
  String selectedYear = "setme";
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

  List<DropdownMenuItem<String>> updateYears(TextStyle textStyle) {
    DateTime now = DateTime.now();
    int year = now.year;
    List<DropdownMenuItem<String>> years = [];
    years.clear();
    years.add(DropdownMenuItem(
        child: new Text(
          (year - 2).toString(),
          style: textStyle,
        ),
        value: (year - 2).toString()));
    years.add(DropdownMenuItem(
        child: new Text(
          (year - 1).toString(),
          style: textStyle,
        ),
        value: (year - 1).toString()));
    years.add(DropdownMenuItem(
        child: new Text(
          year.toString(),
          style: textStyle,
        ),
        value: year.toString()));
    years.add(DropdownMenuItem(
        child: new Text(
          (year + 1).toString(),
          style: textStyle,
        ),
        value: (year + 1).toString()));
    setState(() {
      _years = years;
      if (selectedYear == "setme") selectedYear = year.toString();
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
    updateYears(styleBodyTextTheme!);
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
      _countOfTeams = listSelectedLocalTeams.length;
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
      _countOfTeams = listSelectedLocalTeams.length;
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
            teamNumber: team.teamNumber);
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

    setState(() {
      _txtDeviceName.text = deviceName.name!;
    });
  }

  Future<void> updateEventsFromAPI(String year) async {
    //print(await localDB.listEvents());
    //print(await localDB.listScoringData());
    //gets all events from API
    allEvents = await webAPI.getEventsByYear(year);
    allEvents?.sort((a, b) {
      return a.shortName.toString().compareTo(b.locationName.toString());
    });
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
          MatchTeam newMatchTeam = MatchTeam(
              matchNum: match.matchNumber, teamKey: teamKey, alliance: 2);
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
          MatchTeam newMatchTeam = MatchTeam(
              matchNum: match.matchNumber, teamKey: teamKey, alliance: 1);
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
            teamNumber: team.teamNumber);
        //print(insertTeam.teamNumber);
        localDB.insertLocalTeam(insertTeam);
      }
    }
    await getMatches(selectedEvent!.key!);
  }

  setEventItems(TextStyle textStyle) async {
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
      eventsList.sort((a, b) {
        return a.name.toString().compareTo(b.name.toString());
      });
    }
    //update dropdown box with the new events
    for (EventsList event in eventsList) {
      setState(() {
        eventListDropDown.add(new DropdownMenuItem(
            value: event.key,
            child: Text(
              event.name!,
              style: textStyle,
            )));
      });
    }
  }

  updateEventItemsTheme(TextStyle textStyle) async {
    eventListDropDown.clear();
    for (EventsList event in eventsList) {
      setState(() {
        eventListDropDown.add(new DropdownMenuItem(
            value: event.key,
            child: Text(
              event.name!,
              style: textStyle,
            )));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    print("Screen Size: " + width.toString());

    if (width < 500) {
      setState(() {
        styleFontSize = 13;
        styleTitleText = Theme.of(context).textTheme.bodyMedium;
        styleMenuText = Theme.of(context).textTheme.bodyMedium;
        styleBodyTextTheme = Theme.of(context).textTheme.bodyMedium;
        styleTitleTextTheme = Theme.of(context).textTheme.titleMedium;
      });
    }
    if (width < 393) {
      setState(() {
        styleFontSize = 11;
        styleTitleText = Theme.of(context).textTheme.bodySmall;
        styleMenuText = Theme.of(context).textTheme.bodySmall;
        styleBodyTextTheme = Theme.of(context).textTheme.bodySmall;
        styleTitleTextTheme = Theme.of(context).textTheme.titleSmall;
      });
    }
    if (width >= 600) {
      setState(() {
        styleFontSize = 15;
        styleBodyTextTheme = Theme.of(context).textTheme.bodyLarge;
        styleTitleTextTheme = Theme.of(context).textTheme.titleLarge;
        styleTitleText = Theme.of(context).textTheme.bodyLarge;
        styleMenuText = Theme.of(context).textTheme.bodyLarge;
      });
    }
    updateYears(styleBodyTextTheme!);
    updateEventItemsTheme(styleBodyTextTheme!);

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        foregroundColor: Theme.of(context).splashColor,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          widget.title!,
          //style: Theme.of(context).textTheme.titleLarge,
          style: styleTitleTextTheme,
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Robot Scouting',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  Text(
                    'Version: ' + versionName,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ],
              ),
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            ),
            ListTile(
              title: Text(
                'Pit Scouting',
                style: styleMenuText,
              ),
              onTap: () {
                Navigator.pop(context);
                if (selectedLocalEvent != null) {
                  _navigateToPitScoutingScreen(context);
                }
              },
            ),
            ListTile(
              title: Text(
                'Match Scouting',
                style: styleMenuText,
              ),
              onTap: () {
                Navigator.pop(context);
                if (selectedLocalEvent != null) {
                  _navigateToMatchScoutingScreen(context);
                }
              },
            ),
            ListTile(
              title: Text(
                'Saved Records',
                style: styleMenuText,
              ),
              onTap: () {
                Navigator.pop(context);
                _navigateToStoredData(context);
              },
            ),
            ListTile(
              title: Text(
                'Scan QR Code',
                style: styleMenuText,
              ),
              onTap: () {
                Navigator.pop(context);
                _navigateToQRBarcodeScanner(context);
              },
            ),
            ListTile(
              title: Text(
                'Add Local Team',
                style: styleMenuText,
              ),
              onTap: () {
                Navigator.pop(context);
                _navigateToAddTeamScreen(context);
              },
            ),
            ListTile(
              title: Text(
                'Settings',
                style: styleMenuText,
              ),
              onTap: () {
                Navigator.pop(context);
                _navigateToSettings(context);
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
                                child: HeadingMain(
                                  headingText: "Current Event",
                                  styleFontSize: styleTitleTextTheme!.fontSize!,
                                  textColor: styleTitleTextTheme!.color!,
                                  backGroundColor:
                                      Theme.of(context).primaryColor,
                                ),
                              ),
                              //Text(selectedLocalEvent == null ? "none" : selectedLocalEvent.shortName),
                              Text(
                                selectedLocalEvent == null
                                    ? "none"
                                    : selectedLocalEvent!.name!,
                                style: styleBodyTextTheme,
                              ),
                              Text(
                                selectedLocalEvent == null
                                    ? ""
                                    : selectedLocalEvent!.location!,
                                style: styleBodyTextTheme,
                              ),
                              Text(
                                selectedLocalEvent == null ? "" : selectedYear,
                                style: styleBodyTextTheme,
                              ),

                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 0.0),
                                child: Text(
                                  "Teams Loaded: " + _countOfTeams.toString(),
                                  style: styleBodyTextTheme,
                                ),
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
                          margin: const EdgeInsets.symmetric(vertical: 20.0),
                          child: HeadingMain(
                            headingText: "Set New Event",
                            styleFontSize: styleTitleTextTheme!.fontSize!,
                            textColor: styleTitleTextTheme!.color!,
                            backGroundColor: Theme.of(context).primaryColor,
                          ),
                        ),
                      ]),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          width: 100,
                          child: Text(
                            "Device Name: ",
                            style: styleBodyTextTheme,
                          ),
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
                            hint: Text('Please select Year',
                                style: styleBodyTextTheme),
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
                            hint: Text('Please choose a location',
                                style: styleBodyTextTheme),
                            value: locationDropDown,
                            onChanged: (String? newValue) {
                              setState(() {
                                locationDropDown = newValue;
                              });
                              setEventItems(styleBodyTextTheme!);
                            },
                            items: _locations.map((location) {
                              return DropdownMenuItem(
                                child: new Text(location,
                                    style: styleBodyTextTheme),
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
                            hint: Text(txtEventHelpText,
                                style: styleBodyTextTheme),
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
    await Navigator.push(
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
    await Navigator.push(
      context,
      // Create the SelectionScreen in the next step.
      MaterialPageRoute(
          builder: (context) => MatchScoutingScreen(
              eventName: eventName,
              eventKey: selectedLocalEvent!.key,
              eventTeams: teams,
              deviceName: _txtDeviceName.text,
              styleFontSize: this.styleFontSize,
              darkMode: (state) {
                widget.onchangeTheme!(state);
              })),
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
    await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => PitScoutingScreen(
                eventName: eventName,
                eventKey: selectedLocalEvent!.key,
                eventTeams: teams,
                camera: widget.camera,
                deviceName: _txtDeviceName.text,
                styleFontSize: this.styleFontSize,
                darkMode: (value) {
                  widget.onchangeTheme!(value);
                },
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

  _navigateToSettings(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    await Navigator.push(
      context,
      // Create the SelectionScreen in the next step.
      MaterialPageRoute(
        builder: (context) => SettingsScreen(
          darkMode: (value) {
            widget.onchangeTheme!(value);
          },
        ),
      ),
    );
  }

  _navigateToAddTeamScreen(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    //List<LocalTeam> teams = await localDB.listLocalTeams();
    await Navigator.push(
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
