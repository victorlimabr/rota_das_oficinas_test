import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:rota_das_oficinas_test/challenge_3/ui/common/common_inputs.dart';

class AppTextField extends StatelessWidget {
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmit;
  final String label;
  final FormzInput<String, FormInputError> input;
  final Icon? prefixIcon;
  final bool autofocus;

  const AppTextField({
    Key? key,
    this.onChanged,
    required this.label,
    required this.input,
    this.prefixIcon,
    this.onSubmit,
    this.autofocus = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: input.value,
      onChanged: onChanged,
      onFieldSubmitted: onSubmit,
      autofocus: autofocus,
      decoration: InputDecoration(
        label: Text(label),
        errorText: input.displayError?.text,
        prefixIcon: prefixIcon,
      ),
    );
  }
}
