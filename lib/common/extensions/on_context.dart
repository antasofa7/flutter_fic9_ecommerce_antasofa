import 'package:flutter/material.dart';

extension OnContext on BuildContext {
  Future<T?> to<T extends Object?>(
          {required Widget child, bool removed = false}) =>
      removed
          ? Navigator.pushReplacement(
              this, MaterialPageRoute(builder: (context) => child))
          : Navigator.push(
              this, MaterialPageRoute(builder: (context) => child));

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> alert(
          {required String content}) =>
      ScaffoldMessenger.of(this).showSnackBar(SnackBar(
        content: Text(content),
        backgroundColor: Colors.red[700],
        behavior: SnackBarBehavior.floating,
      ));
}
