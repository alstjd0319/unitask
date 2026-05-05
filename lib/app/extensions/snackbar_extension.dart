import 'package:flutter/material.dart';

extension SnackbarExtension on BuildContext {
  void showSnackbar(String text, {bool isError = false}) {
    ScaffoldMessenger.of(
      this,
    ).showSnackBar(const SnackBar(content: Text('곧 기능을 출시합니다!')));
  }
}
