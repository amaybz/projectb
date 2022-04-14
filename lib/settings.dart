import 'package:flutter/material.dart';
import 'package:projectb/sharedprefs.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  MySharedPrefs mySharedPrefs = new MySharedPrefs();
  bool metricSystem = false;

  @override
  void initState() {
    super.initState();
    getMetricSystemValue();
  }

  getMetricSystemValue() async {
    metricSystem = await mySharedPrefs.readBool("metricSystem");
    setState(() {
      metricSystem = metricSystem;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
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
          ]),
        ),
      ]),
    );
  }
}
