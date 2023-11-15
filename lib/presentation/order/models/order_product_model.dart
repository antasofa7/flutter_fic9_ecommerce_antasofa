// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:fic9_ecommerce_template_app/common/extensions/int_ext.dart';

class OrderProductModel extends Equatable {
  final String imagePath;
  final String name;
  final int price;

  const OrderProductModel(
      {required this.imagePath, required this.name, required this.price});

  String get priceFormat => price.currencyFormatRp;

  @override
  List<Object?> get props =>
      ['imagePath: $imagePath', 'name: $name', 'price: $price'];
}
