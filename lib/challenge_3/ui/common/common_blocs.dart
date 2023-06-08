import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rota_das_oficinas_test/challenge_3/ui/bill_splitter_bloc.dart';

class EditableItemBloc extends Cubit<bool> {
  EditableItemBloc() : super(false);

  void edit() => emit(true);

  void finish() => emit(false);
}


extension CommonBlocs on BuildContext {
  EditableItemBloc get editBloc => read<EditableItemBloc>();

  BillSplitterBloc get splitterBloc => read<BillSplitterBloc>();
}