// @dart=2.9
import 'dart:async';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shopend/app/router.dart';

import '../../app_state.dart';
import '../../locator.dart';

class ManageDioErrorInterceptor extends Interceptor {
  final Dio dio;

  AppState _appState;

  ManageDioErrorInterceptor({@required this.dio});

  @override
  Future onError(DioError err) async {
    if (_appState == null) _appState = locator<AppState>();

    if (_shouldRetry(err)) {
      if (!_appState.HasInternetConnection) {
        //No hay internet
        if (await Navigation.checkConnectivity(null)) {
          //hay internet de nuevo
          try {
            return await executeRequest(err.request);
          } catch (ex, s) {
            //Crashlytics.instance.recordError(ex, s);
            return ex;
          }
        }
      } else if (err.type == DioErrorType.CONNECT_TIMEOUT) {
        //Hay conextion a internet
        int resp = await Navigation.pageError("/error/rqt-timeout", null);
        if (resp == -1) {
          //reintento
          //hay internet de nuevo
          try {
            return await executeRequest(err.request);
          } catch (ex, s) {
            //Crashlytics.instance.recordError(ex, s);
            return ex;
          }
        }
      }
    }

    // Let the error "pass through" if it's not the error we're looking for
    return err;
  }

  bool _shouldRetry(DioError err) {
    if (err.type == DioErrorType.DEFAULT ||
        err.type == DioErrorType.CONNECT_TIMEOUT) return true;

    if (err.error != null) {
      if (err.error is SocketException) return true;
    }

    return false;
  }

  Future<Response> executeRequest(RequestOptions requestOptions) async {
    return await dio.request(
      requestOptions.path,
      cancelToken: requestOptions.cancelToken,
      data: requestOptions.data,
      onReceiveProgress: requestOptions.onReceiveProgress,
      onSendProgress: requestOptions.onSendProgress,
      queryParameters: requestOptions.queryParameters,
      options: requestOptions,
    );
  }
}

class DioConnectivityRequestRetrier {
  final Dio dio;
  final Connectivity connectivity;

  DioConnectivityRequestRetrier({
    @required this.dio,
    @required this.connectivity,
  });

  Future<Response> scheduleRequestRetry(RequestOptions requestOptions) async {
    StreamSubscription streamSubscription;
    final responseCompleter = Completer<Response>();

    streamSubscription = connectivity.onConnectivityChanged.listen(
      (connectivityResult) async {
        if (connectivityResult != ConnectivityResult.none) {
          streamSubscription.cancel();
          // Complete the completer instead of returning
          responseCompleter.complete(
            dio.request(
              requestOptions.path,
              cancelToken: requestOptions.cancelToken,
              data: requestOptions.data,
              onReceiveProgress: requestOptions.onReceiveProgress,
              onSendProgress: requestOptions.onSendProgress,
              queryParameters: requestOptions.queryParameters,
              options: requestOptions,
            ),
          );
        }
      },
    );

    return responseCompleter.future;
  }
}

class DioErrorRequestRetrier {
  final Dio dio;

  DioErrorRequestRetrier({@required this.dio});

  Future<Response> executeRequest(RequestOptions requestOptions) async {
    return await dio.request(
      requestOptions.path,
      cancelToken: requestOptions.cancelToken,
      data: requestOptions.data,
      onReceiveProgress: requestOptions.onReceiveProgress,
      onSendProgress: requestOptions.onSendProgress,
      queryParameters: requestOptions.queryParameters,
      options: requestOptions,
    );
  }
}

class DioPrettyErrors {
  static String parseError(DioError err) {
    if (err.type == DioErrorType.CONNECT_TIMEOUT) {
      return "Tiempo de espera superado";
    }

    if (err != null && err.response != null) {
      return '${err.response.statusCode} - ${err.response.statusMessage}\n${err.response}';
    }

    return "Algo fue mal";
  }
}
