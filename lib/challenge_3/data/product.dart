import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String name;
  final double value;

  const Product({required this.name, required this.value});

  @override
  List<Object?> get props => [name, value];
}
