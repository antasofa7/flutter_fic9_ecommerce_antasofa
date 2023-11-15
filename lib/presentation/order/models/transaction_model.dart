import 'package:equatable/equatable.dart';
import 'package:fic9_ecommerce_template_app/common/extensions/int_ext.dart';

class TansactionModel extends Equatable {
  final String noResi;
  final String status;
  final int quantity;
  final int price;

  const TansactionModel(
      {required this.noResi,
      required this.status,
      required this.quantity,
      required this.price});

  String get item => '$quantity item yang dibeli';
  String get priceFormat => price.currencyFormatRp;

  @override
  List<Object?> get props => [
        'noResi: $noResi',
        'status: $status',
        'quantity: $quantity',
        'price: $price'
      ];
}
