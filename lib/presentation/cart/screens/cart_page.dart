import 'package:fic9_ecommerce_template_app/common/extensions/int_ext.dart';
import 'package:fic9_ecommerce_template_app/common/extensions/on_context.dart';
import 'package:fic9_ecommerce_template_app/presentation/cart/widgets/cart_item_widget.dart';
import 'package:fic9_ecommerce_template_app/presentation/payment/screens/payment_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/common.dart';
import '../../../common/components/row_text.dart';
import '../../../data/models/models.dart';
import '../bloc/cart/cart_bloc.dart';
import '../bloc/order/order_bloc.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Keranjang',
        ),
      ),
      body: ListView(padding: const EdgeInsets.all(16.0), children: [
        BlocBuilder<CartBloc, CartState>(
            builder: (context, state) => state.maybeWhen(
                orElse: () => const Center(child: CircularProgressIndicator()),
                success: (carts) => ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (_, i) => CartItemWidget(data: carts[i]),
                    separatorBuilder: (_, i) => const SpaceHeight(16.0),
                    itemCount: carts.length))),
        const SpaceHeight(70.0),
        BlocBuilder<CartBloc, CartState>(
            builder: (context, state) => state.maybeWhen(
                orElse: () => const SummaryCartWidget(
                    subTotalPrice: 0, deliveryPrice: 0, totalPrice: 0),
                success: (carts) {
                  int subTotalPrice = 0;
                  int deliveryPrice = 0;
                  for (var cart in carts) {
                    subTotalPrice += int.parse(cart.product.attributes!.price) *
                        cart.quantity;
                    deliveryPrice = cart.deliveryPrice;
                  }
                  List<ItemModel> items = carts
                      .map((e) => ItemModel(
                          id: e.product.id!,
                          productName: e.product.attributes!.name,
                          price: int.parse(e.product.attributes!.price),
                          qty: e.quantity))
                      .toList();
                  return SummaryCartWidget(
                      subTotalPrice: subTotalPrice,
                      deliveryPrice: deliveryPrice,
                      totalPrice: (subTotalPrice + deliveryPrice),
                      items: items);
                }))
      ]),
    );
  }
}

class SummaryCartWidget extends StatelessWidget {
  final int subTotalPrice, deliveryPrice, totalPrice;
  final List<ItemModel>? items;
  const SummaryCartWidget({
    super.key,
    required this.subTotalPrice,
    required this.deliveryPrice,
    required this.totalPrice,
    this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            border: Border.all(color: ColorName.border)),
        child: Column(children: [
          RowText(
              label: 'Subtotal Harga', value: subTotalPrice.currencyFormatRp),
          const SpaceHeight(12.0),
          RowText(
              label: 'Biaya Pengiriman', value: deliveryPrice.currencyFormatRp),
          const SpaceHeight(40.0),
          const Divider(color: ColorName.border),
          const SpaceHeight(12.0),
          RowText(
            label: 'Total Harga',
            value: totalPrice.currencyFormatRp,
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
              orElse: () => Button.filled(
                  onPressed: () =>
                      // context
                      //     .read<OrderDetailBloc>()
                      //     .add(OrderDetailEvent.getOrderDetail('14'))
                      context.read<OrderBloc>().add(OrderEvent.order(
                          OrderRequestModel(
                              data: DataModel(
                                  items: items ?? [],
                                  totalPrice: totalPrice,
                                  deliveryAddress: 'Surabaya',
                                  courierName: 'JNT',
                                  courierPrice: deliveryPrice,
                                  status: 'waiting')))),
                  label: 'Bayar Sekarang'),
              loading: () => const Center(child: CircularProgressIndicator()),
            ),
          )
        ]));
  }
}
