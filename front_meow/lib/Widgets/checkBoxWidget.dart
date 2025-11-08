import 'package:flutter/material.dart';
import 'package:front_meow/colors/colors.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: Center(
          child: Checkboxwidget(
            text: "Aceito os termos e condições",
            initialValue: false,
            corText: new CatColors(paleta: 2).secundaria,
            onChange: (bool? value) {
              null;
            },
          ),
        ),
      ),
    ),
  );
}

class Checkboxwidget extends StatefulWidget {
  final String text;
  final bool initialValue;
  final Color corText;
  final ValueChanged<bool?> onChange;

  const Checkboxwidget({
    super.key,
    required this.corText,
    required this.text,
    required this.initialValue,
    required this.onChange,
  });

  @override
  State<StatefulWidget> createState() {
    return _CheckboxwidgetState();
  }
}

class _CheckboxwidgetState extends State<Checkboxwidget> {
  late bool isChecked;

  @override
  void initState() {
    super.initState();
    isChecked = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Checkbox(
          value: isChecked,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          onChanged: (bool? value) {
            setState(() {
              isChecked = value ?? false;
            });
            widget.onChange(value);
          },
          side: BorderSide(color: Colors.grey.shade700, width: 1.5),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        const SizedBox(width: 8),
        Expanded(child: Text(widget.text)),
      ],
    );
  }
}
