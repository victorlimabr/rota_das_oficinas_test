import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rota_das_oficinas_test/challenge_3/ui/bill_splitter_bloc.dart';
import 'package:rota_das_oficinas_test/challenge_3/ui/bill_splitter_state.dart';
import 'package:rota_das_oficinas_test/challenge_3/ui/client/clients_section.dart';
import 'package:rota_das_oficinas_test/challenge_3/ui/client_bill_result.dart';
import 'package:rota_das_oficinas_test/challenge_3/ui/entry/entries_section.dart';
import 'package:rota_das_oficinas_test/utils/context_extensions.dart';

class BillSplitterPage extends StatelessWidget {
  const BillSplitterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Divisor de conta de restaurante')),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
        child: SingleChildScrollView(
          child: BlocProvider(
            create: (context) => BillSplitterBloc(),
            child: BlocBuilder<BillSplitterBloc, BillSplitterState>(
              builder: (context, state) {
                return Wrap(
                  spacing: 32,
                  children: [
                    _billForms(context, state),
                    Visibility(
                      visible: state.clients.isNotEmpty,
                      child: _clientBills(context, state),
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Column _clientBills(BuildContext context, BillSplitterState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Resutados', style: context.titleLarge),
        Wrap(
          children: [...state.results.map((b) => ClientBillResult(bill: b))],
        ),
      ],
    );
  }

  ConstrainedBox _billForms(BuildContext context, BillSplitterState state) {
    final media = MediaQuery.of(context);
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: max(600, media.size.width / 2)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ClientsSection(state: state),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 24),
            child: Divider(),
          ),
          Visibility(
            visible: state.clients.isNotEmpty,
            child: EntriesSection(state: state),
          )
        ],
      ),
    );
  }
}
