
import 'package:get_it/get_it.dart';
import 'SharedPreferenceService.dart';
import 'StorageService.dart';

GetIt locator = GetIt.instance;

setupServiceLocator() {
  //locator.registerLazySingleton<StorageService>(() => StorageServiceFake());
  locator.registerSingleton<StorageService>(SharedPreferenceService());
}