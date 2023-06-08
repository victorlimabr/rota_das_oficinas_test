import 'package:flutter/material.dart';
import 'package:rota_das_oficinas_test/challenge_3/ui/bill_splitter_state.dart';
import 'package:rota_das_oficinas_test/challenge_3/ui/common/common_blocs.dart';
import 'package:rota_das_oficinas_test/challenge_3/ui/common/empty_message.dart';
import 'package:rota_das_oficinas_test/challenge_3/ui/entry/form/entry_form.dart';
import 'package:rota_das_oficinas_test/challenge_3/ui/entry/entry_item.dart';
import 'package:rota_das_oficinas_test/utils/context_extensions.dart';

class EntriesSection extends StatelessWidget {
  final BillSplitterState state;

  const EntriesSection({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Produtos', style: context.titleLarge),
        Visibility(visible: state.entries.isNotEmpty, child: _entryList()),
        Visibility(
          visible: state.entries.isEmpty && !state.editEntry,
          child: const EmptyMessage(
            message: 'Agora você pode adicionar os produtos',
          ),
        ),
        Visibility(
          visible: state.editEntry,
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: EntryForm(),
          ),
        ),
        Text(
          'Total: \$ ${state.total.toStringAsFixed(2)}',
          style: context.bodyLarge,
        ),
        Visibility(
          visible: state.clients.isNotEmpty,
          child: Center(child: _addEntryButton(context)),
        ),
      ],
    );
  }

  Widget _addEntryButton(BuildContext context) {
    return SizedBox(
      height: 40,
      child: FilledButton.icon(
        icon: const Icon(Icons.add),
        label: const Text('Adicionar produto'),
        onPressed:
            state.editEntry ? null : () => context.splitterBloc.newEntry(),
      ),
    );
  }

  Card _entryList() {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: ListView.builder(
        itemCount: state.entries.length,
        shrinkWrap: true,
        itemBuilder: (context, i) => EntryItem(state.entries.elementAt(i)),
      ),
    );
  }
}
