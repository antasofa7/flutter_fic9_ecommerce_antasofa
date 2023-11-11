import 'package:fic9_ecommerce_template_app/common/extensions/on_context.dart';
import 'package:fic9_ecommerce_template_app/data/datasources/auth_local_datasource.dart';
import 'package:fic9_ecommerce_template_app/presentation/shippingAddress/bloc/getAddress/get_address_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/common.dart';
import '../../../data/models/responses/addAddress/add_address_response_model.dart';
import '../widgets/address_tile_widget.dart';
import 'add_address_page.dart';

class ShippingAddressPage extends StatefulWidget {
  const ShippingAddressPage({super.key});

  @override
  State<ShippingAddressPage> createState() => _ShippingAddressPageState();
}

class _ShippingAddressPageState extends State<ShippingAddressPage> {
  AddAddressResponseModel? selectedAddress;

  @override
  void initState() {
    context
        .read<GetAddressBloc>()
        .add(const GetAddressEvent.retrieveAddressByUserId());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorName.white,
        appBar: AppBar(title: const Text('Alamat Pengiriman'), actions: [
          IconButton(
              onPressed: () => context.to(child: const AddAddressPage()),
              icon: const Icon(Icons.add))
        ]),
        body: BlocBuilder<GetAddressBloc, GetAddressState>(
          builder: (context, state) => state.maybeWhen(
              orElse: () => const Center(
                    child: Text(
                      'Alamat belum tersedia',
                      style: TextStyle(fontSize: 18.0, color: ColorName.red),
                    ),
                  ),
              loading: () => const Center(child: CircularProgressIndicator()),
              success: (data) => ListView.separated(
                  padding: const EdgeInsets.all(16.0),
                  separatorBuilder: (_, index) => const SpaceHeight(16.0),
                  itemCount: data.data!.length,
                  itemBuilder: (_, index) => AddressTileWidget(
                      isSelected: selectedAddress == data.data![index],
                      // ? selectedAddress == data.data![index]
                      // : data.data![index].attributes!.is_default,
                      data: data.data![index],
                      onTap: () {
                        setState(() {
                          selectedAddress = data.data![index];
                        });
                      }))),
        ),
        bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Button.filled(
              disabled: false,
              label: 'Pilih',
              onPressed: selectedAddress != null
                  ? () {
                      AuthLocalDatasource().saveAddress(selectedAddress!);
                      context.back(result: true);
                    }
                  : null,
            )));
  }
}
