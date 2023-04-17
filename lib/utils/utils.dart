import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        content: Text(message,style: const TextStyle(color: Colors.white),),
        duration: const Duration(seconds: 1),
  ));
}