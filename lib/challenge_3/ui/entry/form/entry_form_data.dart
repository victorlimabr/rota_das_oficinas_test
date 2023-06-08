import 'package:formz/formz.dart';
import 'package:rota_das_oficinas_test/challenge_3/data/bill_entry.dart';
import 'package:rota_das_oficinas_test/challenge_3/data/client.dart';
import 'package:rota_das_oficinas_test/challenge_3/data/product.dart';
import 'package:rota_das_oficinas_test/challenge_3/ui/common/common_inputs.dart';
import 'package:rota_das_oficinas_test/challenge_3/ui/entry/form/input/product_amount_input.dart';
import 'package:rota_das_oficinas_test/challenge_3/ui/entry/form/input/product_value_input.dart';

class EntryFormData with FormzMixin {
  final RequiredStringInput productName;
  final ProductValueInput productValue;
  final PositiveAmountInput productAmount;
  final RequiredSetInput<Client> clients;

  const EntryFormData({
    this.productName = const RequiredStringInput.pure(),
    this.productValue = const ProductValueInput.pure(),
    this.productAmount = const PositiveAmountInput.pure(),
    this.clients = const RequiredSetInput.pure(),
  });

  @override
  List<FormzInput> get inputs => [
        productName,
        productValue,
        productAmount,
        clients,
      ];

  BillEntry get entry => BillEntry(
        product: Product(
          name: productName.value,
          value: double.parse(productValue.value),
        ),
        amount: productAmount.value,
        clients: clients.value,
      );

  EntryFormData copyWith({
    RequiredStringInput? productName,
    ProductValueInput? productValue,
    PositiveAmountInput? productAmount,
    RequiredSetInput<Client>? clients,
  }) {
    return EntryFormData(
      productName: productName ?? this.productName,
      productValue: productValue ?? this.productValue,
      productAmount: productAmount ?? this.productAmount,
      clients: clients ?? this.clients,
    );
  }
}
