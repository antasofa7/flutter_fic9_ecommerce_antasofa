import 'package:fic9_ecommerce_template_app/common/extensions/on_context.dart';
import 'package:fic9_ecommerce_template_app/data/datasources/auth_local_datasource.dart';
import 'package:fic9_ecommerce_template_app/presentation/dashboard/screens/dashboard_page.dart';
import 'package:flutter/material.dart';

import '../../../common/common.dart';
import 'login_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future.delayed(
        const Duration(seconds: 1),
        () => AuthLocalDatasource().isLoggedIn().then((isLoggedIn) => isLoggedIn
            ? context.to(child: const DashboardPage())
            : context.to(child: const LoginPage())));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Image.asset(
        Images.logo,
        width: 200,
        height: 200,
      )),
    );
  }
}
