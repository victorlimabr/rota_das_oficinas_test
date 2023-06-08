import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rota_das_oficinas_test/challenge_3/data/bill_entry.dart';
import 'package:rota_das_oficinas_test/challenge_3/data/client.dart';
import 'package:rota_das_oficinas_test/challenge_3/ui/bill_splitter_state.dart';

class BillSplitterBloc extends Cubit<BillSplitterState> {
  BillSplitterBloc() : super(const BillSplitterState());

  void newClient() {
    emit(state.copyWith(editClient: true));
  }

  void saveClient(Client client, {Client? old}) {
    emit(state.copyWith(
      clients: {...(state.clients - old), client},
      entries: state.entries.updateClient(client, old: old),
      editClient: false,
    ));
  }

  void deleteClient(Client client) {
    emit(state.copyWith(
      clients: state.clients.where((c) => c != client).toSet(),
      entries: state.entries.removeClient(client),
    ));
  }

  void newEntry() {
    emit(state.copyWith(editEntry: true));
  }

  void saveEntry(BillEntry entry, {BillEntry? old}) {
    emit(state.copyWith(
      entries: state.entries - old + entry,
      editEntry: false,
    ));
  }

  void deleteEntry(BillEntry entry) {
    emit(state.copyWith(
      entries: state.entries.where((e) => e != entry).toSet(),
    ));
  }
}

extension<T> on Set<T> {
  Set<T> operator -(T? value) {
    return where((e) => e != value).toSet();
  }
}

extension on Set<BillEntry> {
  Set<BillEntry> removeClient(Client client) {
    var entries = map(
      (e) => e.copyWith(clients: e.clients.where((c) => c != client).toSet()),
    );
    return entries.where((e) => e.clients.isNotEmpty).toSet();
  }

  Set<BillEntry> updateClient(Client client, {Client? old}) {
    return map(
      (entry) {
        if (entry.clients.contains(old)) {
          return entry.copyWith(clients: {...(entry.clients - old), client});
        }
        return entry;
      },
    ).toSet();
  }

  Set<BillEntry> operator +(BillEntry entry) {
    var existing = firstWhereOrNull((e) => e == entry);
    if (existing != null) {
      return {...this, existing + entry};
    }
    return {...this, entry};
  }
}
