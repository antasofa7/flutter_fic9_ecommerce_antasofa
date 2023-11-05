import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:fic9_ecommerce_template_app/data/datasources/auth_local_datasource.dart';
import 'package:fic9_ecommerce_template_app/data/models/responses/orderDetail/order_detail_response_model.dart';
import 'package:http/http.dart' as http;

import '../../common/common.dart';
import '../models/models.dart';

class OrderRemoteDataSource {
  Future<Either<String, OrderResponseModel>> order(
      OrderRequestModel model) async {
    try {
      final token = await AuthLocalDatasource().useToken();
      final response = await http.post(
          Uri.parse('${Variables.baseUrl}api/orders'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          },
          body: model.toJson());

      if (response.statusCode == 200) {
        return Right(OrderResponseModel.fromJson(jsonDecode(response.body)));
      }
      return const Left('Server error!');
    } catch (e) {
      rethrow;
    }
  }

  Future<Either<String, OrderDetailResponseModel>> getOrderById(
      String id) async {
    try {
      final token = await AuthLocalDatasource().useToken();
      final response = await http
          .get(Uri.parse('${Variables.baseUrl}api/orders/$id'), headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      });

      if (response.statusCode == 200) {
        return Right(OrderDetailResponseModel.fromJson(
            jsonDecode(response.body)['data']));
      }
      return const Left('Server error');
    } catch (e) {
      rethrow;
    }
  }
}
