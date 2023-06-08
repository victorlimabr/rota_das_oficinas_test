import 'package:flutter/material.dart';

class ConverterOutput extends StatelessWidget {
  final String output;

  const ConverterOutput(this.output, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(output),
    );
  }
}