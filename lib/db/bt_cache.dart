import 'package:shared_preferences/shared_preferences.dart';

class BtCache {
  SharedPreferences? prefs;
  static BtCache? _instance;

  BtCache._() {
    init();
  }

  BtCache._pre(this.prefs);

  void init() async {
    prefs ??= await SharedPreferences.getInstance();
  }

  //预初始化，防止在使用get时，prefs还未完成初始化
  static Future<BtCache> preInit() async {
    if (_instance == null) {
      var prefs = await SharedPreferences.getInstance();
      _instance = BtCache._pre(prefs);
    }
    return _instance!;
  }

  static BtCache getInstance() {
    _instance ??= BtCache._();
    return _instance!;
  }

  setString(String key, String value) {
    prefs?.setString(key, value);
  }

  setDouble(String key, double value) {
    prefs?.setDouble(key, value);
  }

  setInt(String key, int value) {
    prefs?.setInt(key, value);
  }

  setStringList(String key, List<String> value) {
    prefs?.setStringList(key, value);
  }

  T? get<T>(String key) {
    var result = prefs?.get(key);
    if (result != null) {
      return result as T;
    }
    return null;
  }

  void remove(String key) {
    prefs?.remove(key);
  }
}
