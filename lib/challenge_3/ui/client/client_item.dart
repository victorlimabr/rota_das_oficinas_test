import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rota_das_oficinas_test/challenge_3/data/client.dart';
import 'package:rota_das_oficinas_test/challenge_3/ui/client/form/client_form.dart';
import 'package:rota_das_oficinas_test/challenge_3/ui/common/common_blocs.dart';
import 'package:rota_das_oficinas_test/utils/context_extensions.dart';

class ClientItem extends StatelessWidget {
  final Client client;

  const ClientItem(this.client, {Key? key}) : super(key: key);

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
    if (editing) return _editingBody(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: context.secondaryContainer)),
      ),
      child: Row(
        children: [
          Expanded(child: _ClientItemTile(client)),
          IconButton(
            onPressed: () => context.editBloc.edit(),
            icon: const Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () => context.splitterBloc.deleteClient(client),
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
    );
  }

  Row _editingBody(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ClientForm(
            data: client,
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

class _ClientItemTile extends StatelessWidget {
  final Client client;

  const _ClientItemTile(this.client, {Key? key}) : super(key: key);

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
        child: Text(client.name.characters.first),
      ),
      title: Text(client.name),
      trailing: SizedBox(
        width: 162,
        child: Row(
          children: [
            const Text('Cobrar taxa de serviço'),
            Checkbox(value: client.serviceCharge, onChanged: null),
          ],
        ),
      ),
    );
  }
}
