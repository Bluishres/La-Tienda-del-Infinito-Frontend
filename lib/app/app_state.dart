import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopend/app/data/provider/ConectivityProvider.dart';

import 'common/logger.dart';
import 'config.dart';
import 'domain/model/_models.dart';
import 'locator.dart';

class AppState {
  static const String appstateKey = 'appstate';
  static const String keyUserLogged = 'userlogged';

  Usuario _user;

  SharedPreferences _sp;
  bool _initializedApp = false;

  //Propertys-states
  ConnectivityStatus _connectivityStatus = ConnectivityStatus.Offline;

  AppState._() {
    locator<ConnectivityService>().subscribe().listen((result) {
      _connectivityStatus = result;
      logger.d("ConnectivityStatus: ${result}");
    });
  }

  //static like-constructor allow async
  static Future<AppState> load() async {
    AppState st = new AppState._();

    logger.i("AppState.loadBasic ----- init");

    //Load Usuario
    try {
      var data = AppState.loadObject(keyUserLogged);
      if (data != null)
        st._user = Usuario.fromJson(data);
      else
        st._user = null;
    } catch (ex) {
      logger.e(ex);
    }
    logger.i("AppState. User-logged ${st._user != null ? st._user.toString() : 'no-saved. return null'}");

    logger.v("AppState.loadBasic ----- end");

    return st;
  }

  void finishLoadState() async {
    logger.i("AppState.finishloadState ----- init");

    // if (_user != null) {
    //   //load notificaciones from BD ==> La BD dependen del usuario, sin usuario no se puede cargar.
    //   _ntfcState = await NotificationsState.load();
    // } else {
    //   _ntfcState = await NotificationsState.loadNoBD();
    // }

    logger.i("AppState.finishloadState ----- end");
  }

  void executeActionsAfterLogin() {}

  //Indica que la app está inicializada completamente.
  void setInitializedApp() {
    _initializedApp = true;
  }

  //PROPERTYS-GET SIMPLES
  bool get HasInternetConnection => !(_connectivityStatus == ConnectivityStatus.Offline);

  ConnectivityStatus get ConnectivityState => _connectivityStatus;

  //PROPERTYES OBJETS
  Usuario get user => _user;

  bool get hasUser => _user != null;
  bool get isAppInitialized => _initializedApp;

  void AssignLoggedUser(Usuario user) {
    assert(user != null);
    _user = user;
    AppState.saveObject(keyUserLogged, user);
  }

  ///Borra las preferencias del usuario, y la variable de estado
  void ResetUser() {
    _user = null;
    AppState.clearKey(keyUserLogged);

    //Tambien necesito borrar todas las notificaciones, estas son para el usuario que está logado
  }

  static String generateKey(String key) {
    return '${PreferencesConfig.appkey}_${key}_key';
  }

  static dynamic loadObject(String objectKey, {dynamic defaultObject = null}) {
    var sp = locator<SharedPreferences>();
    String key = generateKey(objectKey);

    try {
      if (!sp.containsKey(key)) return defaultObject;

      String dataJson = sp.getString(key);
      if (dataJson.isEmpty) return defaultObject;

      return jsonDecode(dataJson);
    } catch (ex) {
      logger.e("Error AppState.loadObject", ex);
      clearKey(key);
      return null;
    }
  }

  static List<dynamic> loadObjectList(String objectKey, {List<dynamic> defaultList = null}) {
    var sp = locator<SharedPreferences>();

    try {
      String key = generateKey(objectKey);
      if (!sp.containsKey(key)) return defaultList;

      List<String> listDataJson = sp.getStringList(key);
      if (listDataJson.isEmpty) return defaultList;

      return listDataJson.map((obj) => jsonDecode(obj)).toList();
    } catch (ex) {
      logger.e("Error AppState.loadObjectList", ex);
      return null;
    }
  }

  static void saveObject(String objectKey, dynamic object) {
    var sp = locator<SharedPreferences>();

    try {
      sp.setString(generateKey(objectKey), jsonEncode(object));
    } catch (ex) {
      logger.e("Error AppState.saveObject. key=$objectKey", ex);
      return null;
    }
  }

  static void clearKey(String objectKey) {
    var sp = locator<SharedPreferences>();

    String key = generateKey(objectKey);
    try {
      if (sp.containsKey(key)) sp.setString(key, "");
    } catch (ex) {
      logger.e("Error AppState.clearKey. key=$objectKey", ex);
      return null;
    }
  }

  static void saveObjectList(String objectKey, List<dynamic> objectList) {
    var sp = locator<SharedPreferences>();

    try {
      List<String> serialized = objectList.map((obj) => jsonEncode(obj)).toList();
      sp.setStringList(generateKey(objectKey), serialized);
    } catch (ex) {
      logger.e("Error AppState.saveObject. key=$objectKey", ex);
      return null;
    }
  }
}
