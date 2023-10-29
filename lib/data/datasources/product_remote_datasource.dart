import 'dart:convert';

import 'package:dartz/dartz.dart';
// import 'package:fic9_ecommerce_template_app/data/datasources/auth_local_datasource.dart';
import 'package:http/http.dart' as http;

import '../../common/common.dart';
import '../models/responses/products/products_response_model.dart';

class ProductRemoteDatasource {
  Future<Either<String, ProductsResponseModel>> getAllProduct() async {
    try {
      // String token = await AuthLocalDatasource().useToken();
      final headers = {
        'Content-Type': 'application/json',
        // 'Authorization': 'Bearer $token'
      };
      final response = await http.get(
          Uri.parse('${Variables.baseUrl}api/products?populate=*'),
          headers: headers);

      if (response.statusCode == 200) {
        return Right(ProductsResponseModel.fromJson(jsonDecode(response.body)));
      } else {
        return const Left('Server Error');
      }
    } catch (e) {
      return Left('$e');
    }
  }
}
