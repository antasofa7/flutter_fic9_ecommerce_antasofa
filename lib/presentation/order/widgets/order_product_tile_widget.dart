import 'package:fic9_ecommerce_template_app/common/constants/colors.dart';
import 'package:fic9_ecommerce_template_app/common/extensions/int_ext.dart';
import 'package:flutter/material.dart';

import '../../../data/models/responses/orderDetail/order_detail_response_model.dart';

class OrderProductTileWidget extends StatelessWidget {
  final ItemModel data;
  const OrderProductTileWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        data.productName,
        style: const TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
      ),
      subtitle: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Text('${data.price.currencyFormatRp} x ${data.qty}',
              style: const TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  color: ColorName.primary))),
      contentPadding: const EdgeInsets.all(16.0),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
          side: const BorderSide(color: ColorName.border)),
    );
  }
}
