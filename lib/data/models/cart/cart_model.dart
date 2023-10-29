import 'package:equatable/equatable.dart';
import 'package:fic9_ecommerce_template_app/common/extensions/int_ext.dart';

import '../models.dart';

// ignore: must_be_immutable
class CartModel extends Equatable {
  final ProdutctDataModel product;
  int quantity;
  int shippingCosts;

  CartModel({required this.product, this.quantity = 0, this.shippingCosts = 0});

  String get priceFormat =>
      int.parse(product.attributes!.price).currencyFormatRp;

  @override
  List<Object?> get props => [
        'product: $product',
        'quantity: $quantity',
        'shippingCosts: $shippingCosts',
        'price: $priceFormat'
      ];
}
