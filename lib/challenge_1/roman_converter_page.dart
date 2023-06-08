import 'package:flutter/material.dart';
import 'package:rota_das_oficinas_test/challenge_1/converter_output.dart';
import 'package:rota_das_oficinas_test/challenge_1/roman_numeral_converter.dart';

class RomanConverterPage extends StatefulWidget {
  const RomanConverterPage({Key? key}) : super(key: key);

  @override
  State<RomanConverterPage> createState() => _RomanConverterPageState();
}

class _RomanConverterPageState extends State<RomanConverterPage> {
  final _controller = TextEditingController();

  var _output = 'Saída';
  String? _inputError;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Conversor de números romanos')),
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 32),
          constraints: const BoxConstraints(maxWidth: 600),
          child: Column(
            children: [
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  label: const Text('Entrada'),
                  border: const OutlineInputBorder(),
                  errorText: _inputError,
                ),
              ),
              Container(
                height: 64,
                margin: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(child: _toRomanButton()),
                    const SizedBox(width: 16),
                    Expanded(child: _toDecimalButton())
                  ],
                ),
              ),
              ConverterOutput(_output),
            ],
          ),
        ),
      ),
    );
  }

  FilledButton _toDecimalButton() {
    return FilledButton.tonal(
      onPressed: _onPressToDecimal,
      child: const Text('Converter para decimal'),
    );
  }

  FilledButton _toRomanButton() {
    return FilledButton(
      onPressed: _onPressToRoman,
      child: const Text('Converter para romano'),
    );
  }

  void _onPressToDecimal() {
    final value = _controller.text;
    final isRoman = value.characters.every(
      (char) => RomanNumeralsConverter.romanValues.keys.contains(char),
    );
    if (isRoman) {
      setState(() {
        _output = RomanNumeralsConverter.toDecimal(value).toString();
        _inputError = null;
      });
    } else {
      setState(() {
        _inputError = 'Digite um número romano válido';
      });
    }
  }

  void _onPressToRoman() {
    final value = _controller.text;
    try {
      final valueNumber = int.parse(value);
      setState(() {
        _output = RomanNumeralsConverter.toRoman(valueNumber).toString();
        _inputError = null;
      });
    } on FormatException catch (_) {
      setState(() {
        _inputError = 'Digite um número inteiro entre 1 e 3999';
      });
    }
  }
}
