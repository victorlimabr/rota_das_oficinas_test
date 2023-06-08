import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rota_das_oficinas_test/challenge_3/data/client.dart';
import 'package:rota_das_oficinas_test/challenge_3/ui/client/form/client_form_bloc.dart';
import 'package:rota_das_oficinas_test/challenge_3/ui/common/common_blocs.dart';
import 'package:rota_das_oficinas_test/challenge_3/ui/common/common_fields.dart';

class ClientForm extends StatelessWidget {
  final Client? data;
  final VoidCallback? onSave;

  const ClientForm({Key? key, this.data, this.onSave}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocProvider(
          create: (context) => ClientFormBloc()..init(data),
          child: BlocBuilder<ClientFormBloc, ClientFormData>(
            builder: (context, state) => Row(
              children: [
                Expanded(flex: 2, child: _nameField(context, state)),
                Expanded(flex: 1, child: _chargeCheckbox(context, state)),
                FilledButton(
                  onPressed: state.isValid ? () => _save(context, state) : null,
                  child: const Text('Salvar'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  CheckboxListTile _chargeCheckbox(BuildContext context, ClientFormData state) {
    return CheckboxListTile(
      value: state.serviceCharge.value,
      title: const Text('Cobrar taxa de serviço', textAlign: TextAlign.end),
      onChanged: (checked) => context.formBloc.changeServiceCharge(checked!),
    );
  }

  AppTextField _nameField(BuildContext context, ClientFormData state) {
    return AppTextField(
      label: 'Nome do cliente',
      input: state.name,
      autofocus: true,
      onSubmit: state.isValid ? (_) => _save(context, state) : null,
      onChanged: (name) => context.formBloc.changeName(name),
    );
  }

  void _save(BuildContext context, ClientFormData state) {
    context.splitterBloc.saveClient(state.client, old: data);
    onSave?.call();
  }
}

extension on BuildContext {
  ClientFormBloc get formBloc => read<ClientFormBloc>();
}
