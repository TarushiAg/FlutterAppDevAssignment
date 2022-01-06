import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:convert';
import 'package:synchronized/synchronized.dart';

class PreferenceUtils {
  static PreferenceUtils _singleton;
  static SharedPreferences _prefs;
  static Lock _lock = Lock();

  static String KEY_CUSTOMER_USERNAME = "KEY_CUSTOMER_USERNAME";
  static String KEY_CUSTOMER_PASSWORD = "KEY_CUSTOMER_PASSWORD";

  static Future<PreferenceUtils> getInstance() async {
    if (_singleton == null) {
      await _lock.synchronized(() async {
        if (_singleton == null) {
          // keep local instance till it is fully initialized.
          var singleton = PreferenceUtils._();
          await singleton._init();
          _singleton = singleton;
        }
      });
    }
    return _singleton;
  }

  PreferenceUtils._();
  Future _init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // get string
  static String getString(String key, {String defValue = ''}) {
    if (_prefs == null) return defValue;
    return _prefs.getString(key) ?? defValue;
  }

  // put string
  static Future<bool> putString(String key, String value) {
    if (_prefs == null) return null;
    return _prefs.setString(key, value);
  }

  // get keys
  static Set<String> getKeys() {
    if (_prefs == null) return null;
    return _prefs.getKeys();
  }

  // remove
  static Future<bool> remove(String key) {
    if (_prefs == null) return null;
    return _prefs.remove(key);
  }

  // clear
  static Future<bool> clear() {
    if (_prefs == null) return null;
    return _prefs.clear();
  }

  //Sp is initialized
  static bool isInitialized() {
    return _prefs != null;
  }
}
