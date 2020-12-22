import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class MySharedPrefs {

  Future<String> readStr(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(key) ?? "";
    print('read: $key Value: $value');
    return value;
  }

  Future<int> readInt(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getInt(key) ?? 0;
    print('read: $key Value: $value');
    return value;
  }

  Future<bool> readBool(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getBool(key) ?? false;
    print('read: $key Value: $value');
    return value;
  }

  saveStr(String key, String data) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, data);
    print('saved: $key Value: $data');
  }

  saveInt(String key, int data) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(key, data);
    print('saved: $key Value: $data');
  }

  saveBool(String key, bool data) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, data);
    print('saved: $key Value: $data');
  }

}