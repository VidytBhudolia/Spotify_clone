import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String message) {
  WidgetsBinding.instance!.addPostFrameCallback((_) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
  });
}
