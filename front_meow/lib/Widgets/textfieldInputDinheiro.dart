import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CurrencyInputController extends TextEditingController {
  final NumberFormat _formatter =
      NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
  double _rawValue = 0.0;

  
  CurrencyInputController({double initialValue = 0.0}) {
    _rawValue = initialValue;
    text = _formatter.format(_rawValue);
    selection = TextSelection.fromPosition(TextPosition(offset: text.length));
  }

  double get doubleValue => _rawValue;

  @override
  set value(TextEditingValue newValue) {
    String newText = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    if (newText.isEmpty) {
      newText = '0';
    }

    _rawValue = double.parse(newText) / 100;

    String formattedText = _formatter.format(_rawValue);

    super.value = TextEditingValue(
      text: formattedText,
      selection: TextSelection.fromPosition(
        TextPosition(offset: formattedText.length),
      ),
    );
  }
}