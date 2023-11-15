import 'package:fic9_ecommerce_template_app/common/extensions/on_context.dart';
import 'package:fic9_ecommerce_template_app/data/datasources/auth_local_datasource.dart';
import 'package:fic9_ecommerce_template_app/data/models/requests/cost_request_model.dart';
import 'package:fic9_ecommerce_template_app/presentation/cart/bloc/costs/get_costs_bloc.dart';
import 'package:fic9_ecommerce_template_app/presentation/cart/models/courier_model.dart';
import 'package:fic9_ecommerce_template_app/presentation/cart/widgets/cart_item_widget.dart';
import 'package:fic9_ecommerce_template_app/presentation/shippingAddress/bloc/getAddress/get_address_bloc.dart';
import 'package:fic9_ecommerce_template_app/presentation/shippingAddress/screens/add_address_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/common.dart';
import '../../../data/models/models.dart';
import '../../shippingAddress/screens/shipping_address_page.dart';
import '../bloc/cart/cart_bloc.dart';
import '../bloc/order/order_bloc.dart';
import '../widgets/summary_dart_widget.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  String? address;
  String? courier;

  @override
  void initState() {
    context
        .read<GetAddressBloc>()
        .add(const GetAddressEvent.getSelectedAddress());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Keranjang',
        ),
      ),
      body: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) => state.maybeWhen(
              orElse: () => const Center(child: CircularProgressIndicator()),
              success: (carts) {
                int subTotalPrice = 0;
                // int deliveryPrice = 0;
                for (var cart in carts) {
                  subTotalPrice +=
                      int.parse(cart.product.attributes!.price) * cart.quantity;
                  // deliveryPrice = cart.deliveryPrice;
                }
                List<ItemModel> items = carts
                    .map((e) => ItemModel(
                        id: e.product.id!,
                        productName: e.product.attributes!.name,
                        price: int.parse(e.product.attributes!.price),
                        qty: e.quantity))
                    .toList();
                return carts.isEmpty
                    ? const Center(
                        child: Text('Keranjang belanja masih kosong',
                            style: TextStyle(
                                fontSize: 18.0, color: ColorName.red)))
                    : ListView(padding: const EdgeInsets.all(16.0), children: [
                        ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (_, i) =>
                                CartItemWidget(data: carts[i]),
                            separatorBuilder: (_, i) => const SpaceHeight(16.0),
                            itemCount: carts.length),
                        const SpaceHeight(16.0),
                        Button.filled(
                          onPressed: () => context
                              .to(child: const ShippingAddressPage())
                              .then((refresh) => refresh != null
                                  ? context.read<GetAddressBloc>().add(
                                      const GetAddressEvent
                                          .getSelectedAddress())
                                  : null),
                          label: 'Pilih Alamat Pengiriman',
                        ),
                        const SpaceHeight(16.0),
                        BlocBuilder<GetAddressBloc, GetAddressState>(
                          builder: (context, state) => state.maybeWhen(
                              orElse: () => const Center(
                                  child: CircularProgressIndicator()),
                              select: (data) {
                                if (data == null) {
                                  return Column(children: [
                                    const Text(
                                      'Alamat belum tersedia',
                                      style: TextStyle(
                                          fontSize: 18.0, color: ColorName.red),
                                    ),
                                    const SpaceHeight(16.0),
                                    Button.filled(
                                      label: 'Tambah Alamat',
                                      onPressed: () => context.to(
                                          child: const AddAddressPage()),
                                    )
                                  ]);
                                }
                                address = data.attributes!.address;
                                // final address = data.data!.firstWhere(
                                //   (e) => e.attributes!.is_default,
                                //   orElse: () => data.data!.first,
                                // );
                                // print('object');
                                context.read<GetCostsBloc>().add(
                                    GetCostsEvent.retrieveCost(CostRequestModel(
                                        origin: subdistrictOrigin,
                                        destination:
                                            data.attributes!.subdistrict_id,
                                        courier: courier ?? 'jne')));

                                return Container(
                                  padding: const EdgeInsets.all(16.0),
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5.0)),
                                    border: Border.all(color: ColorName.border),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Alamat Pengiriman',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      const SpaceHeight(16.0),
                                      Text(
                                        data.attributes!.name,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: ColorName.grey,
                                        ),
                                      ),
                                      const SpaceHeight(8.0),
                                      Text(
                                        address ?? '',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: ColorName.grey,
                                        ),
                                      ),
                                      const SpaceHeight(8.0),
                                      Text(
                                        data.attributes!.phone,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: ColorName.grey,
                                        ),
                                      ),
                                      const SpaceHeight(16.0),
                                      CustomDropdown<CourierModel>(
                                        value: couriers.first,
                                        items: couriers,
                                        label: 'Kurir',
                                        onChanged: (value) {
                                          courier = value!.code;
                                          context.read<GetCostsBloc>().add(
                                              GetCostsEvent.retrieveCost(
                                                  CostRequestModel(
                                                      origin: subdistrictOrigin,
                                                      destination: data
                                                          .attributes!
                                                          .subdistrict_id,
                                                      courier: value.code)));
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        ),
                        const SpaceHeight(16.0),
                        BlocBuilder<GetCostsBloc, GetCostsState>(
                            builder: (context, state) => state.maybeWhen(
                                orElse: () => const RowText(
                                    label: 'Biaya Pengiriman', value: '0'),
                                success: (data) {
                                  int deliveryPrice = data.rajaongkir!.results!
                                      .first.costs!.first.cost!.first.value;
                                  int totalPrice = (data
                                          .rajaongkir!
                                          .results!
                                          .first
                                          .costs!
                                          .first
                                          .cost!
                                          .first
                                          .value +
                                      subTotalPrice);
                                  return SummaryCartWidget(
                                    subTotalPrice: subTotalPrice,
                                    deliveryPrice: deliveryPrice,
                                    totalPrice: totalPrice,
                                    items: items,
                                    // ongkirWidget: RowText(
                                    //     label: 'Biaya Pengiriman',
                                    //     value:
                                    //         .currencyFormatRp),

                                    // totalWidget: RowText(
                                    //   label: 'Total Harga',
                                    //   value: (data
                                    //               .rajaongkir!
                                    //               .results!
                                    //               .first
                                    //               .costs!
                                    //               .first
                                    //               .cost!
                                    //               .first
                                    //               .value +
                                    //           subTotalPrice)
                                    //       .currencyFormatRp,
                                    //   valueColor: ColorName.primary,
                                    //   fontWeight: FontWeight.bold,
                                    // ),
                                    onPressed: items.isEmpty
                                        ? null
                                        : () =>
                                            // context
                                            //     .read<OrderDetailBloc>()
                                            //     .add(OrderDetailEvent.getOrderDetail('14'))
                                            AuthLocalDatasource()
                                                .getUser()
                                                .then((user) => context
                                                    .read<OrderBloc>()
                                                    .add(OrderEvent.order(OrderRequestModel(
                                                        data: DataModel(
                                                            items: items,
                                                            totalPrice:
                                                                totalPrice,
                                                            deliveryAddress:
                                                                address ?? '',
                                                            courierName: data
                                                                .rajaongkir!
                                                                .results!
                                                                .first
                                                                .name,
                                                            courierPrice:
                                                                deliveryPrice,
                                                            status: 'waiting',
                                                            buyerId:
                                                                user.id))))),
                                  );
                                }))
                      ]);
              })),
    );
  }
}
