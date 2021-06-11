// @dart=2.9
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class AppConfig {
  final String flavor;
  final String baseUrlAuth;
  final String baseUrlResource;
  final String appTitle;
  final int timeout;

  AppConfig._({
    this.flavor = "dev",
    @required this.baseUrlAuth,
    @required this.baseUrlResource,
    this.timeout = 10000,
    this.appTitle = "Tienda del infinito",
  });

  static Future<AppConfig> forEnviroment(String env) async {
    final contents = await rootBundle.loadString(
      'assets/config/$env.json',
    );

    final json = jsonDecode(contents);

    String baseUrlAuth = json['baseUrlAuth'] ?? "";
    String baseUrlResource = json['baseUrlResource'] ?? "";
    int timeout = json['timeout'] ?? 10000;
    String appTitle = json['appTitle'] ?? "";

    if (appTitle.trim().isEmpty) appTitle = "Tienda del infinito";

    return AppConfig._(
        flavor: env,
        baseUrlAuth: baseUrlAuth,
        baseUrlResource: baseUrlResource,
        timeout: timeout,
        appTitle: appTitle);
  }
}

class PreferencesConfig {
  static const String appkey = 'shopend';
}

AppConfig appConfig;
