import 'package:flutter/material.dart';
import 'package:projectb/main.dart';
import 'package:projectb/sharedprefs.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({
    Key? key,
    required this.darkMode,
  }) : super(key: key);

  final Function(bool) darkMode;

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  MySharedPrefs mySharedPrefs = new MySharedPrefs();
  bool metricSystem = false;
  bool darkMode = false;

  @override
  void initState() {
    super.initState();
    getMetricSystemValue();
    getDarkModeValue();
  }

  getMetricSystemValue() async {
    metricSystem = await mySharedPrefs.readBool("metricSystem");
    setState(() {
      metricSystem = metricSystem;
    });
  }

  getDarkModeValue() async {
    darkMode = await mySharedPrefs.readBool("DarkMode");
    setState(() {
      darkMode = darkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          foregroundColor: Theme.of(context).splashColor,
          backgroundColor: Theme.of(context).primaryColor,
          title: Text('Settings')),
      body: ListView(reverse: false, shrinkWrap: true, children: <Widget>[
        FractionallySizedBox(
          widthFactor: 0.95,
          child: Column(children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Metric System?:",
                  style: TextStyle(fontSize: 14),
                ),
                Switch(
                  value: metricSystem,
                  onChanged: (bool value) {
                    setState(() {
                      metricSystem = value;
                      mySharedPrefs.saveBool("metricSystem", value);
                    });
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Dark Mode?:",
                  style: TextStyle(fontSize: 14),
                ),
                Switch(
                  value: darkMode,
                  onChanged: (bool value) {
                    widget.darkMode(value);
                    setState(() {
                      darkMode = value;
                      mySharedPrefs.saveBool("DarkMode", value);
                    });
                  },
                ),
              ],
            ),
          ]),
        ),
      ]),
    );
  }
}
