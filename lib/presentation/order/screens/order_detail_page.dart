import 'package:fic9_ecommerce_template_app/common/common.dart';
import 'package:fic9_ecommerce_template_app/common/extensions/date_time_ext.dart';
import 'package:fic9_ecommerce_template_app/common/extensions/int_ext.dart';
import 'package:fic9_ecommerce_template_app/common/extensions/string_ext.dart';
import 'package:fic9_ecommerce_template_app/presentation/order/widgets/order_product_tile_widget.dart';
import 'package:fic9_ecommerce_template_app/presentation/order/widgets/order_status_widget.dart';
import 'package:flutter/material.dart';

import '../../../data/models/responses/orderDetail/order_detail_response_model.dart';

class OrderDetailPage extends StatelessWidget {
  final OrderDetailResponseModel data;
  const OrderDetailPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    int price = data.attributes!.items!
        .map((e) => e.price)
        .toList()
        .reduce((value, element) => value + element);
    List<String> status = [];
    status.add(data.attributes!.status.orderStatus);
    // switch (data.attributes!.status) {
    //   case 'on-process':
    //     status.add('Dikemas');
    //     break;
    //   case 'on-delivery':
    //     status.add('Dikirim');
    //     break;
    //   case 'delivered':
    //     status.add('Diterima');
    //     break;
    //   default:
    // }
    return Scaffold(
        appBar: AppBar(title: const Text('Detail Pesanan')),
        body: ListView(padding: const EdgeInsets.all(16.0), children: [
          OrderStatusWidget(status: status),
          const SpaceHeight(24.0),
          const Text('Produk', style: TextStyle(fontWeight: FontWeight.bold)),
          const SpaceHeight(14.0),
          ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: data.attributes!.items!.length,
              separatorBuilder: (_, __) => const SpaceHeight(16.0),
              itemBuilder: (_, i) => OrderProductTileWidget(
                    data: data.attributes!.items![i],
                  )),
          const SpaceHeight(24.0),
          const Text('Detail Pengiriman',
              style: TextStyle(fontWeight: FontWeight.bold)),
          const SpaceHeight(14.0),
          Container(
              padding: const EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  border: Border.all(color: ColorName.border)),
              child: Column(children: [
                RowText(
                    label: 'Waktu Pengiriman',
                    value:
                        data.attributes!.createdAt!.toFormattedDateWithDay()),
                const SpaceHeight(12.0),
                RowText(
                    label: 'Ekspedisi Pengiriman',
                    value: data.attributes!.courierName),
                const SpaceHeight(12.0),
                RowText(label: 'Nomor Resi', value: data.attributes!.noResi),
                const SpaceHeight(12.0)
              ])),
          const SpaceHeight(24.0),
          const Text('Detail Pembayaran',
              style: TextStyle(fontWeight: FontWeight.bold)),
          const SpaceHeight(14.0),
          Container(
            padding: const EdgeInsets.all(24.0),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              border: Border.all(color: ColorName.border),
            ),
            child: Column(
              children: [
                RowText(
                  label: 'Total ${data.attributes!.items!.length} Item',
                  value: price.currencyFormatRp,
                ),
                const SpaceHeight(12.0),
                RowText(
                  label: 'Ongkir',
                  value: data.attributes!.courierPrice.currencyFormatRp,
                ),
                const SpaceHeight(12.0),
                RowText(
                  label: 'Total ',
                  value: data.attributes!.totalPrice.currencyFormatRp,
                  valueColor: ColorName.primary,
                  fontWeight: FontWeight.w700,
                ),
              ],
            ),
          ),
        ]));
  }
}
