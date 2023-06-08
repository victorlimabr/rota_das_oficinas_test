import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rota_das_oficinas_test/challenge_3/data/bill_entry.dart';
import 'package:rota_das_oficinas_test/challenge_3/data/client.dart';
import 'package:rota_das_oficinas_test/challenge_3/ui/common/common_inputs.dart';
import 'package:rota_das_oficinas_test/challenge_3/ui/entry/form/entry_form_data.dart';
import 'package:rota_das_oficinas_test/challenge_3/ui/entry/form/input/product_amount_input.dart';
import 'package:rota_das_oficinas_test/challenge_3/ui/entry/form/input/product_value_input.dart';

class EntryFormBloc extends Cubit<EntryFormData> {
  EntryFormBloc() : super(const EntryFormData());

  void init(BillEntry? entry) {
    if (entry != null) {
      emit(state.copyWith(
        productName: RequiredStringInput.dirty(entry.product.name),
        productAmount: PositiveAmountInput.dirty(entry.amount),
        clients: RequiredSetInput.dirty(entry.clients),
        productValue: ProductValueInput.dirty(
          entry.product.value.toStringAsFixed(2),
        ),
      ));
    }
  }

  void changeProductName(String name) {
    emit(state.copyWith(productName: RequiredStringInput.dirty(name)));
  }

  void changeProductValue(String value) {
    emit(state.copyWith(productValue: ProductValueInput.dirty(value)));
  }

  void incrementAmount() {
    _changeAmount(state.productAmount.value + 1);
  }

  void decrementAmount() {
    _changeAmount(state.productAmount.value - 1);
  }

  void _changeAmount(int amount) {
    emit(state.copyWith(productAmount: PositiveAmountInput.dirty(amount)));
  }

  void removeClient(Client client) {
    final clients = RequiredSetInput.dirty(
      state.clients.value.where((c) => c != client).toSet(),
    );
    emit(state.copyWith(clients: clients));
  }

  void addClients(Set<Client> client) {
    final clients = RequiredSetInput.dirty({...state.clients.value, ...client});
    emit(state.copyWith(clients: clients));
  }
}
