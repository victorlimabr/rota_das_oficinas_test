import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:rota_das_oficinas_test/challenge_3/ui/common/common_inputs.dart';

class AmountPicker extends StatelessWidget {
  final FormzInput<int, FormInputError> input;
  final VoidCallback? onIncrement;
  final VoidCallback? onDecrement;
  final int minLimit;

  const AmountPicker({
    Key? key,
    required this.input,
    this.onIncrement,
    this.onDecrement,
    this.minLimit = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 58,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton.outlined(
            onPressed: input.value > minLimit ? onDecrement : null,
            icon: const Icon(Icons.remove),
          ),
          Container(
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            alignment: Alignment.center,
            child: Text(input.value.toString()),
          ),
          IconButton.outlined(
            onPressed: onIncrement,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
