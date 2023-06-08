import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:rota_das_oficinas_test/challenge_3/data/bill_entry.dart';
import 'package:rota_das_oficinas_test/challenge_3/data/client.dart';
import 'package:rota_das_oficinas_test/challenge_3/data/client_bill.dart';
import 'package:rota_das_oficinas_test/challenge_3/ui/common/common_inputs.dart';

class BillSplitterState extends Equatable {
  final FormzSubmissionStatus status;
  final FormInputError? error;
  final Set<Client> clients;
  final Set<BillEntry> entries;
  final bool editClient;
  final bool editEntry;

  const BillSplitterState({
    this.status = FormzSubmissionStatus.initial,
    this.error,
    this.clients = const {},
    this.entries = const {},
    this.editClient = false,
    this.editEntry = false,
  });

  double get total =>
      entries.fold(0.0, (total, e) => total + e.amount * e.product.value);

  @override
  List<Object?> get props => [
        status,
        error,
        clients,
        entries,
        editClient,
        editEntry,
      ];

  List<ClientBill> get results =>
      clients.map((client) => entries.forClient(client)).toList();

  BillSplitterState copyWith({
    FormzSubmissionStatus? status,
    FormInputError? error,
    Set<Client>? clients,
    Set<BillEntry>? entries,
    bool? editClient,
    bool? editEntry,
  }) {
    return BillSplitterState(
      status: status ?? this.status,
      error: error ?? this.error,
      clients: clients ?? this.clients,
      entries: entries ?? this.entries,
      editClient: editClient ?? this.editClient,
      editEntry: editEntry ?? this.editEntry,
    );
  }
}

extension on Set<BillEntry> {
  ClientBill forClient(Client client) {
    return ClientBill(
      client: client,
      entries: where((entry) => entry.clients.contains(client))
          .map((entry) => entry.toClientEntry())
          .toSet(),
    );
  }
}

extension on BillEntry {
  ClientEntry toClientEntry() =>
      ClientEntry(product: product, amount: amount / clients.length);
}
