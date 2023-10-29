import 'package:fic9_ecommerce_template_app/common/extensions/int_ext.dart';
import 'package:fic9_ecommerce_template_app/presentation/cart/widgets/cart_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/common.dart';
import '../../../common/components/row_text.dart';
import '../bloc/cart_bloc.dart';

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
        Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                border: Border.all(color: ColorName.border)),
            child: Column(children: [
              BlocBuilder<CartBloc, CartState>(
                builder: (context, state) => state.maybeWhen(
                    orElse: () => Column(
                          children: [
                            RowText(
                                label: 'Total Harga',
                                value: 0.currencyFormatRp),
                            const SpaceHeight(12.0),
                            RowText(
                                label: 'Biaya Pengiriman',
                                value: 0.currencyFormatRp),
                            const SpaceHeight(40.0),
                            const Divider(color: ColorName.border),
                            const SpaceHeight(12.0),
                            RowText(
                              label: 'Total Harga',
                              value: 0.currencyFormatRp,
                              valueColor: ColorName.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ],
                        ),
                    success: (carts) {
                      int totalPrice = 0;
                      int shippingCosts = 0;
                      for (var cart in carts) {
                        totalPrice +=
                            int.parse(cart.product.attributes!.price) *
                                cart.quantity;
                        shippingCosts = cart.shippingCosts;
                      }
                      return Column(
                        children: [
                          RowText(
                              label: 'Total Harga',
                              value: totalPrice.currencyFormatRp),
                          const SpaceHeight(12.0),
                          RowText(
                              label: 'Biaya Pengiriman',
                              value: shippingCosts.currencyFormatRp),
                          const SpaceHeight(40.0),
                          const Divider(color: ColorName.border),
                          const SpaceHeight(12.0),
                          RowText(
                            label: 'Total Harga',
                            value:
                                (totalPrice + shippingCosts).currencyFormatRp,
                            valueColor: ColorName.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      );
                    }),
              ),
              const SpaceHeight(16.0),
              Button.filled(onPressed: () {}, label: 'Bayar Sekarang')
            ]))
      ]),
    );
  }
}
