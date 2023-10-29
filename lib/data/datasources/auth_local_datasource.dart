import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalDatasource {
  final String tokenKey = 'TOKEN_KEY';
  //save auth data
  // Future<void> saveAuthData(AuthResponseModel model) async {
  //   final pref = await SharedPreferences.getInstance();
  //   await pref.setString('auth', model.toJson());
  // }

  Future<bool> keepToken(String token) async {
    final pref = await SharedPreferences.getInstance();
    bool saved = await pref.setString(tokenKey, token);
    return saved;
  }

  Future<String> useToken() async {
    final pref = await SharedPreferences.getInstance();
    final token = pref.getString(tokenKey) ?? '';
    return token;
  }

  // Future<User> getUser() async {
  //   final pref = await SharedPreferences.getInstance();
  //   final authJson = pref.getString('auth') ?? '';
  //   final authData = AuthResponseModel.fromJson(jsonDecode(authJson));
  //   return authData.user!;
  // }

  Future<bool> isLoggedIn() async {
    final pref = await SharedPreferences.getInstance();
    final token = pref.getString(tokenKey) ?? '';
    return token.isNotEmpty;
  }

  Future<void> removeToken() async {
    final pref = await SharedPreferences.getInstance();
    await pref.remove(tokenKey);
  }
}
