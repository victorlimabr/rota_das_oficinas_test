import 'package:rota_das_oficinas_test/challenge_3/ui/common/common_inputs.dart';

class ProductValueInput extends RequiredStringInput {
  const ProductValueInput.pure() : super.pure();

  const ProductValueInput.dirty(super.name) : super.dirty();

  @override
  RequiredInputError? validator(String value) {
    final valueReg = RegExp(r'^\d+[,.]?\d*$');
    if (!valueReg.hasMatch(value)) {
      return const ProductValueError.invalidFormat();
    }
    return super.validator(value);
  }
}

enum ProductValueErrorCause { invalidFormat }

class ProductValueError extends RequiredInputError {
  const ProductValueError.invalidFormat()
      : super(ProductValueErrorCause.invalidFormat);

  @override
  String? get text {
    if (cause == ProductValueErrorCause.invalidFormat) {
      return 'Valor inválido';
    }
    return super.text;
  }
}
