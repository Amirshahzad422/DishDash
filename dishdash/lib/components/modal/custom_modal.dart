import 'package:flutter/material.dart';

class CustomModal extends StatelessWidget {
  const CustomModal({
    super.key,
    required this.title,
    required this.child,
  });

  final String title;
  final Widget child;

  static Future<T?> show<T>({
    required BuildContext context,
    required String title,
    required Widget child,
  }) {
    return showDialog<T>(
      context: context,
      builder: (context) => CustomModal(title: title, child: child),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: child,
    );
  }
}
