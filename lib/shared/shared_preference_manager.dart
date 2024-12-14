import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager {
  static SharedPreferencesManager? _instance;
  static late SharedPreferences? _preferences;

  static Future<SharedPreferencesManager> getInstance() async {
    if (_instance == null) {
      _instance = SharedPreferencesManager();
      await _instance!._init();
    }
    return _instance!;
  }

  Future<void> _init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  // Save data to SharedPreferences
  Future<void> saveData(String key, dynamic value) async {
    if (value is String ||
        value is int ||
        value is double ||
        value is bool ||
        value is List) {
      // Save simple types directly
      await _preferences!.setString(key, value.toString());
    } else {
      // Serialize complex types to JSON
      await _preferences!.setString(key, json.encode(value));
    }
  }

  // Retrieve data from SharedPreferences
  dynamic getData(String key) {
    final String? jsonString = _preferences!.getString(key);
    if (jsonString != null) {
      try {
        // Try to parse JSON
        return json.decode(jsonString);
      } catch (e) {
        // If parsing fails, return the string as is
        return jsonString;
      }
    }
    // Return null if data not found
    return null;
  }

  // Clear data for a specific key from SharedPreferences
  Future<void> clear(String key) async {
    await _preferences!.remove(key);
  }

  // Clear all data from SharedPreferences
  Future<void> clearAll() async {
    await _preferences!.clear();
  }
}
