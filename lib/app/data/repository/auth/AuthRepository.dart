import 'package:flutter/foundation.dart';
import 'package:shopend/app/data/security/OAuth.dart';

abstract class AuthRepository {
  Future<String> authenticate({@required String username,@required String password});
  Future<bool> changepass({@required String username, @required String oldpass,@required String newpass});

  Future<void> deleteToken();

  Future<void> persistToken(OAuthToken token);

  Future<bool> hasToken();
  String getToken();
}