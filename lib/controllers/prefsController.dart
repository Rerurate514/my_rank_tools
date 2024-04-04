import 'dart:ffi';

import 'package:shared_preferences/shared_preferences.dart';

class PrefsController{
  void setValue(String key, int value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(key, value);
  }

  Future<int?> getValue(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key);
  }
}