import 'package:formz/formz.dart';
import 'package:rota_das_oficinas_test/challenge_3/ui/common/common_inputs.dart';

enum PositiveAmountErrorCause { isZero }

class PositiveAmountError extends FormInputError {
  const PositiveAmountError.isZero() : super(PositiveAmountErrorCause.isZero);

  @override
  String? get text {
    if (cause == PositiveAmountErrorCause.isZero) {
      return 'Não pode ser zero';
    }
    return null;
  }
}

class PositiveAmountInput extends FormzInput<int, PositiveAmountError> {
  const PositiveAmountInput.pure() : super.pure(1);

  const PositiveAmountInput.dirty(super.value) : super.dirty();

  @override
  PositiveAmountError? validator(int value) {
    if (value == 0) return const PositiveAmountError.isZero();
    return null;
  }
}
