import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rota_das_oficinas_test/challenge_3/data/bill_entry.dart';
import 'package:rota_das_oficinas_test/challenge_3/data/client.dart';
import 'package:rota_das_oficinas_test/challenge_3/ui/bill_splitter_bloc.dart';
import 'package:rota_das_oficinas_test/challenge_3/ui/bill_splitter_state.dart';
import 'package:rota_das_oficinas_test/challenge_3/ui/common/common_blocs.dart';
import 'package:rota_das_oficinas_test/challenge_3/ui/common/common_fields.dart';
import 'package:rota_das_oficinas_test/ui/common/amount_picker.dart';
import 'package:rota_das_oficinas_test/challenge_3/ui/entry/form/entry_form_bloc.dart';
import 'package:rota_das_oficinas_test/challenge_3/ui/entry/form/entry_form_data.dart';
import 'package:rota_das_oficinas_test/utils/context_extensions.dart';

class EntryForm extends StatelessWidget {
  final BillEntry? data;
  final VoidCallback? onSave;

  const EntryForm({
    Key? key,
    this.data,
    this.onSave,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocProvider(
          create: (context) => EntryFormBloc()..init(data),
          child: BlocBuilder<EntryFormBloc, EntryFormData>(
            builder: (context, state) => _formContent(context, state),
          ),
        ),
      ),
    );
  }

  Row _formContent(BuildContext context, EntryFormData state) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AmountPicker(
          input: state.productAmount,
          onDecrement: () => context.formBloc.decrementAmount(),
          onIncrement: () => context.formBloc.incrementAmount(),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _nameField(state, context),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: _clientChips(state, context),
                ),
              ],
            ),
          ),
        ),
        _valueField(context, state),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: _clientsDropdown(state),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: FilledButton(
            onPressed: state.isValid ? () => _save(context, state) : null,
            child: const Text('Salvar'),
          ),
        )
      ],
    );
  }

  Widget _clientsDropdown(EntryFormData state) {
    return BlocBuilder<BillSplitterBloc, BillSplitterState>(
      builder: (context, billState) => PopupMenuButton<Set<Client>>(
        shape: const RoundedRectangleBorder(),
        surfaceTintColor: context.secondaryContainer,
        icon: const Icon(Icons.person_add),
        enabled: billState.clients.difference(state.clients.value).isNotEmpty,
        itemBuilder: (context) => [
          PopupMenuItem<Set<Client>>(
            value: billState.clients.difference(state.clients.value),
            child: const Text('Todos'),
            onTap: () => context.formBloc.addClients(
              billState.clients.difference(state.clients.value),
            ),
          ),
          ...billState.clients
              .difference(state.clients.value)
              .map((client) => _clientMenuItem(context, client))
              .toList()
        ],
      ),
    );
  }

  PopupMenuItem<Set<Client>> _clientMenuItem(
    BuildContext context,
    Client client,
  ) {
    return PopupMenuItem<Set<Client>>(
      value: {client},
      child: Text(client.name),
      onTap: () => context.formBloc.addClients({client}),
    );
  }

  SizedBox _valueField(BuildContext context, EntryFormData state) {
    return SizedBox(
      width: 120,
      child: AppTextField(
        label: 'Valor',
        prefixIcon: const Icon(Icons.attach_money),
        input: state.productValue,
        onChanged: (value) => context.formBloc.changeProductValue(value),
      ),
    );
  }

  AppTextField _nameField(EntryFormData state, BuildContext context) {
    return AppTextField(
      label: 'Nome do produto',
      autofocus: true,
      input: state.productName,
      onChanged: (name) => context.formBloc.changeProductName(name),
    );
  }

  Wrap _clientChips(EntryFormData state, BuildContext context) {
    return Wrap(
      spacing: 8,
      children: [...state.clients.value.map((c) => _clientChip(c, context))],
    );
  }

  Chip _clientChip(Client c, BuildContext context) {
    return Chip(
      label: Text(c.name),
      deleteIcon: const Icon(Icons.close),
      onDeleted: () => context.formBloc.removeClient(c),
    );
  }

  void _save(BuildContext context, EntryFormData state) {
    context.splitterBloc.saveEntry(state.entry, old: data);
    onSave?.call();
  }
}

extension on BuildContext {
  EntryFormBloc get formBloc => read<EntryFormBloc>();
}
