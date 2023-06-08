import 'package:equatable/equatable.dart';

class Client extends Equatable {
  final String name;
  final bool serviceCharge;

  const Client(this.name, {this.serviceCharge = true});

  @override
  List<Object?> get props => [name, serviceCharge];
}