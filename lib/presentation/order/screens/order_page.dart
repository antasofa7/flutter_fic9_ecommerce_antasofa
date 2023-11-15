import 'package:fic9_ecommerce_template_app/common/components/components.dart';
import 'package:fic9_ecommerce_template_app/presentation/order/widgets/order_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/buyerOrder/buyer_order_bloc.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  void initState() {
    context
        .read<BuyerOrderBloc>()
        .add(const BuyerOrderEvent.retrieveBuyerOrder());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Pesanan')),
        body: BlocBuilder<BuyerOrderBloc, BuyerOrderState>(
          builder: (context, state) => state.maybeWhen(
              orElse: () => const SpaceHeight(0),
              loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
              success: (data) => data.isEmpty
                  ? const Center(child: Text('Tidak ada data'))
                  : RefreshIndicator(
                      onRefresh: () async => context
                          .read<BuyerOrderBloc>()
                          .add(const BuyerOrderEvent.retrieveBuyerOrder()),
                      child: ListView.separated(
                          padding: const EdgeInsets.all(16.0),
                          itemBuilder: (_, i) => OrderCardWidget(data: data[i]),
                          separatorBuilder: (_, i) => const SpaceHeight(16.0),
                          itemCount: data.length),
                    )),
        ));
  }
}
