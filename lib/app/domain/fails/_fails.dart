// @dart=2.9
class SignInUserPassNoValidException implements Exception {}

class ChangeUserPasswordFail implements Exception {
  final String msg;

  const ChangeUserPasswordFail(this.msg);

  String toString() => msg;
}

class SignInNoValidException implements Exception {}
