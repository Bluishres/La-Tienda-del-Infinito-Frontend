import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shopend/app/data/repository/post/MockPostRepository.dart';
import 'package:shopend/app/data/repository/post/PostRepository.dart';
import 'package:shopend/app/data/repository/post/ProdPostRepository.dart';

import 'common/event_manager.dart';
import 'config.dart';
import 'data/provider/ConectivityProvider.dart';
import 'data/repository/_repositorys.dart';

final locator = GetIt.instance;

@injectableInit
void setupLocator(Env env,AppConfig config) async {

  //Configuracion es la misma para cualquier flavor
  locator.registerSingleton<AppConfig>(config);

  locator.registerLazySingleton<EventManager>(() => EventManager.create());
  locator.registerLazySingleton<ConnectivityService>(() => ConnectivityService());

  if (env is MockEnv) {
    locator.registerLazySingleton<AuthRepository>(() => MockAuthRepository());
    locator.registerLazySingleton<PostRepository>(() => MockPostRepository());

  } else if (env is DevEnv) {
    locator.registerLazySingleton<AuthRepository>(() => ServerAuthRepository());
    locator.registerLazySingleton<PostRepository>(() => ProdPostRepository());

  } else if (env is ProdEnv) {
    locator.registerLazySingleton<AuthRepository>(() => ServerAuthRepository());
    locator.registerLazySingleton<PostRepository>(() => ProdPostRepository());
  }
}

abstract class Env {

  Env(){}

  factory Env.fromFlavour(String flavour) {
    if (flavour.toUpperCase()=="PROD")
      return ProdEnv();

    if (flavour.toUpperCase()=="DEV")
      return DevEnv();

    if (flavour.toUpperCase()=="MOCK")
      return MockEnv();

    throw new Exception("Flavour not recognized");
  }
}

class DevEnv extends Env {
}

class MockEnv extends Env {}

class ProdEnv extends Env {}
