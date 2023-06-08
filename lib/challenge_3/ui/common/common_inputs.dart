import 'package:formz/formz.dart';

abstract class FormInputError {
  final Enum cause;

  const FormInputError(this.cause);

  String? get text;
}

class RequiredInputError extends FormInputError {
  const RequiredInputError(super.cause);

  const RequiredInputError.isEmpty() : super(RequiredInputCauseError.isEmpty);

  @override
  String? get text {
    if (cause == RequiredInputCauseError.isEmpty) {
      return 'Campo obrigatório';
    }
    return null;
  }
}

enum RequiredInputCauseError { isEmpty }

class RequiredStringInput extends FormzInput<String, RequiredInputError> {
  const RequiredStringInput.pure() : super.pure('');

  const RequiredStringInput.dirty(String name) : super.dirty(name);

  @override
  RequiredInputError? validator(String value) {
    if (value.trim().isEmpty) return const RequiredInputError.isEmpty();
    return null;
  }
}

class RequiredSetInput<T> extends FormzInput<Set<T>, RequiredInputError> {
  const RequiredSetInput.pure() : super.pure(const {});

  const RequiredSetInput.dirty(Set<T> value) : super.dirty(value);

  @override
  RequiredInputError? validator(Set<T> value) {
    if (value.isEmpty) return const RequiredInputError.isEmpty();
    return null;
  }
}

class BoolInput extends FormzInput<bool, void> {
  const BoolInput.pure() : super.pure(true);

  const BoolInput.dirty(bool checked) : super.dirty(checked);

  @override
  void validator(bool value) {}
}