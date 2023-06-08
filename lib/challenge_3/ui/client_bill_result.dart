import 'package:flutter/material.dart';
import 'package:rota_das_oficinas_test/challenge_3/data/client_bill.dart';
import 'package:rota_das_oficinas_test/utils/context_extensions.dart';

class ClientBillResult extends StatelessWidget {
  final ClientBill bill;

  const ClientBillResult({Key? key, required this.bill}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Conta do (a) ${bill.client.name}',
              style: context.titleMedium,
            ),
            DataTable(
                columnSpacing: 12,
                horizontalMargin: 0,
                dataTextStyle: context.labelSmall,
                headingTextStyle: context.labelSmall,
                dataRowMaxHeight: 48,
                dataRowMinHeight: 24,
                columns: const [
                  DataColumn(label: Text('Quant.')),
                  DataColumn(label: Text('Produto.')),
                  DataColumn(label: Text('Val. Un.')),
                  DataColumn(label: Text('Val. Total.')),
                ],
                rows: bill.entries.map((e) => e.dataRow).toList()),
            _totalProductsRow(),
            _serviceChargeRow(),
            _totalRow(),
          ],
        ),
      ),
    );
  }

  Row _totalProductsRow() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(width: 200, child: Text('Total de produtos:')),
        Text('\$ ${bill.totalProducts.toStringAsFixed(2)}')
      ],
    );
  }

  Row _serviceChargeRow() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(width: 200, child: Text('Taxa de serviço:')),
        Text('\$ ${bill.serviceCharge?.toStringAsFixed(2) ?? 'Não aplicada'}')
      ],
    );
  }

  Row _totalRow() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(width: 200, child: Text('Total:')),
        Text('\$ ${bill.total.toStringAsFixed(2)}')
      ],
    );
  }
}

extension on ClientEntry {
  DataRow get dataRow => DataRow(cells: [
        DataCell(Text(amount.toStringAsFixed(2))),
        DataCell(Text(product.name)),
        DataCell(Text('\$ ${product.value.toStringAsFixed(2)}')),
        DataCell(Text('\$ ${total.toStringAsFixed(2)}')),
      ]);
}
