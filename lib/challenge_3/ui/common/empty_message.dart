import 'package:flutter/material.dart';

class EmptyMessage extends StatelessWidget {
  final String message;

  const EmptyMessage({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      alignment: Alignment.center,
      constraints: const BoxConstraints(maxHeight: 300),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey),
      ),
      child: Text(message),
    );
  }
}
