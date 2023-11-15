import 'package:fic9_ecommerce_template_app/common/extensions/date_time_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/common.dart';
import '../../../data/models/responses/orderDetail/order_detail_response_model.dart';
import '../bloc/bloc/cek_resi_bloc.dart';

class ManifestDeliveryPage extends StatefulWidget {
  final OrderDetailResponseModel data;
  const ManifestDeliveryPage({super.key, required this.data});

  @override
  State<ManifestDeliveryPage> createState() => _ManifestDeliveryPageState();
}

class _ManifestDeliveryPageState extends State<ManifestDeliveryPage> {
  @override
  void initState() {
    // print(widget.data.attributes!.courierName);
    context.read<CekResiBloc>().add(CekResiEvent.getCekResi(
        resi: widget.data.attributes!.noResi,
        courier: widget.data.attributes!.courierName
            .split(' ')
            .first
            .toLowerCase()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Lacak Pengiriman'),
        ),
        body: SingleChildScrollView(
            // padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: BlocBuilder<CekResiBloc, CekResiState>(
          builder: (context, state) => state.maybeWhen(
            orElse: () => const Center(child: CircularProgressIndicator()),
            success: (data) => Stepper(
              physics: const ClampingScrollPhysics(),
              // connectorColor: const MaterialStatePropertyAll(ColorName.primary),
              steps: data.rajaongkir!.result!.manifest!
                  .map(
                    (e) => Step(
                        title: Text(e.manifest_code,
                            style: const TextStyle(color: ColorName.grey)),
                        subtitle: Text(
                            '${e.manifest_date!.toFormattedDateWithDay()} ${e.manifest_time}',
                            style: const TextStyle(color: ColorName.grey)),
                        content: Text(e.manifest_description,
                            style: const TextStyle(color: ColorName.grey)),
                        isActive: e.manifest_description.isNotEmpty),
                  )
                  .toList(),
              controlsBuilder: (context, details) => const Row(
                children: [SizedBox(child: null), SizedBox(child: null)],
              ),
            ),
            failed: (data) =>
                Center(child: Text(data.rajaongkir!.status!.description)),
          ),
        )));
  }
}
