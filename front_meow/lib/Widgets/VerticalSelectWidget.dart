
import 'package:flutter/material.dart';
import 'package:front_meow/colors/colors.dart';

class Verticalselectwidget<T> extends StatelessWidget {
  final T value;
  final T? groupValue;
  final String label;
  final ValueChanged<T?> onChanged;
  final CatColors cores;

  const Verticalselectwidget({
    super.key,
    required this.value,
    required this.groupValue,
    required this.label,
    required this.onChanged,
    required this.cores,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChanged(value);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Radio<T>(
            value: value,
            groupValue: groupValue,
            onChanged: onChanged,
            activeColor: cores.corTerciaria,
            fillColor: MaterialStateProperty.resolveWith<Color>((states) {
              if (states.contains(MaterialState.selected)) {
                return cores.corTerciaria; 
              }
              return cores.complementar; 
            }),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: cores.corComplementar, 
            ),
          ),
        ],
      ),
    );
  }
}