import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:fic9_ecommerce_template_app/data/datasources/auth_local_datasource.dart';
import 'package:fic9_ecommerce_template_app/data/models/requests/add_address_request_model.dart';
import 'package:fic9_ecommerce_template_app/data/models/responses/addAddress/add_address_response_model.dart';
import 'package:fic9_ecommerce_template_app/data/models/responses/getAddress/get_address_response_model.dart';
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

  Future<Either<String, OrderDetailResponseModel>> retrieveOrderById(
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

  Future<Either<String, List<OrderDetailResponseModel>>>
      retrieveOrderByBuyerId() async {
    try {
      final token = await AuthLocalDatasource().useToken();
      final user = await AuthLocalDatasource().getUser();
      final response = await http.get(
          Uri.parse(
              '${Variables.baseUrl}api/orders?filters[buyerId][\$eq]=${user.id}'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          });
      // print(response.body);

      if (response.statusCode == 200) {
        return Right(List.from(jsonDecode(response.body)['data'] ?? [])
            .map((e) => OrderDetailResponseModel.fromJson(e))
            .toList());
      }
      return const Left('Server error');
    } catch (e) {
      rethrow;
    }
  }

  // add address
  Future<Either<String, AddAddressResponseModel>> addAddress(
      AddAddressRequestModel request) async {
    try {
      final token = await AuthLocalDatasource().useToken();
      String url = '${Variables.baseUrl}api/addresses';
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      };

      final response = await http.post(Uri.parse(url),
          headers: headers, body: request.toJson());

      if (response.statusCode == 200) {
        return Right(AddAddressResponseModel.fromJson(
            jsonDecode(response.body)['data']));
      }
      return const Left('Server error');
    } catch (e) {
      rethrow;
    }
  }

  Future<Either<String, GetAddressResponseModel>>
      retrieveAddressByUserId() async {
    try {
      final token = await AuthLocalDatasource().useToken();
      final user = await AuthLocalDatasource().getUser();
      final url =
          '${Variables.baseUrl}api/addresses?filters[user_id][\$eq]=${user.id}';
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      };

      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        return Right(
            GetAddressResponseModel.fromJson(jsonDecode(response.body)));
      }
      return Left('Server error: ${response.statusCode}');
    } catch (e) {
      rethrow;
    }
  }
}
