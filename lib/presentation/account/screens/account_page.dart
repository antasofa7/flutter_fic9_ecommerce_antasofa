import 'package:fic9_ecommerce_template_app/common/extensions/on_context.dart';
import 'package:fic9_ecommerce_template_app/presentation/shippingAddress/screens/shipping_address_page.dart';
import 'package:flutter/material.dart';

import '../../../common/common.dart';
import '../../order/screens/order_page.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Account'),
        ),
        body: ListView(
          children: List.generate(
              4,
              (i) => ListTile(
                    leading: Image.asset(
                        [
                          Images.iconUser,
                          Images.bag,
                          Images.location,
                          Images.logout
                        ][i],
                        width: 24.0),
                    title: Text(['Profile', 'Pesanan', 'Alamat', 'Logout'][i],
                        style: const TextStyle(
                            color: ColorName.primary,
                            fontWeight: FontWeight.bold)),
                    onTap: [
                      () {},
                      () => context.to(child: const OrderPage()),
                      () => context.to(child: const ShippingAddressPage()),
                      () {},
                    ][i],
                  )),
        ));
  }
}
