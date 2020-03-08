
import 'package:shared_preferences/shared_preferences.dart';
import 'StorageService.dart';


class SharedPreferenceService extends StorageService {
 
  @override
  Future<double> getDoubleValue(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final prefValue = prefs.getDouble(key);
    if (prefValue == null) {
      return 0.0;
    }
    return prefValue;
  }

  @override
  Future<void> setDoubleValue(String key, double value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(key, value);
  }

}
