import 'package:flutter/material.dart';
import 'package:rota_das_oficinas_test/challenge_3/ui/bill_splitter_state.dart';
import 'package:rota_das_oficinas_test/challenge_3/ui/client/form/client_form.dart';
import 'package:rota_das_oficinas_test/challenge_3/ui/client/client_item.dart';
import 'package:rota_das_oficinas_test/challenge_3/ui/common/common_blocs.dart';
import 'package:rota_das_oficinas_test/challenge_3/ui/common/empty_message.dart';
import 'package:rota_das_oficinas_test/utils/context_extensions.dart';

class ClientsSection extends StatelessWidget {
  final BillSplitterState state;

  const ClientsSection({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Clientes', style: context.titleLarge),
        Visibility(visible: state.clients.isNotEmpty, child: _clientList()),
        Visibility(
          visible: state.clients.isEmpty && !state.editClient,
          child: const EmptyMessage(message: 'Comece adicionando um cliente'),
        ),
        Visibility(
          visible: state.editClient,
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: ClientForm(),
          ),
        ),
        Center(child: _addClientButton(context)),
      ],
    );
  }

  Card _clientList() {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 16),
          itemCount: state.clients.length,
          shrinkWrap: true,
          itemBuilder: (context, i) => ClientItem(state.clients.elementAt(i)),
        ),
      ),
    );
  }

  SizedBox _addClientButton(BuildContext context) {
    return SizedBox(
      height: 40,
      child: FilledButton.icon(
        icon: const Icon(Icons.add),
        label: const Text('Adicionar cliente'),
        onPressed:
            state.editClient ? null : () => context.splitterBloc.newClient(),
      ),
    );
  }
}
