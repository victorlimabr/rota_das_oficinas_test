import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:rota_das_oficinas_test/challenge_3/data/client.dart';
import 'package:rota_das_oficinas_test/challenge_3/ui/common/common_inputs.dart';

class ClientFormBloc extends Cubit<ClientFormData> {
  ClientFormBloc() : super(const ClientFormData());

  void init(Client? client) {
    if (client != null) {
      emit(state.copyWith(
        name: RequiredStringInput.dirty(client.name),
        serviceCharge: BoolInput.dirty(client.serviceCharge),
      ));
    }
  }

  void changeName(String name) {
    emit(state.copyWith(name: RequiredStringInput.dirty(name)));
  }

  void changeServiceCharge(bool serviceCharge) {
    emit(state.copyWith(
      serviceCharge: BoolInput.dirty(serviceCharge),
    ));
  }
}

class ClientFormData with FormzMixin {
  final RequiredStringInput name;
  final BoolInput serviceCharge;

  const ClientFormData({
    this.name = const RequiredStringInput.pure(),
    this.serviceCharge = const BoolInput.pure(),
  });

  @override
  List<FormzInput> get inputs => [name, serviceCharge];

  Client get client => Client(name.value, serviceCharge: serviceCharge.value);

  ClientFormData copyWith({
    RequiredStringInput? name,
    BoolInput? serviceCharge,
  }) {
    return ClientFormData(
      name: name ?? this.name,
      serviceCharge: serviceCharge ?? this.serviceCharge,
    );
  }
}
