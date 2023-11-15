import 'package:fic9_ecommerce_template_app/presentation/cart/bloc/costs/get_costs_bloc.dart';
import 'package:fic9_ecommerce_template_app/presentation/order/bloc/bloc/cek_resi_bloc.dart';
import 'package:fic9_ecommerce_template_app/presentation/order/bloc/buyerOrder/buyer_order_bloc.dart';
import 'package:fic9_ecommerce_template_app/presentation/shippingAddress/bloc/addAddress/add_address_bloc.dart';
import 'package:fic9_ecommerce_template_app/presentation/shippingAddress/bloc/city/city_bloc.dart';
import 'package:fic9_ecommerce_template_app/presentation/shippingAddress/bloc/subdistrict/subdistrict_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'presentation/auth/bloc/login/login_bloc.dart';
import 'presentation/auth/bloc/register/register_bloc.dart';
import 'presentation/auth/screens/splash_page.dart';
import 'presentation/cart/bloc/cart/cart_bloc.dart';
import 'presentation/cart/bloc/order/order_bloc.dart';
import 'presentation/home/bloc/product/products_bloc.dart';
import 'presentation/payment/bloc/bloc/order_detail_bloc.dart';
import 'presentation/shippingAddress/bloc/getAddress/get_address_bloc.dart';
import 'presentation/shippingAddress/bloc/province/province_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RegisterBloc(),
        ),
        BlocProvider(
          create: (context) => LoginBloc(),
        ),
        BlocProvider(
          create: (context) =>
              ProductsBloc()..add(const ProductsEvent.getAll()),
        ),
        BlocProvider(
          create: (context) => CartBloc(),
        ),
        BlocProvider(
          create: (context) => OrderBloc(),
        ),
        BlocProvider(
          create: (context) => OrderDetailBloc(),
        ),
        BlocProvider(create: (context) => ProvinceBloc()),
        BlocProvider(create: (context) => CityBloc()),
        BlocProvider(
          create: (context) => SubdistrictBloc(),
        ),
        BlocProvider(
          create: (context) => AddAddressBloc(),
        ),
        BlocProvider(
          create: (context) => GetAddressBloc(),
        ),
        BlocProvider(
          create: (context) => GetCostsBloc(),
        ),
        BlocProvider(
          create: (context) => BuyerOrderBloc(),
        ),
        BlocProvider(
          create: (context) => CekResiBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SplashPage(),
      ),
    );
  }
}
