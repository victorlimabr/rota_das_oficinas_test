import 'package:equatable/equatable.dart';
import 'package:rota_das_oficinas_test/challenge_3/data/client.dart';
import 'package:rota_das_oficinas_test/challenge_3/data/product.dart';

class ClientBill extends Equatable {
  final Client client;
  final Set<ClientEntry> entries;

  const ClientBill({required this.client, this.entries = const {}});

  @override
  List<Object?> get props => [client];

  double get totalProducts => entries.fold(0.0, (total, e) => total + e.total);

  double get total => totalProducts + (serviceCharge ?? 0);

  double? get serviceCharge =>
      client.serviceCharge ? totalProducts * 0.1 : null;
}

class ClientEntry extends Equatable {
  final Product product;
  final double amount;

  const ClientEntry({required this.product, this.amount = 1});

  @override
  List<Object?> get props => [product];

  double get total => amount * product.value;
}
