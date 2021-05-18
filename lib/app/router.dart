import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shopend/app/app_state.dart';
import 'package:shopend/app/locator.dart';
import 'package:shopend/app/ui/pages/_pages.dart';
import 'package:shopend/app/ui/pages/post/post_lista_page.dart';

class Navigation {
  static final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

  static void page(String path, BuildContext ctx,
      {List<dynamic> params, VoidCallback onPressBefore, VoidCallback onPressAfter,bool pushReplacement=false}) async {

   if (path.startsWith("/config/")) {
      switch (path) {
        case "/config/":
          //_navigateTo(ctx, (ctx) => ConfigurationPage(), onPressBefore: onPressBefore, onPressAfter: onPressAfter);
          break;
      }
    } else if (path.startsWith("/posts/")) {
     switch (path) {
       case "/posts/lista":
       _navigateTo(ctx, (ctx) => PostListaPage(), onPressBefore: onPressBefore, onPressAfter: onPressAfter);
         break;

       case "/posts/detalle":
         _navigateTo(ctx, (ctx) => PostDetail(model: params[0]),
             onPressBefore: onPressBefore, onPressAfter: onPressAfter);
         break;
     }
   } else if (path.startsWith("/profile/")) {
      switch (path) {
        case "/profile/":
          // _navigateTo(ctx, (ctx) => UserProfilePage(), onPressBefore: onPressBefore, onPressAfter: onPressAfter);
          break;
        case "/profile/about":
          // _navigateTo(ctx, (ctx) => AboutPage(), onPressBefore: onPressBefore, onPressAfter: onPressAfter);
          break;
        case "/profile/bankinfo":
          // _navigateTo(ctx, (ctx) => UserProfileBankinfoPage(), onPressBefore: onPressBefore, onPressAfter: onPressAfter);
          break;
        case "/profile/changepass":
          // _navigateTo(ctx, (ctx) => UserChangePassPage(), onPressBefore: onPressBefore, onPressAfter: onPressAfter);
          break;
      }
    } if (path.startsWith("/error/")) {
      switch (path) {
        case "/error/no-internet":
          _navigateTo(ctx, (ctx) => NoInternetPage());
          break;
        case "/error/rqt-timeout":
          _navigateTo(ctx,(ctx) => RequetTimeoutErrorPage());
          break;
        case "/error/rqt-error":
          _navigateTo(ctx,(ctx) => RequetErrorPage(msg: params[0] ?? ""));
          break;
      }
    } else {
      switch (path) {
        case "/login/full":
          //_navigateTo(ctx, (ctx) => LoginPage(authRepository: locator<AuthRepository>()),replace: true);
          break;
        case "/login/onlypass":
          //_navigateTo(ctx,(ctx) => LoginPageOnlyPass(),replace: true);
          break;
      }
    }
  }

  static Future<bool> checkConnectivity(BuildContext ctx) async {
    var appState = locator<AppState>();

    bool result = true;
    bool retry = true;
    int countRetry = 3;

    BuildContext context = ctx ?? navigatorKey.currentContext;

    while (retry && countRetry <= 3) {
      if (!appState.HasInternetConnection) {
        var navResult = await Navigator.of(context).push<int>(
          MaterialPageRoute(
            builder: (ctx) => NoInternetPage(),
          ),
        );
        if (navResult == null) {
          //sin reintento
          retry = false;
          result = false;
        } else if (navResult == 2) {
          //Hay conexion a internet
          retry = false;
          result = true;
        }
      } else {
        //hay conexion a internet
        retry = false;
        result = true;
      }
      countRetry += 1;
    }

    return result;
  }

  static Future<int> pageError(String path, BuildContext ctx,{List<dynamic> params}) async {
    int result=0;

    if (path.startsWith("/error/")) {
      switch (path) {
        case "/error/no-internet":
          result = await _navigateToResponse(ctx, (ctx) => NoInternetPage());
          break;
        case "/error/rqt-timeout":
          result = await _navigateToResponse(ctx, (ctx) => RequetTimeoutErrorPage());
          break;
        case "/error/rqt-error":
          result = await _navigateToResponse(ctx, (ctx) => RequetErrorPage(msg: params.length>=1 ? params[0] : ""));
          break;
      }
    }

    return result;
  }

  static Future<int> _navigateToResponse(BuildContext ctx, WidgetBuilder fnc,
      {VoidCallback onPressBefore, VoidCallback onPressAfter}) async {
    if (onPressBefore != null) {
      onPressBefore();
    }

    int result=null;

    if (ctx != null) {
      result = await Navigator.of(ctx).push(
        MaterialPageRoute(
          builder: fnc,
        ),
      );
    } else {
      result = await navigatorKey.currentState.push(MaterialPageRoute(
        builder: fnc,
      ));
    }

    if (onPressAfter != null) {
      onPressAfter();
    }

    return result;
  }

  static void _navigateTo(BuildContext ctx, WidgetBuilder fnc,
      {VoidCallback onPressBefore, VoidCallback onPressAfter, bool replace=false}) {
    if (onPressBefore != null) {
      onPressBefore();
    }

    var route =  MaterialPageRoute(
      builder: fnc,
      settings: RouteSettings(name: 'page') //todo: cambiar esto al nombre de la pagina (FirebaseAnalytics)
    );

    if (ctx != null) {
      if (!replace)
         Navigator.of(ctx).push(route);
      else
        Navigator.of(ctx).pushReplacement(route);

    } else {
      if (!replace)
        navigatorKey.currentState.push(route);
      else
        navigatorKey.currentState.pushReplacement(route);
    }

    if (onPressAfter != null) {
      onPressAfter();
    }
  }
}
