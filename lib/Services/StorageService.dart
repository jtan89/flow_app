abstract class StorageService {
  Future<double> getDoubleValue(String key);
  Future<void> setDoubleValue(String key, double value);
}