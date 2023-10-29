import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:fic9_ecommerce_template_app/data/datasources/auth_local_datasource.dart';
import 'package:http/http.dart' as http;

import '../../common/constants/variables.dart';
import '../models/models.dart';

class AuthRemoteDatasource {
  Future<Either<String, AuthResponseModel>> register(
      RegisterRequestModel data) async {
    final headers = {'Content-Type': 'application/json'};

    try {
      final response = await http.post(
          Uri.parse('${Variables.baseUrl}api/auth/local/register'),
          body: data.toJson(),
          headers: headers);

      if (response.statusCode == 200) {
        return right(AuthResponseModel.fromJson(jsonDecode(response.body)));
      }
      return left('Server error');
    } catch (e) {
      rethrow;
    }
  }

  Future<Either<String, AuthResponseModel>> login(
      LoginRequestModel data) async {
    final headers = {'Content-Type': 'application/json'};

    try {
      final response = await http.post(
          Uri.parse('${Variables.baseUrl}api/auth/local'),
          body: data.toJson(),
          headers: headers);

      if (response.statusCode == 200) {
        var responseMap = jsonDecode(response.body);

        AuthLocalDatasource().keepToken(responseMap['jwt']);
        return right(AuthResponseModel.fromJson(responseMap['user']));
      }

      return left('Server error');
    } catch (e) {
      return left('$e');
    }
  }
}
