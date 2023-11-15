import 'package:fic9_ecommerce_template_app/common/extensions/int_ext.dart';
import 'package:fic9_ecommerce_template_app/common/extensions/on_context.dart';
import 'package:fic9_ecommerce_template_app/common/extensions/string_ext.dart';
import 'package:fic9_ecommerce_template_app/presentation/order/screens/manifest_delivery_page.dart';
import 'package:fic9_ecommerce_template_app/presentation/order/screens/order_detail_page.dart';
import 'package:flutter/material.dart';

import '../../../common/common.dart';
import '../../../data/models/responses/orderDetail/order_detail_response_model.dart';

class OrderCardWidget extends StatelessWidget {
  final OrderDetailResponseModel data;
  const OrderCardWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: data.attributes?.status == 'waiting' ||
              data.attributes?.status == 'canceled'
          ? null
          : () => context.to(
                  child: OrderDetailPage(
                data: data,
              )),
      child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            border: Border.all(color: ColorName.border),
          ),
          child: Column(children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text('NO RESI: ${data.attributes?.noResi ?? '-'}',
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              data.attributes?.status == 'canceled'
                  ? CustomChipWidget(label: data.attributes!.status.orderStatus)
                  : data.attributes?.status == 'waiting' ||
                          data.attributes?.status == 'on-process'
                      ? const SizedBox()
                      : Button.filled(
                          onPressed: () => context.to(
                              child: ManifestDeliveryPage(
                            data: data,
                          )),
                          label: 'Lacak',
                          height: 20.0,
                          width: 94.0,
                          fontSize: 11.0,
                        )
            ]),
            const SpaceHeight(24.0),
            RowText(
                label: 'Status',
                value: data.attributes?.status.orderStatus ?? '-',
                fontWeight: FontWeight.w600),
            const SpaceHeight(12.0),
            RowText(
                label: 'Harga',
                value: (data.attributes?.totalPrice ?? 0).currencyFormatRp,
                fontWeight: FontWeight.w600)
          ])),
    );
  }
}

class CustomChipWidget extends StatelessWidget {
  const CustomChipWidget({
    super.key,
    required this.label,
    this.color,
  });

  final String label;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20.0,
      width: 94.0,
      alignment: Alignment.center,
      decoration: ShapeDecoration(
          color: (color ?? ColorName.red).withOpacity(.05),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
              side: BorderSide(color: color ?? ColorName.red))),
      child: Text(label,
          style: TextStyle(
              fontSize: 11.0,
              color: color ?? ColorName.red,
              fontWeight: FontWeight.w500)),
    );
  }
}
