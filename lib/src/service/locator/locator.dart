import 'package:get_it/get_it.dart';
import 'package:t_society/src/data/local/app_preference.dart';
import 'package:t_society/src/service/dio/dio_client.dart';
import 'package:t_society/src/service/locator/repository.dart';

final sl = GetIt.instance;

Future<void> initLocator() async {

  //future initialization
  //AppPreference
  AppPreference instance = await AppPreference.init();
  sl.registerSingleton<AppPreference>(instance);

  //Network Client
  sl.registerLazySingleton(() => DioClient(sl()));
  //register all repository
  registerRepository();



}
