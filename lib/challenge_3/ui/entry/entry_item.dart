import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rota_das_oficinas_test/challenge_3/data/bill_entry.dart';
import 'package:rota_das_oficinas_test/challenge_3/ui/common/common_blocs.dart';
import 'package:rota_das_oficinas_test/challenge_3/ui/entry/form/entry_form.dart';
import 'package:rota_das_oficinas_test/utils/context_extensions.dart';

class EntryItem extends StatelessWidget {
  final BillEntry entry;

  const EntryItem(this.entry, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditableItemBloc(),
      child: BlocBuilder<EditableItemBloc, bool>(
        builder: (context, editing) => _itemBody(context, editing),
      ),
    );
  }

  Widget _itemBody(BuildContext context, bool editing) {
    if (editing) return _editableBody(context);
    return Row(
      children: [
        Expanded(child: _EntryItemTile(entry)),
        IconButton(
          onPressed: () => context.editBloc.edit(),
          icon: const Icon(Icons.edit),
        ),
        IconButton(
          onPressed: () => context.splitterBloc.deleteEntry(entry),
          icon: const Icon(Icons.delete),
        ),
      ],
    );
  }

  Row _editableBody(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: EntryForm(
            data: entry,
            onSave: () => context.editBloc.finish(),
          ),
        ),
        TextButton(
          onPressed: () => context.editBloc.finish(),
          child: const Text('Cancelar'),
        ),
      ],
    );
  }
}

class _EntryItemTile extends StatelessWidget {
  final BillEntry entry;

  const _EntryItemTile(this.entry, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        height: 40,
        width: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: context.secondaryContainer,
        ),
        child: Text('${entry.amount}x'),
      ),
      title: Text(entry.product.name),
      trailing: Text(
        '\$ ${entry.product.value.toStringAsFixed(2)}',
        style: context.bodyMedium,
      ),
      subtitle: Wrap(
        spacing: 8,
        children: entry.clients.map((c) => Chip(label: Text(c.name))).toList(),
      ),
    );
  }
}
