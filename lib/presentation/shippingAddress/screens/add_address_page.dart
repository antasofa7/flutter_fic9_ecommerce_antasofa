import 'package:fic9_ecommerce_template_app/common/extensions/on_context.dart';
import 'package:fic9_ecommerce_template_app/data/datasources/auth_local_datasource.dart';
import 'package:fic9_ecommerce_template_app/data/models/responses/province/province_response_model.dart';
import 'package:fic9_ecommerce_template_app/presentation/shippingAddress/bloc/addAddress/add_address_bloc.dart';
import 'package:fic9_ecommerce_template_app/presentation/shippingAddress/bloc/city/city_bloc.dart';
import 'package:fic9_ecommerce_template_app/presentation/shippingAddress/bloc/subdistrict/subdistrict_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/common.dart';
import '../../../data/models/models.dart';
import '../../../data/models/responses/subdistrict/subdistrict_response_model.dart';
import '../bloc/province/province_bloc.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({super.key});

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final zipCodeController = TextEditingController();
  final phoneNumberController = TextEditingController();

  bool isDefault = false;

  ProvinceModel? selectedProvince;
  //  =
  //     const ProvinceModel(province_id: '1', province: 'Bali');

  CityModel? selectedCity;
  //  = const CityModel(
  //     city_id: '1',
  //     province_id: '1',
  //     province: 'Bali',
  //     type: 'Kabupaten',
  //     city_name: 'Badung',
  //     postal_code: '80351');

  SubdistrictModel? selectedSubdistrict;
  //  = const SubdistrictModel(
  //     subdistrict_id: '1',
  //     province_id: '1',
  //     province: 'Bali',
  //     city_id: '1',
  //     type: 'Kabupaten',
  //     subdistrict_name: 'Kuta');

  @override
  void initState() {
    context.read<ProvinceBloc>().add(const ProvinceEvent.retrieveAll());
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();
    zipCodeController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Tambah Alamat')),
        body: ListView(padding: const EdgeInsets.all(16.0), children: [
          const SpaceHeight(24.0),
          CustomTextField2(
            controller: nameController,
            label: 'Nama Lengkap',
            keyboardType: TextInputType.name,
          ),
          const SpaceHeight(24.0),
          CustomTextField2(
            controller: addressController,
            label: 'Alamat',
            keyboardType: TextInputType.multiline,
            maxLines: 3,
          ),
          const SpaceHeight(24.0),
          CustomTextField2(
            controller: phoneNumberController,
            label: 'Nomor Handphone',
            keyboardType: TextInputType.phone,
          ),
          const SpaceHeight(24.0),
          BlocBuilder<ProvinceBloc, ProvinceState>(
              builder: (context, state) => state.maybeWhen(
                  orElse: () => const CustomDropdown<String>(
                        value: '-',
                        items: ['-'],
                        label: 'Provinsi',
                      ),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  success: (provinces) {
                    // selectedProvince = provinces.first;
                    return CustomDropdown<ProvinceModel>(
                        value: selectedProvince ?? provinces.first,
                        items: provinces,
                        label: 'Provinsi',
                        onChanged: (value) {
                          context.read<CityBloc>().add(
                              CityEvent.retrieveAllByProvinceId(
                                  value!.province_id));
                          setState(() {
                            selectedProvince = value;
                          });
                        });
                  })),
          const SpaceHeight(24.0),
          BlocBuilder<CityBloc, CityState>(
            builder: (context, state) => state.maybeWhen(
                orElse: () => const CustomDropdown<String>(
                      value: '-',
                      items: ['-'],
                      label: 'Kota/Kabupaten',
                    ),
                loading: () => const Center(child: CircularProgressIndicator()),
                success: (cities) {
                  // selectedCity = cities.first;
                  return CustomDropdown<CityModel>(
                      value: selectedCity ?? cities.first,
                      items: cities,
                      label: 'Kota/Kabupaten',
                      onChanged: (value) {
                        context.read<SubdistrictBloc>().add(
                            SubdistrictEvent.retrieveAllByCityId(
                                value!.city_id));
                        setState(() {
                          selectedCity = value;
                        });
                      });
                }),
          ),
          const SpaceHeight(24.0),
          BlocBuilder<SubdistrictBloc, SubdistrictState>(
            builder: (context, state) => state.maybeWhen(
              orElse: () => const CustomDropdown<String>(
                value: '-',
                items: ['-'],
                label: 'Kecamatan',
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              success: (subdistricts) {
                // selectedSubdistrict = subdistricts.first;
                return CustomDropdown<SubdistrictModel>(
                    value: selectedSubdistrict ?? subdistricts.first,
                    items: subdistricts,
                    label: 'Kecamatan',
                    onChanged: (value) => setState(() {
                          selectedSubdistrict = value!;
                        }));
              },
            ),
          ),
          const SpaceHeight(24.0),
          CustomTextField2(
            controller: zipCodeController,
            label: 'Kode Pos',
            keyboardType: TextInputType.number,
          ),
          const SpaceHeight(24.0),
          CheckboxListTile(
              value: isDefault,
              title: const Text('Simpan sebagai alamat utama'),
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
              onChanged: (value) => setState(() {
                    isDefault = value!;
                  })),
        ]),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocConsumer<AddAddressBloc, AddAddressState>(
            listener: (context, state) => state.whenOrNull(success: (data) {
              context.back(result: data);
              context.alert(
                  content: 'Alamat berhasil disimpan!', color: ColorName.green);
              return null;
            }),
            builder: (context, state) => state.maybeWhen(
              orElse: () => Button.filled(
                  label: 'Tambah Alamat',
                  onPressed: () {
                    AuthLocalDatasource().getUser().then((user) => context
                        .read<AddAddressBloc>()
                        .add(AddAddressEvent.addAddress(
                            name: nameController.text,
                            address: addressController.text,
                            phone: phoneNumberController.text,
                            provId: selectedProvince!.province_id,
                            provName: selectedProvince!.province,
                            cityId: selectedCity!.city_id,
                            cityName:
                                '${selectedCity!.type} ${selectedCity!.city_name}',
                            subdistrictId: selectedSubdistrict!.subdistrict_id,
                            subdistrictName:
                                'Kecamatan ${selectedSubdistrict!.subdistrict_name}',
                            postCode: zipCodeController.text,
                            userId: user.id.toString(),
                            isDefault: isDefault)));
                    // context.back(result)
                  }),
              loading: () => const Center(child: CircularProgressIndicator()),
            ),
          ),
        ));
  }
}
