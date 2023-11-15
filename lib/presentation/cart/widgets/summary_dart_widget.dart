import 'package:fic9_ecommerce_template_app/common/extensions/on_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/extensions/int_ext.dart';
import '../../../common/common.dart';
import '../../../data/models/models.dart';
import '../../payment/screens/payment_page.dart';
import '../bloc/cart/cart_bloc.dart';
import '../bloc/order/order_bloc.dart';

class SummaryCartWidget extends StatelessWidget {
  final int? subTotalPrice, deliveryPrice, totalPrice;
  final List<ItemModel>? items;
  final Widget? ongkirWidget, totalWidget;
  final void Function()? onPressed;

  const SummaryCartWidget(
      {super.key,
      this.subTotalPrice,
      this.deliveryPrice,
      this.totalPrice,
      this.items,
      this.ongkirWidget,
      this.totalWidget,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            border: Border.all(color: ColorName.border)),
        child: Column(children: [
          RowText(
              label: 'Subtotal Harga', value: subTotalPrice!.currencyFormatRp),
          const SpaceHeight(12.0),
          ongkirWidget ??
              RowText(
                  label: 'Biaya Pengiriman',
                  value: deliveryPrice!.currencyFormatRp),
          const SpaceHeight(40.0),
          const Divider(color: ColorName.border),
          const SpaceHeight(12.0),
          totalWidget ??
              RowText(
                label: 'Total Harga',
                value: totalPrice!.currencyFormatRp,
                valueColor: ColorName.primary,
                fontWeight: FontWeight.bold,
              ),
          const SpaceHeight(16.0),
          BlocConsumer<OrderBloc, OrderState>(
            listener: (context, state) => state.whenOrNull(
              success: (data) {
                context.read<CartBloc>().add(const CartEvent.started());
                context.to(
                    child: PaymentPage(
                        invoiceUrl: data.invoice_url,
                        orderId: data.external_id));
                return null;
              },
            ),
            builder: (context, state) => state.maybeWhen(
              orElse: () =>
                  Button.filled(onPressed: onPressed, label: 'Bayar Sekarang'),
              loading: () => const Center(child: CircularProgressIndicator()),
            ),
          )
        ]));
  }
}
